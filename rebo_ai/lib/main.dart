import 'package:flutter/material.dart';
import './components/nav.dart';
import './components/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _currentPage = const Homepage();

  void _navigateToPage(Widget page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 32, 32, 32),
      ),
      home: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 768) {
              // Small screen - use Column with bottom navigation
              return Column(
                children: [
                  Expanded(child: _currentPage),
                  Nav(isBottomNav: true, onNavigate: _navigateToPage),
                ],
              );
            } else {
              // Large screen - use Row with side navigation
              return Row(
                children: [
                  Nav(isBottomNav: false, onNavigate: _navigateToPage),
                  Expanded(child: _currentPage),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
