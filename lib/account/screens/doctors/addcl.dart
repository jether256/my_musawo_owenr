import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../crypt/encrypt.dart';
import '../../../login/login.dart';
import '../../../pref/buz.dart';
import '../../../pref/pref.dart';
import '../../custom_drawer.dart';

class CloseDate extends StatefulWidget {

  static const  String id='add doc close add';

  @override
  State<CloseDate> createState() => _CloseDateState();
}

class _CloseDateState extends State<CloseDate> {

  final _fomkey=GlobalKey<FormState>();

  TextEditingController _date = TextEditingController();





  @override
  void initState() {
    _date.text = "";

    getPref();
    getBusiness();

    super.initState();
  }


  String? userID,name,email,num, pass, pic,lon, lat,ad, city,country,status,type,log,create;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      userID = sharedPreferences.getString(PrefInfo.ID);
      name = sharedPreferences.getString(PrefInfo.name);
      email = sharedPreferences.getString(PrefInfo.email);
      num = sharedPreferences.getString(PrefInfo.num);
      pass = sharedPreferences.getString(PrefInfo.pass);
      pic = sharedPreferences.getString(PrefInfo.pic);
      lon = sharedPreferences.getString(PrefInfo.lon);
      lat = sharedPreferences.getString(PrefInfo.lat);
      ad = sharedPreferences.getString(PrefInfo.ad);
      city = sharedPreferences.getString(PrefInfo.city);
      country = sharedPreferences.getString(PrefInfo.country);
      status = sharedPreferences.getString(PrefInfo.status);
      type = sharedPreferences.getString(PrefInfo.type);
      log = sharedPreferences.getString(PrefInfo.log);
      create = sharedPreferences.getString(PrefInfo.create);
    });
  }

  String? ID,user_id,logo,shop,bizname,email1,num1,tax,tin,add,time, sta, serve,op,rat,tRat,picked;
  getBusiness() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    ID = sharedPreferences.getString(BusinessInfo.ID);
    user_id = sharedPreferences.getString(BusinessInfo.user_id);
    logo= sharedPreferences.getString(BusinessInfo.logo);
    shop= sharedPreferences.getString(BusinessInfo.shop);
    bizname= sharedPreferences.getString(BusinessInfo.bizname);
    email1= sharedPreferences.getString(BusinessInfo.email1);
    num1= sharedPreferences.getString(BusinessInfo.num1);
    tax= sharedPreferences.getString(BusinessInfo.tax);
    tin= sharedPreferences.getString(BusinessInfo.tin);
    add = sharedPreferences.getString(BusinessInfo.add);
    time = sharedPreferences.getString(BusinessInfo.time);
    sta= sharedPreferences.getString(BusinessInfo.sta);
    serve= sharedPreferences.getString(BusinessInfo.serve);
    op= sharedPreferences.getString(BusinessInfo.op);
    rat= sharedPreferences.getString(BusinessInfo.rat);
    tRat= sharedPreferences.getString(BusinessInfo.tRat);
    picked= sharedPreferences.getString(BusinessInfo.picked);
  }


  Future saveDay() async {

    EasyLoading.show(status: 'Saving Day...');

    var response=await http.post(Uri.parse('https://mymusawoee.000webhostapp.com/api/owner/doctor/addClose.php'),
        body:{
          "date":encryp(_date.text),
          "doc_id":encryp('$user_id'),

        });

    if(response.statusCode==200){

      var userData=json.decode(response.body);

      if(userData=="ERROR"){

        EasyLoading.showError('Closing Time Already Exists');


      }else{

        EasyLoading.showSuccess('Closing Time  Saved...');

        print(userData);
      }


      // EasyLoading.showSuccess('Service  Saved...');

    }else{

      EasyLoading.showError('Failed to save..');
    }


  }


  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(PrefInfo.ID);
    sharedPreferences.remove(PrefInfo.name);
    sharedPreferences.remove(PrefInfo.email);
    sharedPreferences.remove(PrefInfo.num);
    sharedPreferences.remove(PrefInfo.pass);
    sharedPreferences.remove(PrefInfo.pic);
    sharedPreferences.remove(PrefInfo.lon);
    sharedPreferences.remove(PrefInfo.lat);
    sharedPreferences.remove(PrefInfo.ad);
    sharedPreferences.remove(PrefInfo.city);
    sharedPreferences.remove(PrefInfo.country);
    sharedPreferences.remove(PrefInfo.status);
    sharedPreferences.remove(PrefInfo.type);
    sharedPreferences.remove(PrefInfo.log);
    sharedPreferences.remove(PrefInfo.create);
    sharedPreferences.remove(PrefInfo.cry);
    sharedPreferences.remove(PrefInfo.uup);
    sharedPreferences.remove(PrefInfo.fcmi);

    Navigator.pushReplacementNamed(context, LoginForm.id);
  }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text('Add Closing Day ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        elevation: 0,
        actions:  [

          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: (){

                signOut();

              },
              child: const Icon(Icons.person,color: Colors.white,),
            ),
          ),
        ],
      ),
      drawer: const CustomD(),
       body: Form(
         key: _fomkey,
         child: Column(
           children: [
             Material(
               elevation: 3,
               child: Padding(
                 padding: const EdgeInsets.all(10),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [

                     Padding(
                       padding: const EdgeInsets.only(left: 10),
                       child: Container(
                         child: const Text('Save Day',style: TextStyle(color: Colors.lightGreen),),
                       ),
                     ),

                     MaterialButton(
                       color:Colors.lightGreen,
                       child:const Text('Save',style: TextStyle(color: Colors.white),),
                       onPressed:() async{


                           //saveDay();


                           EasyLoading.show(status: 'Saving Day...');

                           var response=await http.post(Uri.parse('https://mymusawoee.000webhostapp.com/api/owner/doctor/addClose.php'),

                               body:{"date":_date.text,
                                 "doc_id":'$user_id',

                               });

                           if(response.statusCode==200){
                             var userData=json.decode(response.body);

                             if(userData=="ERROR"){

                               EasyLoading.showError('Date already exists..');


                             }else{
                               EasyLoading.showSuccess('Date  Saved...');

                               print(userData);
                             }

                           }

                       },
                     ),
                   ],
                 ),
               ),
             ),


             Expanded(
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Card(
                   color: Colors.grey.shade200,
                   child: ListView(
                     children: [
                       Padding(
                         padding: const EdgeInsets.all(10),
                         child: Column(
                           children: [

                             InkWell(
                               onTap:()
                               async{

                                 DateTime? pickedDate = await showDatePicker(
                                     context: context, initialDate: DateTime.now(),
                                     firstDate: DateTime(2022), //DateTime.now() - not to allow to choose before today.
                                     lastDate: DateTime(2101)
                                 );

                                 if(pickedDate != null ){
                                   print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                   String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                   print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                   //you can implement different kind of Date Format here according to your requirement

                                   setState(() {
                                     _date.text = formattedDate; //set output date to TextField value.
                                   });
                                 }else{
                                   print("Date is not selected");
                                 }

                               },
                               child: TextFormField(
                                 enabled: false,
                                 controller: _date,
                                 keyboardType:TextInputType.number,

                                 validator: (value){
                                   if(value!.isEmpty){

                                     return 'Enter Date';
                                   }

                                   return null;
                                 },
                                 decoration: InputDecoration(
                                     icon: const Icon(CupertinoIcons.calendar_badge_minus),
                                     labelText: 'Date*',
                                     labelStyle: const TextStyle(color: Colors.black),
                                     enabledBorder: UnderlineInputBorder(
                                         borderSide: BorderSide(
                                           color: Colors.grey.shade300,
                                         )
                                     )
                                 ),
                               ),
                             ),



                           ],
                         ),
                       )
                     ],
                   ),
                 ),
               ),
             ),


           ],
         ),
       ),
    );
  }

}
