import 'package:fitness_tracker/util/constants.dart';
import 'package:flutter/material.dart';

class PageBodyWidget extends StatelessWidget {
  final Widget childWidget;

  PageBodyWidget({required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,10,20,10),
      child: Container(
        child: childWidget,
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kWidgetBGColor,
        ),
      ),
    );
  }
}
