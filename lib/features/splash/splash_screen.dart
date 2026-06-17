import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:super_system/features/login/login_screen.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/storage_service.dart';
import '../../core/widgets/main_shell_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // ── Logo entrance ──────────────────────────────────────────────
  late final AnimationController _logoController;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;

  // ── Glow pulse ─────────────────────────────────────────────────
  late final AnimationController _glowController;
  late final Animation<double> _glowPulse;

  // ── Text / subtitle entrance ───────────────────────────────────
  late final AnimationController _textController;
  late final Animation<double> _textOpacity;
  late final Animation<Offset> _textSlide;

  // ── Loading bar ────────────────────────────────────────────────
  late final AnimationController _loadingController;
  late final Animation<double> _loadingProgress;

  // ── Version badge ──────────────────────────────────────────────
  late final AnimationController _versionController;
  late final Animation<double> _versionOpacity;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    _setupAnimations();
    _playAnimationSequence();
    Future.delayed(const Duration(seconds: 3), () async {
      final token = await StorageService().getSecure(
        StorageService.keyUserToken,
      );
      if (!mounted) return;

      if (token != null && token.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainShellScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  void _setupAnimations() {
    // Logo
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoScale = Tween<double>(begin: 0.55, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    // Glow pulse (loops)
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _glowPulse = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    // Text
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _textOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    // Loading bar
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _loadingProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _loadingController, curve: Curves.easeInOut),
    );

    // Version badge
    _versionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _versionOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _versionController, curve: Curves.easeIn),
    );
  }

  Future<void> _playAnimationSequence() async {
    await Future.delayed(const Duration(milliseconds: 200));
    await _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    _textController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _loadingController.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    _versionController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _glowController.dispose();
    _textController.dispose();
    _loadingController.dispose();
    _versionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceContainerLowest,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Background radial glow ──────────────────────────────
          _BackgroundGlow(glowPulse: _glowPulse),

          // ── Main content ────────────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 3),

                // Logo container
                _AnimatedLogo(
                  logoScale: _logoScale,
                  logoOpacity: _logoOpacity,
                  glowPulse: _glowPulse,
                ),

                SizedBox(height: 36),

                // Title + subtitle
                FadeTransition(
                  opacity: _textOpacity,
                  child: SlideTransition(
                    position: _textSlide,
                    child: const _AppTitleSection(),
                  ),
                ),

                const SizedBox(height: 28),

                // Loading bar
                FadeTransition(
                  opacity: _textOpacity,
                  child: _LoadingBar(progress: _loadingProgress),
                ),

                const Spacer(flex: 4),

                // Version badge
                FadeTransition(
                  opacity: _versionOpacity,
                  child: const _VersionBadge(),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Background with radial purple glow
// ──────────────────────────────────
class _BackgroundGlow extends StatelessWidget {
  const _BackgroundGlow({required this.glowPulse});

  final Animation<double> glowPulse;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glowPulse,
      builder: (_, __) {
        return CustomPaint(painter: _GlowPainter(intensity: glowPulse.value));
      },
    );
  }
}

class _GlowPainter extends CustomPainter {
  _GlowPainter({required this.intensity});
  final double intensity;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.42);

    // Outer soft glow
    final outerPaint =
        Paint()
          ..shader = RadialGradient(
            colors: [
              AppColors.secondary.withOpacity(0.18 * intensity),
              AppColors.primary.withOpacity(0.08 * intensity),
              Colors.transparent,
            ],
            stops: const [0.0, 0.45, 1.0],
          ).createShader(
            Rect.fromCircle(center: center, radius: size.width * 0.72),
          );
    canvas.drawCircle(center, size.width * 0.72, outerPaint);

    // Inner bright core
    final innerPaint =
        Paint()
          ..shader = RadialGradient(
            colors: [
              AppColors.primary.withOpacity(0.22 * intensity),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(center: center, radius: size.width * 0.38),
          );
    canvas.drawCircle(center, size.width * 0.38, innerPaint);

    // Small scattered star dots
    final dotPaint =
        Paint()
          ..color = AppColors.outlineVariant.withOpacity(0.3 * intensity)
          ..style = PaintingStyle.fill;
    final dotPositions = [
      Offset(size.width * 0.08, size.height * 0.18),
      Offset(size.width * 0.92, size.height * 0.22),
      Offset(size.width * 0.15, size.height * 0.78),
      Offset(size.width * 0.88, size.height * 0.72),
      Offset(size.width * 0.05, size.height * 0.50),
      Offset(size.width * 0.96, size.height * 0.50),
    ];
    for (final pos in dotPositions) {
      canvas.drawCircle(pos, 2.0, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_GlowPainter old) => old.intensity != intensity;
}

// ─────────────────────────────────────────────────────────────────────────────
// Animated logo widget
// ─────────────────────────────────────────────────────────────────────────────
class _AnimatedLogo extends StatelessWidget {
  const _AnimatedLogo({
    required this.logoScale,
    required this.logoOpacity,
    required this.glowPulse,
  });

  final Animation<double> logoScale;
  final Animation<double> logoOpacity;
  final Animation<double> glowPulse;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([logoScale, logoOpacity, glowPulse]),
      builder: (_, __) {
        return Opacity(
          opacity: logoOpacity.value,
          child: Transform.scale(
            scale: logoScale.value,
            child: _LogoContainer(glowIntensity: glowPulse.value),
          ),
        );
      },
    );
  }
}

