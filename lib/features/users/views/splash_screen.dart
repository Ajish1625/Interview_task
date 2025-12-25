import 'dart:async';
import 'package:flutter/material.dart';
import 'package:interview_task_responsive_layout/features/users/views/users_list_page.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> bounceAnim;
  late Animation<double> zoomAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // 🔹 Bounce "M"
    bounceAnim = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          0.7,
          curve: Curves.bounceOut,
        ),
      ),
    );

    // 🔹 Massive zoom to fill screen
    zoomAnim = Tween<double>(begin: 1.0, end: 20.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.7,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );

    _controller.forward();

    // ⏱ Navigate slightly BEFORE animation ends
    Timer(const Duration(milliseconds: 2700), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: Duration.zero,
          pageBuilder: (_, __, ___) => UsersListPage(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return Transform.scale(
              scale: zoomAnim.value,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// 🔤 Bouncing M
                  Transform.translate(
                    offset: Offset(0, bounceAnim.value),
                    child: const Text(
                      'M',
                      style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),

                  /// 🔤 Static text
                  const Text(
                    'inia',
                    style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
