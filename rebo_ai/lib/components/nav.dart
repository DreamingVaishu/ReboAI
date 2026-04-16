import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  bool _isHovered = false;
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 768;

    if (isSmallScreen) {
      return Stack(
        children: [
          // Menu icon button
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 32, 32, 32),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.bars,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () => setState(() => _isMenuOpen = true),
              ),
            ),
          ),
          // Fullscreen overlay
          if (_isMenuOpen) ...[
            GestureDetector(
              onTap: () => setState(() => _isMenuOpen = false),
              child: Container(
                color: Colors.black54,
                child: Container(
                  width: 250,
                  height: double.infinity,
                  color: const Color.fromARGB(255, 32, 32, 32),
                  child: Column(
                    children: [
                      // Close button
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const FaIcon(
                                FontAwesomeIcons.xmark,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () =>
                                  setState(() => _isMenuOpen = false),
                            ),
                          ],
                        ),
                      ),
                      // Nav items
                      _buildNavItem(FontAwesomeIcons.house, 'Home', () {
                        setState(() => _isMenuOpen = false);
                        print('Home tapped');
                      }),
                      _buildNavItem(
                        FontAwesomeIcons.graduationCap,
                        'Practice',
                        () {
                          setState(() => _isMenuOpen = false);
                          print('Practice tapped');
                        },
                      ),
                      _buildNavItem(
                        FontAwesomeIcons.chartLine,
                        'Analysistic',
                        () {
                          setState(() => _isMenuOpen = false);
                          print('Analysistic tapped');
                        },
                      ),
                      _buildNavItem(
                        FontAwesomeIcons.dollarSign,
                        '  Pricing',
                        () {
                          setState(() => _isMenuOpen = false);
                          print('Pricing tapped');
                        },
                      ),
                      _buildNavItem(FontAwesomeIcons.users, 'Community', () {
                        setState(() => _isMenuOpen = false);
                        print('Community tapped');
                      }),
                      _buildNavItem(FontAwesomeIcons.circleInfo, 'About', () {
                        setState(() => _isMenuOpen = false);
                        print('About tapped');
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      );
    }

    // Desktop navbar
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: _isHovered ? 200 : 65,
        color: const Color.fromARGB(255, 32, 32, 32),
        child: Column(
          children: [
            _buildNavItem(
              FontAwesomeIcons.house,
              'Home',
              () => print('Home tapped'),
            ),
            _buildNavItem(
              FontAwesomeIcons.graduationCap,
              'Practice',
              () => print('Practice tapped'),
            ),
            _buildNavItem(
              FontAwesomeIcons.chartLine,
              'Analysistic',
              () => print('Analysistic tapped'),
            ),
            _buildNavItem(
              FontAwesomeIcons.dollarSign,
              'Pricing',
              () => print('Pricing tapped'),
            ),
            const Spacer(),
            _buildNavItem(
              FontAwesomeIcons.users,
              'Community',
              () => print('Community tapped'),
            ),
            _buildNavItem(
              FontAwesomeIcons.circleInfo,
              'About',
              () => print('About tapped'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
