import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class Header extends StatefulWidget {
  final bool play;
  Header({Key? key, required this.play}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation offsetAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    offsetAnimation =
        Tween<double>(begin: 10.0, end: 200.0).animate(controller);

    if (widget.play) {
      controller.forward();
    }
  }

  @override
  void didChangeDependencies() {
    dev.log(' didChangeDependencies' + widget.play.toString(), name: 'log');

    widget.play ? controller.forward() : controller.reverse();

    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(w) {
    super.didUpdateWidget(w);
    widget.play ? controller.forward() : controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: offsetAnimation,
        builder: (context, child) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 50,
                left: 50,
                child: Transform.translate(
                    offset: Offset(10.0, 100 * controller.value),
                    child: ColoredBox(
                        color: Color.fromARGB(255, 201, 204, 13),
                        child: SizedBox(
                          height: 15,
                          width: 15,
                        ))),
              ),
              ColoredBox(
                color: Colors.amber,
                child: SizedBox(
                  height: 15,
                  width: 15,
                ),
              ),
              Positioned(
                top: 150,
                left: 150,
                child: ColoredBox(
                    color: Color.fromARGB(255, 112, 190, 10),
                    child: SizedBox(
                      height: 15,
                      width: 15,
                    )),
              )
            ],
          );
        });
  }
}
