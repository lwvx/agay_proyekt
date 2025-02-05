import 'package:agay_proyekt/src/presentation/onboarding/onboarding.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.scale(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xff171717),

          Color(0xff171717),
        ],
      ),
      childWidget: SizedBox(
        height: 40.h,
        child: Image.asset("assets/images/screen.png"),
      ),
      duration: const Duration(seconds: 4),
      animationDuration: const Duration(seconds: 3),
      onAnimationEnd: () => debugPrint("On Scale End"),
      nextScreen: const Onboarding(),
    );
  }
}
