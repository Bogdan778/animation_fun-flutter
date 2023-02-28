import 'dart:math' show pi;

import 'package:flutter/material.dart';

void main() => runApp(const AnimationApp());

class AnimationApp extends StatefulWidget {
  const AnimationApp({super.key});

  @override
  State<AnimationApp> createState() => _AnimationAppState();
}

class _AnimationAppState extends State<AnimationApp>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _animation;
  bool isStopped = false;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation = Tween<double>(begin: 0.0, end: 2 * pi).animate(controller);
    controller.repeat();
  }

  void playOrPause() {
    setState(() {
      isStopped ? controller.repeat() : controller.stop();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 140),
                  child: Center(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(_animation.value),
                      child: Center(
                        child: AnimatedBuilder(
                          animation: controller,
                          builder: (BuildContext context, Widget? child) {
                            return Center(
                              child: Container(
                                width: 100,
                                height: 100,
                                color: Colors.orange,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 300,
                ),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.orange),
                      ),
                      onPressed: () {
                        setState(() {
                          isStopped = !isStopped;
                        });
                        playOrPause();
                      },
                      child: Text(isStopped ? 'Stop' : 'Play')),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
