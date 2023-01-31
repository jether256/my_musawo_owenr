
import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatelessWidget {
  @required
  final String title;
  @required
  final bool isEnableBtn;
  @required
  final onPressed;
  BottomNavBarWidget({required this.title, required this.isEnableBtn, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, top: 8.0, bottom: 8.0),
            child: SizedBox(
              height: 35,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:Colors.lightGreen,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onPressed: isEnableBtn ? onPressed : null,
                  child: Center(
                      child: Text(title,
                          style: const TextStyle(
                            color: Colors.white,
                          )))),
            )));
  }
}

class BottomNavTwoBarWidget extends StatelessWidget {
  @required
  final String firstTitle;
  @required
  final bool isenableBtn;
  @required
  final firstBtnOnPressed;
  @required
  final String secondTitle;
  @required
  final secondBtnOnPressed;
  BottomNavTwoBarWidget(
      {required this.firstTitle,
      this.firstBtnOnPressed,
      required this.secondTitle,
      this.secondBtnOnPressed,
      required this.isenableBtn});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, top: 8.0, bottom: 8.0),
            child: SizedBox(
              height: 35,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:Colors.lightGreen,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                        onPressed: isenableBtn ? firstBtnOnPressed : null,
                        child: Center(
                            child: Text(firstTitle,
                                style: const TextStyle(
                                  color: Colors.white,
                                )))),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:Colors.lightGreen,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                        onPressed: isenableBtn ? secondBtnOnPressed : null,
                        child: Center(
                            child: Text(secondTitle,
                                style: const TextStyle(
                                  color: Colors.white,
                                )))),
                  ),
                ],
              ),
            )));
  }
}
