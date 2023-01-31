
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:musawowange_admin/crypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../login/login.dart';
import '../../../models/apointmode.dart';
import '../../../pref/buz.dart';
import '../../../pref/pref.dart';
import 'addocserv.dart';

class pendingdocApp extends StatefulWidget {

  static const  String id='publisheddrud';

  @override
  State<pendingdocApp> createState() => _pendingdocAppState();
}

class _pendingdocAppState extends State<pendingdocApp> {


  List<String> options=[
    "Pending",
    "Rescheduled",
    "Rejected",
    "Confirmed",
    "Visited",
    "Canceled"
  ];

  @override
  void initState() {

    showPend();
    getBusiness();
    getPref();
    super.initState();
  }
  String? userID,name,email,num, pass, pic,lon, lat,ad, city,country,status,type,log,create,cry,uup,fcmi;
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
      cry = sharedPreferences.getString(PrefInfo.cry);
      uup = sharedPreferences.getString(PrefInfo.uup);
      fcmi = sharedPreferences.getString(PrefInfo.fcmi);
    });
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

    Navigator.pushReplacementNamed(context,LoginForm.id);
  }

  String? ID,user_id,logo,shop,bizname,email1,num1,tax,tin,add,time, sta, serve,op,rat,tRat,picked,crete;
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
    crete= sharedPreferences.getString(BusinessInfo.creat);
  }



  //https://mymusawoee.000webhostapp.com/api/owner/doctor/apps/cancel.php
  //https://mymusawoee.000webhostapp.com/api/owner/doctor/apps/confirm.php
  //https://mymusawoee.000webhostapp.com/api/owner/doctor/apps/pendin.php
  //https://mymusawoee.000webhostapp.com/api/owner/doctor/apps/reject.php
  //https://mymusawoee.000webhostapp.com/api/owner/doctor/apps/resdule.php
  //https://mymusawoee.000webhostapp.com/api/owner/doctor/apps/pendin.php
  //https://mymusawoee.000webhostapp.com/api/owner/doctor/apps/visit.php

  //late List published = [];
  List< AppointmentModel> published  = [];
  Future showPend() async {
    var response=await http.post(Uri.parse('https://mymusawoee.000webhostapp.com/api/owner/doctor/apps/pendin.php'),
        body:{'user_id':encryp('$userID')});

    if (response.statusCode == 200) {

      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            published .add(AppointmentModel.fromJson(map));
          }
        }
      }
      return published;
    }
  }


  @override
  Widget build(BuildContext context) {



    return Container(
      child: FutureBuilder<dynamic>(
          future:showPend(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){

            if (snapshot.hasData) {

              if(snapshot.data!.length == 0){

                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('No Appointments',style: TextStyle(color: Colors.grey,fontSize: 14),),

                      const Divider(height: 10,),

                      NeumorphicButton(
                        onPressed: (){


                          Navigator.pushReplacementNamed(context,AddDocServe.id);


                        },
                        style: const NeumorphicStyle(color:Colors.lightGreen),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.add_circle,size: 16,color: Colors.white,),
                              Text('Add Service',style: TextStyle(color: Colors.white),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );


              }else {

                return  SingleChildScrollView(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics:const BouncingScrollPhysics(),
                      itemCount: published.length,
                      itemBuilder: (context, index) {


                        return Container(
                          color: Colors.white,
                          child: Column(
                            children: [

                              ListTile(
                                horizontalTitleGap: 0,
                                leading:   CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 14,
                                  child: Icon(CupertinoIcons.square_list,size: 18,
                                    color: published[index].search =='Rejected' ? Colors.red:
                                           published[index].search =='Rescheduled' ? Colors.amber[200]:
                                           published[index].search =='Pending' ? Colors.grey:
                                           published[index].search =='Visited' ? Colors.green:
                                           published[index].search =='Canceled' ? Colors.orange[700]:
                                          published[index].search=='Confirmed' ? Colors.blueGrey[400]:Colors.orange,
                                  ),
                                ),
                                title: Text(published[index].search,style:  TextStyle(fontSize: 12,
                                    color: published[index].search =='Rejected' ? Colors.red:
                                     published[index].search =='Rescheduled' ? Colors.amber[200]:
                                     published[index].search =='Pending' ? Colors.grey:
                                     published[index].search =='Visited' ? Colors.green:
                                     published[index].search =='Canceled' ? Colors.orange[700]:
                                    published[index].search=='Confirmed' ? Colors.blueGrey[400]:Colors.orange
                                    ,fontWeight: FontWeight.bold),),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    Text('Appointment ID:${published[index].order_id}',style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                    published[index].onli=='false'?
                                    const Text('Payment Type:Cash on Delivery',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),):const Text('Payment Type:Paid Online',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                    Text('Amount:Shs${published[index].amt}',style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                  ],
                                ),

                              ),


                                ExpansionTile (
                                  title:const Text('Booking Details',style: TextStyle(color: Colors.black,fontSize: 10),),
                                  subtitle: const Text('view Booking details',style: TextStyle(color: Colors.grey,fontSize: 12),),
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(left:12,right: 12,top: 8,bottom: 8),
                                      child: Card(
                                        elevation: 8,

                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const Text('Patient Name:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

                                                  Text(published[index].pname,style: const TextStyle(color: Colors.grey),)
                                                ],
                                              ),

                                              Row(
                                                children: [
                                                  const Text('Age:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

                                                  Flexible(child: Text(published[index].age,style: const TextStyle(color: Colors.grey),maxLines: 2,))
                                                ],
                                              ),

                                              Row(
                                                children: [
                                                  const Text('Phone Number:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

                                                  Text(published[index].pPhone,style: const TextStyle(color: Colors.grey),)
                                                ],
                                              ),

                                              Row(
                                                children: [
                                                  const Text('Email:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

                                                  Text(published[index].peEmail,style: const TextStyle(color: Colors.grey),)
                                                ],
                                              ),


                                              Row(
                                                children: [
                                                  const Text('Date:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

                                                  Text(published[index].payDAy,style: const TextStyle(color: Colors.grey),)
                                                ],
                                              ),

                                              Row(
                                                children: [
                                                  const Text('Start Time:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

                                                  Text(published[index].stat,style: const TextStyle(color: Colors.grey),)
                                                ],
                                              ),

                                              Row(
                                                children: [
                                                  const Text('End Time:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

                                                  Text(published[index].end,style: const TextStyle(color: Colors.grey),)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),


                              const Divider(height: 3,color: Colors.grey,),


                            ],

                          ),
                        );




                      }),
                );
              }
            }else{

              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  'assets/images/doc.png',
                  color: Colors.lightBlue,
                ),
              );

            }



          }),
    );
  }






}




popUpButton(String s, {required BuildContext context}) {
  return PopupMenuButton<String>(
      onSelected: (String value) async{
        if(value=='unpublish'){


          neda( s);


        }
        if(value=='delete'){
          ushould( s);
        }



      },
      itemBuilder:(BuildContext context)=><PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value:'unpublish',
          child:ListTile(
            leading: Icon(Icons.check),
            title: Text('Un Publish'),

          ),
        ),






        const PopupMenuItem<String>(
          value:'delete',
          child:ListTile(
            leading: Icon(Icons.delete_outlined),
            title: Text('Delete Product'),

          ),



        ),
      ]
  );
}

Future<void> ushould(s) async {

  EasyLoading.show(status: 'Deleting Product...');

  var response=await http.post(Uri.parse('https://mymusawoee.000webhostapp.com/api/owner/whole/delete.php'),

      body:{"id":s});



  if(response.statusCode==200){
    var userData=json.decode(response.body);

    if(userData=="yes"){





      EasyLoading.showSuccess('Product deleted...');


    }else{



      EasyLoading.showError('Failed to delete...');


      print(userData);
    }

  }

}


Future<void> neda(s) async {
  var response=await http.post(Uri.parse('https://mymusawoee.000webhostapp.com/api/owner/whole/unpublish.php'),

      body:{"id":s});



  if(response.statusCode==200){
    var userData=json.decode(response.body);

    if(userData=="yes"){


      EasyLoading.showSuccess('Product Un publisehd...');


    }else{

      EasyLoading.showError('Failed to un publish...');


      print(userData);
    }

  }




}
