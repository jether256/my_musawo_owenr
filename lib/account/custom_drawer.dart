
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:musawowange_admin/account/screens/Pharmacy-Drug%20Wholesalers/addDrug.dart';

import 'package:musawowange_admin/account/screens/account/account.dart';
import 'package:musawowange_admin/account/screens/account/business.dart';
import 'package:musawowange_admin/account/screens/banner.dart';
import 'package:musawowange_admin/account/screens/clinic/addclinic.dart';
import 'package:musawowange_admin/account/screens/clinic/clinic.dart';
import 'package:musawowange_admin/account/screens/doctors/addClose.dart';
import 'package:musawowange_admin/account/screens/doctors/addcl.dart';
import 'package:musawowange_admin/account/screens/doctors/addocserv.dart';
import 'package:musawowange_admin/account/screens/doctors/applist.dart';
import 'package:musawowange_admin/account/screens/doctors/docserv.dart';
import 'package:musawowange_admin/account/screens/doctors/doctors.dart';

import 'package:musawowange_admin/account/screens/hospitals/addHospital.dart';
import 'package:musawowange_admin/account/screens/hospitals/hospital.dart';


import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/login.dart';
import '../pref/buz.dart';
import '../pref/pref.dart';
import 'home.dart';
import 'screens/Pharmacy-Drug Wholesalers/drug.dart';


class CustomD extends StatefulWidget {

  const CustomD({Key? key}) : super(key: key);

  @override
  _CustomDState createState() => _CustomDState();
}

class _CustomDState extends State<CustomD> {
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
  @override
  void initState() {
    getPref();
    getBusiness();

    showBiz();
    super.initState();
  }

  late List biz = [];
  Future showBiz() async {
    var response = await http.post(
        Uri.parse("https://mymusawoee.000webhostapp.com/api/owner/biz2.php"),
        headers: {"Accept": "headers/json"},body:{'user_id':'$userID'});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);


      setState(() {
        biz = jsonData;

      });

      print(jsonData);
      return jsonData;
    }
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



  @override
  Widget build(BuildContext context) {


    Widget _menu({String? menuTitle, IconData? icon,String? route}){
      return ListTile(
        leading: Icon(icon,color: Colors.lightGreen,),
        title: Text(menuTitle!,style: const TextStyle(color: Colors.lightGreen),),
        onTap: (){
          Navigator.pushReplacementNamed(context,route!);
        },

      );
    }


    return Drawer(
      backgroundColor: Colors.white,

      child: Column(
        children: [

      Container(
        height: 100,
        color:Theme.of(context).primaryColor,
        child: Row(
          children: [
            DrawerHeader(
              child:
              Row(
                children: [

                  CachedNetworkImage(imageUrl:'https://mymusawoee.000webhostapp.com/api/owner/logo/$logo'),
                  const SizedBox(width: 10,),
                  Center(child: Text('$bizname',overflow:TextOverflow.ellipsis,
                      style:const TextStyle(color: Colors.white,fontSize:15,fontWeight: FontWeight.bold),)),
                ],
              ),
            ),

          ],
        ),
      ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [


                _menu(
                  icon:Icons.dashboard_outlined,
                  menuTitle:'Home',
                  route:HomeScreen.id,
                ),


                if('$serve'=='Doctors')
                  ExpansionTile(
                    leading: Image.asset('assets/images/doctor.png'),
                    title:const Text('Doctor Services',style: TextStyle(color: Colors.lightGreen),),
                    children: [

                      _menu(
                        menuTitle:'All Doctor Services',
                        route:DocService.id,
                      ),

                      _menu(
                        menuTitle:'Add Service',
                        route:AddDocServe.id,
                      ),

                      _menu(
                        menuTitle:'Add Closing Date',
                        route:CloseDate.id,
                      ),

                      _menu(
                        menuTitle:'View Closing Date',
                        route:DocClose.id,
                      ),

                      _menu(
                        menuTitle:'Doctor Appointment Lists',
                        route:DoctappointmentList.id,
                      ),

                    ],
                  ),


                if('$serve'=='Pharmacy'||'$serve'=='Drug Wholesellers')
                  ExpansionTile(
                    leading:Image.asset('assets/images/drug shop.png',height: 30,),
                    title:const Text('Drugs/Products',style: TextStyle(color: Colors.lightGreen),),
                    children: [

                      _menu(
                        menuTitle:'All Drugs/Products',
                        route:DrugScreen.id,
                      ),


                      _menu(
                        menuTitle:'Add Drug/Product',
                        route:AddDrug.id,
                      ),


                    ],
                  ),




                if('$serve'=='Clinic')
                ExpansionTile(
                  leading: Image.asset('assets/images/clinic.png'),
                  title:const Text('Clinic Services',style: TextStyle(color: Colors.lightGreen),),
                  children: [

                    _menu(
                      menuTitle:'Clinic Services',
                      route:Clinic.id,
                    ),

                    _menu(
                      menuTitle:'Add Clinic Service',
                      route:AddClinic.id,
                    ),

                  ],
                ),



                if('$serve'=='Hospitals')
                  ExpansionTile(
                    leading: Image.asset('assets/images/hospital.png'),
                    title:const Text('Hospital Services',style: TextStyle(color: Colors.lightGreen),),
                    children: [

                      _menu(
                        menuTitle:'All Hospital Services',
                        route:Hospital.id,
                      ),


                      _menu(
                        menuTitle:'Add Hospital Service',
                        route:AddHospital.id,
                      ),


                    ],
                  ),



                ExpansionTile(
                  leading: const Icon(CupertinoIcons.person,color: Colors.lightGreen,),
                  title:const Text('Account',style: TextStyle(color: Colors.lightGreen),),
                  children: [

                    _menu(
                      menuTitle:'Edit Account',
                      route:EditAccount.id,
                    ),


                    _menu(
                      menuTitle:'Edit Business',
                      route:EditBusiness.id,
                    ),


                  ],
                ),


                _menu(
                  icon:CupertinoIcons.photo,
                  menuTitle:'Banners',
                  route:Banners.id,
                ),




                _menu(
                  icon:Icons.notifications_outlined,
                  menuTitle:'Notifications',
                  route:HomeScreen.id,
                ),



                _menu(
                  icon:CupertinoIcons.gift,
                  menuTitle:'Coupons',
                  route:HomeScreen.id,
                ),

                _menu(
                  icon:Icons.list_alt_outlined,
                  menuTitle:'Orders',
                  route:HomeScreen.id,
                ),



                _menu(
                  icon:Icons.stacked_bar_chart_outlined,
                  menuTitle:'Reports',
                  route:HomeScreen.id,
                ),


                _menu(
                  icon:Icons.settings_outlined,
                  menuTitle:'Settings',
                  route:HomeScreen.id,
                ),

                _menu(
                  icon:Icons.arrow_back_ios,
                  menuTitle:'LogOut',
                  route:HomeScreen.id,
                ),
              ],

            ),
          ),
        ],
      ),
    );
  }
}
