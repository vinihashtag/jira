import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:jira_matic/app/shared/theme/app_images.dart';

class CustomLoading extends StatefulWidget {
  const CustomLoading(
      {Key? key,
      this.text = '',
      this.color = Colors.black,
      this.height = 80.0,
      this.width = 80.0})
      : super(key: key);

  final String text;
  final Color color;
  final double height;
  final double width;

  @override
  _CustomLoadingState createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _flipAnim;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _flipAnim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.linear,
        ),
      ),
    );

    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.repeat();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                  animation: _controller,
                  builder: (context, snapshot) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..rotateY(2 * pi * _flipAnim.value),
                      alignment: Alignment.center,
                      child: Image.asset(
                        AppImages.logo,
                        height: widget.height,
                        width: widget.width,
                      ),
                    );
                  }),
              if (widget.text.isNotEmpty)
                Container(
                  margin: const EdgeInsets.all(10),
                  constraints: const BoxConstraints(
                    maxWidth: 250,
                  ),
                  child: AutoSizeText(
                    widget.text,
                    maxLines: 5,
                    minFontSize: 10,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: widget.color,
                      fontWeight: widget.color == Colors.black
                          ? FontWeight.w600
                          : FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
