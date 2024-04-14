import 'package:flutter/material.dart';

class BadgeIcon extends StatelessWidget {
  final Widget icon;
  final String badgeCount;
  final bool showBadge;

  const BadgeIcon({
    Key? key,
    required this.icon,
    required this.badgeCount,
    this.showBadge = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        icon,
        if (showBadge && int.parse(badgeCount) > 0)
          Positioned(
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 15,
                minHeight: 15,
              ),
              child: Text(
                badgeCount,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
