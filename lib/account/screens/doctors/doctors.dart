import 'package:flutter/material.dart';
import 'package:musawowange_admin/models/Service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../login/login.dart';
import '../../../models/business.dart';
import '../../../pref/pref.dart';
import '../../custom_drawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class Doctors extends StatefulWidget {
  static const  String id='doctors';



  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {



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


  List<ServiceDocModel> searchItem=[];
  List<ServiceDocModel> selectItem=[];
  List<ServiceDocModel> items=[];
  final List<bool> _selected=List.generate(20, (index) =>false);
 // List<ServiceModel> type1 = [];

  Future showService() async {
    var response = await http.post(
        Uri.parse("https://mymusawoee.000webhostapp.com/api/owner/doctor/servdoc.php"),
        headers: {"Accept": "headers/json"});
    if (response.statusCode == 200) {

      List<ServiceDocModel> list=parseService(response.body);
      return list;

    }else{
      throw Exception("Error");
    }
  }

  parseService(String body){
    final parsed=json.decode(body).cast<Map<String,dynamic>>();
    return parsed.map<ServiceDocModel>((json)=>ServiceDocModel.fromMap(json)).toList();
  }


  // //get business array
  // Business() async {
  //   var response=await http.post(Uri.parse('https://mymusawoee.000webhostapp.com/api/owner/biz.php'),
  //       body:{'user_id':'$userID'});
  //
  //   if(response.statusCode==200){
  //
  //     List<BusinessModel> list=parseBusiness(response.body);
  //     return list;
  //
  //   }else{
  //
  //     throw Exception("Error");
  //   }
  //
  //
  //
  // }


  @override
  void initState() {
    super.initState();

    getPref();
    showService().then((serviceFromServer){

            setState((){
              selectItem=serviceFromServer;
              searchItem=selectItem;
            });

    });
  }

  // parseBusiness(String body){
  //   final parsed=json.decode(body).cast<Map<String,dynamic>>();
  //   return parsed.map<BusinessModel>((json)=>BusinessModel.fromMap(json)).toList();
  // }

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        title: const Text('Doctor Services',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
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
      //drawer: const CustomD(),
      body:Padding(
        padding: const EdgeInsets.all(8.0),

        child:ListView.builder(
            itemCount:searchItem.length,
            itemBuilder:(BuildContext context,int index){

              return ListTile(
                title:Text(searchItem[index].Title) ,
              );

            }
        ),

      ),
    );
  }
}
