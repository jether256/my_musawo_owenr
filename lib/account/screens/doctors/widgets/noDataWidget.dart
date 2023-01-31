import 'package:flutter/material.dart';


class NoDataWidget extends StatelessWidget {
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
            width: 250,
            child:
            //Container(color: Colors.red,)
            Image.asset(
                "assets/images/logo.svg",
            ),
          ),
          const SizedBox(height: 20),
          const Text("No Data Found!",style: TextStyle(

            fontSize: 14,
          )),
        ],
      ),
    );
  }
}

class NoBookingWidget extends StatelessWidget {
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
            width: 250,
            child:
            //Container(color: Colors.red,)
            Image.asset(
              "assets/images/logo.svg",
            ),
          ),
          const SizedBox(height: 0),
          const Padding(
            padding: EdgeInsets.only(left:20.0,right:20.0),
            child: Text("There is no anointment Found! please press book an appointment button and make a new appointment",style: TextStyle(
              fontSize: 14,
            )),
          ),
        ],
      ),
    );
  }
}
