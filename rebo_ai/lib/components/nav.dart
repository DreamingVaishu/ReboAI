import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './homepage.dart';
import '../pages/rebochat.dart';
import '../pages/voicetalk.dart';

class NavItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  NavItem({required this.icon, required this.label, required this.onTap});
}

class Nav extends StatefulWidget {
  final bool isBottomNav;
  final Function(Widget) onNavigate;

  const Nav({super.key, this.isBottomNav = false, required this.onNavigate});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  bool _isHovered = false;

  List<NavItem> get _navItems => [
    NavItem(
      icon: FontAwesomeIcons.house,
      label: 'Home',
      onTap: () => widget.onNavigate(const Homepage()),
    ),
    NavItem(
      icon: FontAwesomeIcons.message,
      label: 'Chat',
      onTap: () => widget.onNavigate(const ReboChat()),
    ),
    NavItem(
      icon: FontAwesomeIcons.microphone,
      label: 'Talk',
      onTap: () => widget.onNavigate(const VoiceTalk()),
    ),
    NavItem(
      icon: FontAwesomeIcons.chartLine,
      label: 'Analytics',
      onTap: () => print('Analytics tapped'),
    ),
    NavItem(
      icon: FontAwesomeIcons.dollarSign,
      label: 'Pricing',
      onTap: () => print('Pricing tapped'),
    ),
    NavItem(
      icon: FontAwesomeIcons.users,
      label: 'Community',
      onTap: () => print('Community tapped'),
    ),
    NavItem(
      icon: FontAwesomeIcons.circleInfo,
      label: 'About',
      onTap: () => print('About tapped'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.isBottomNav) {
      return _buildBottomNavigationBar();
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
            ..._navItems
                .take(4)
                .map(
                  (item) => _buildNavItem(item.icon, item.label, item.onTap),
                ),
            const Spacer(),
            ..._navItems
                .skip(4)
                .map(
                  (item) => _buildNavItem(item.icon, item.label, item.onTap),
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

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 70,
      color: const Color.fromARGB(255, 32, 32, 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _navItems
            .take(4)
            .map(
              (item) => _buildBottomNavItem(item.icon, item.label, item.onTap),
            )
            .toList(),
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(icon, color: Colors.white, size: 20),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
