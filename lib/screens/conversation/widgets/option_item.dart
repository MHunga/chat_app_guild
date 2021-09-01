import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OptionItemMessage extends StatelessWidget {
  const OptionItemMessage({
    Key? key,
    required this.showPositionBottom,
    required this.showPositionLeft,
    required this.onTap,
    required this.color,
    required this.icon,
    required this.isShow,
    required this.duration,
  }) : super(key: key);
  final double showPositionBottom;
  final double showPositionLeft;
  final Function() onTap;
  final Color color;
  final String icon;
  final bool isShow;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        curve: Curves.easeInOutBack,
        duration: duration,
        bottom: isShow ? showPositionBottom : 36,
        left: isShow ? showPositionLeft : 30,
        height: isShow ? 38 : 0,
        width: isShow ? 38 : 0,
        child: AnimatedOpacity(
          duration: duration,
          opacity: isShow ? 1 : 0,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color.withOpacity(0.2)),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: SvgPicture.asset(
                  icon,
                  width: 24,
                  height: 24,
                  color: color,
                ),
              ),
            ),
          ),
        ));
  }
}