class _LogoContainer extends StatelessWidget {
  const _LogoContainer({required this.glowIntensity});

  final double glowIntensity;

  @override
  Widget build(BuildContext context) {
    const size = 130.0;
    const radius = 22.0;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: AppColors.surfaceContainerLowest,
        border: Border.all(
          color: AppColors.primary.withOpacity(0.55 * glowIntensity),
          width: 1.5,
        ),
        boxShadow: [
          // Neon outer glow
          BoxShadow(
            color: AppColors.primary.withOpacity(0.55 * glowIntensity),
            blurRadius: 40,
            spreadRadius: 6,
          ),
          BoxShadow(
            color: AppColors.secondary.withOpacity(0.35 * glowIntensity),
            blurRadius: 80,
            spreadRadius: 16,
          ),
          // Inner subtle ambient
          BoxShadow(
            color: AppColors.primary.withOpacity(0.12),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.asset(
          AppAssets.appLogo,
          fit: BoxFit.cover,
          errorBuilder:
              (_, __, ___) => _FallbackLogo(glowIntensity: glowIntensity),
        ),
      ),
    );
  }
}

/// Shown when the logo asset is missing — draws a neon "S"
class _FallbackLogo extends StatelessWidget {
  const _FallbackLogo({required this.glowIntensity});
  final double glowIntensity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surfaceContainerLowest,
            AppColors.surfaceContainerLow,
          ],
        ),
      ),
      child: Center(
        child: ShaderMask(
          shaderCallback:
              (bounds) => LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.secondary],
              ).createShader(bounds),
          child: Text(
            'S',
            style: TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: AppColors.primary.withOpacity(0.9 * glowIntensity),
                  blurRadius: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// App title + Arabic subtitle
// ─────────────────────────────────────────────────────────────────────────────
class _AppTitleSection extends StatelessWidget {
  const _AppTitleSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // "Super App"
        ShaderMask(
          shaderCallback:
              (bounds) => const LinearGradient(
                colors: [Colors.white, Color(0xFFE8D5FF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds),
          child: const Text(
            'Super System',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.5,
              height: 1.1,
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Divider row with Arabic subtitle
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _DividerLine(),
            const SizedBox(width: 12),
            const Text(
              'متابعة الطلاب بسهولة',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.onSurfaceVariant,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(width: 12),
            _DividerLine(),
          ],
        ),
      ],
    );
  }
}

class _DividerLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, AppColors.outlineVariant],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Animated loading bar
// ─────────────────────────────────────────────────────────────────────────────
class _LoadingBar extends StatelessWidget {
  const _LoadingBar({required this.progress});
  final Animation<double> progress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 56),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: progress,
            builder: (_, __) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Stack(
                  children: [
                    // Track
                    Container(
                      height: 3,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceBright.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    // Fill
                    FractionallySizedBox(
                      widthFactor: progress.value,
                      child: Container(
                        height: 3,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.secondary, AppColors.primary],
                          ),
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.7),
                              blurRadius: 6,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Version badge at the bottom
// ─────────────────────────────────────────────────────────────────────────────
class _VersionBadge extends StatelessWidget {
  const _VersionBadge();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Diamond icon
        Icon(
          Icons.diamond_outlined,
          size: 14,
          color: AppColors.primary.withOpacity(0.7),
        ),
        const SizedBox(height: 6),
        Text(
          'v 1.0 PREMIUM EDITION',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppColors.onSurfaceVariant.withOpacity(0.55),
            letterSpacing: 2.2,
          ),
        ),
      ],
    );
  }
}
