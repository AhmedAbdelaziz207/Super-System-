import 'package:flutter/material.dart';
import 'package:super_system/core/utils/app_assets.dart';

class LoginLogo extends StatefulWidget {
  const LoginLogo({super.key});

  @override
  State<LoginLogo> createState() => _LoginLogoState();
}

class _LoginLogoState extends State<LoginLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // Scale: starts small, bounces to full size
    _scaleAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    // Fade: comes in during the first half
    _fadeAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    );

    // Glow pulse: oscillates after the entrance
    _glowAnim = Tween<double>(begin: 0.4, end: 0.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnim,
          child: ScaleTransition(
            scale: _scaleAnim,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFBC13FE)
                        .withOpacity(_glowAnim.value),
                    blurRadius: 28,
                    spreadRadius: 6,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  AppAssets.appLogo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
