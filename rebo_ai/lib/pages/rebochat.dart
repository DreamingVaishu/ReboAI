import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ReboChat extends StatefulWidget {
  const ReboChat({super.key});

  @override
  State<ReboChat> createState() => _ReboChatState();
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class _ReboChatState extends State<ReboChat> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  AnimationController? _animationController;
  Animation<int>? _dotAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _dotAnimation = StepTween(begin: 1, end: 4).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );

    _animationController!.repeat();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final message = _controller.text.trim();
    if (message.isEmpty) return;

    // Add user message to chat
    setState(() {
      _messages.add(
        ChatMessage(text: message, isUser: true, timestamp: DateTime.now()),
      );
    });

    // Clear input field
    _controller.clear();

    // Add processing message
    setState(() {
      _messages.add(
        ChatMessage(text: '...', isUser: false, timestamp: DateTime.now()),
      );
    });

    // Scroll to bottom to show processing
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': message}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Remove processing message and add AI response
        setState(() {
          _messages.removeLast(); // Remove "..." processing message
          _messages.add(
            ChatMessage(
              text: responseData['message'],
              isUser: false,
              timestamp: DateTime.now(),
            ),
          );
        });

        // Scroll to bottom
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    } catch (e) {
      // Remove processing message and add error message
      setState(() {
        _messages.removeLast(); // Remove "..." processing message
        _messages.add(
          ChatMessage(
            text: 'Error: Could not connect to AI',
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
      });
    }
  }

  // Animated processing dots
  Widget _buildProcessingDots() {
    if (_dotAnimation == null) {
      return Text('...', style: TextStyle(color: Colors.white, fontSize: 16));
    }

    return AnimatedBuilder(
      animation: _dotAnimation!,
      builder: (context, child) {
        String dots = '.' * _dotAnimation!.value;
        return Text(dots, style: TextStyle(color: Colors.white, fontSize: 16));
      },
    );
  }

  // User message bubble (right-aligned, blue)
  Widget _buildUserMessage(ChatMessage message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(161, 113, 113, 113),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(message.text, style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  // AI message bubble (left-aligned, gray)
  Widget _buildAIMessage(ChatMessage message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 69, 69, 69),
                borderRadius: BorderRadius.circular(20),
              ),
              child: message.text == '...'
                  ? _buildProcessingDots()
                  : Text(message.text, style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext home) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/background.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(0),
      // margin: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top bar with ReBoAI and Hello User
          Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'ReBo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'AI',
                  style: TextStyle(
                    color: Color.fromARGB(175, 80, 75, 152),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Welcome message
          // Chat messages area
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return message.isUser
                    ? _buildUserMessage(message)
                    : _buildAIMessage(message);
              },
            ),
          ),
          // Input area
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color.fromARGB(255, 69, 69, 69),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Ask me anything...',
                  hintStyle: TextStyle(color: Colors.white70),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
                style: TextStyle(color: Colors.white),
                onSubmitted: (_) =>
                    _sendMessage(), // Add this line for Enter key
              ),
            ),
          ),
        ],
      ),
    );
  }
}
