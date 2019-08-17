import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currenPage;

  final int size;

  PageIndicator(this.currenPage, this.size);

  Widget buildIndicator(bool isActive) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white10,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(2.0, 2.0),
                    spreadRadius: 2)
              ]),
          height: 4,
        ),
      ),
    );
  }

  List<Widget> buildIndicatorList() {
    List<Widget> list = new List();

    for (int i = 0; i < 3; i++) {
      list.add(buildIndicator(i == currenPage));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: buildIndicatorList(),
    );
  }
}
