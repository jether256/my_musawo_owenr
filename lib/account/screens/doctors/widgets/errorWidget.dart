import 'package:flutter/material.dart';
class IErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            width: 300,
            child:
            //Container(color: Colors.red,)
            Image.asset(
                "assets/images/doc.png",
            ),
          ),
          const SizedBox(height: 20),
          const Text("Sorry it's error!",style: TextStyle(
            fontSize: 14,
          )),
        ],
      ),
    );
  }
}
