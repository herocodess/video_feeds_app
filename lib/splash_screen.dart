// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:video_feeds_app/presentation/screens/video_feeds_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController slideController, scaleController;

  @override
  void initState() {
    slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    );
    animate();
    super.initState();
  }

  final slideTween = Tween<Offset>(
    begin: const Offset(-3, 0),
    end: Offset.zero,
  ).chain(
    CurveTween(curve: Curves.fastOutSlowIn),
  );
  final scaleTween = Tween<double>(begin: 1.0, end: 1.3).chain(
    CurveTween(
      curve: Curves.easeInOut,
    ),
  );

  Future<void> animate() async {
    await Future.delayed(Duration.zero);
    await slideController.forward();
    await scaleController.forward();
    await scaleController.reverse();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const VideoFeedsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: scaleController.drive(scaleTween),
          child: SlideTransition(
            position: slideController.drive(slideTween),
            child: Text(
              'Video Feeds',
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
