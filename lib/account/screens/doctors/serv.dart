import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../login/login.dart';
import '../../../models/person.dart';
import '../../../pref/buz.dart';
import '../../../pref/pref.dart';
import 'addocserv.dart';
import 'editdoc.dart';

class DoctorService extends StatefulWidget {
  static const  String id='doc service';

  @override
  State<DoctorService> createState() => _DoctorServiceState();
}

class _DoctorServiceState extends State<DoctorService> {


  @override
  void initState() {

    showAll();
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


 late List published = [];

  //List<PersonalServiceModel> published = [];

  Future showAll() async {
    var response=await http.post(Uri.parse('https://mymusawoee.000webhostapp.com/api/owner/doctor/getServe.php'),
        body:{'user_id':'$userID'});

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);


      setState(() {
        published = jsonData;

      });

      print(jsonData);
      return jsonData;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(

      child: FutureBuilder(
        future:showAll(),
        builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot){

          if (snapshot.hasData) {

            if(snapshot.data!.length == 0){

              return Container(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:  [
                      const Text('No Services Added',style: TextStyle(fontWeight: FontWeight.bold),),
                      const SizedBox(height: 10,),
                      ElevatedButton(
                          onPressed: ()
                          {
                            Navigator.pushReplacementNamed(context,AddDocServe.id);
                          },
                          style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Theme.of(context).primaryColor)),
                          child:const Text('Add Service')
                      ),

                    ],
                  ),
                ),
              );

            }else {


              return SingleChildScrollView(
                child: DataTable(
                  showBottomBorder: true,
                  dataRowHeight: 90,

                  horizontalMargin: 0,
                  headingRowColor: MaterialStateProperty.all(
                      Colors.grey[200]),
                  columns: const <DataColumn>[
                    DataColumn(label: Text('Service')),
                    // DataColumn(label: Text('Image ')),
                    DataColumn(label: Text('Info ')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: snapshot.data.map<DataRow>((e) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Container(
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Row(
                                children: [
                                  const Text('Name:',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),),
                                  Text(e['shopName'],
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 12)),
                                ],
                              ),

                              subtitle:Column(
                                children: [

                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: CachedNetworkImage(
                                        height: 50,
                                        width:50 ,
                                        imageUrl: 'https://mymusawoee.000webhostapp.com/api/owner/logo/${e['image']}'),
                                  ),),

                                  Row(
                                    children: [
                                      const Text('Service:',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),),

                                      Text('${e['serve']}',
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              fontSize: 12)),
                                    ],
                                  ),

                                ],
                              ),

                            ),
                          ),
                        ),

                        // DataCell(
                        //     Container(child: Padding(
                        //       padding: const EdgeInsets.all(3.0),
                        //       child: CachedNetworkImage(
                        //           width:50 ,
                        //           imageUrl: 'https://bodayo.000webhostapp.com/api/owner/product/${e['image']}'),
                        //     ),)
                        // ),


                        DataCell(
                            IconButton(onPressed: ()
                            {
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>EditDoctor(
                                  ID:'${e['ID']}', cli_id:'${e['cli_id']}', doc_id:'${e['doc_id']}',dep_id:'${e['dep_id']}',
                                  name:'${e['shopName']}',email:'${e['email']}',image:'${e['image']}',
                                  Service:'${e['serve']}',Price:'${e['price']}', Com:'${e['compared']}',phone:'${e['phone']}',
                                  Book:'${e['booking']}',lon:'${e['lon']}', lat:'${e['lat']}',luncClose:'${e['lunchClosingTime']}',
                                  luncOpen:'${e['lunchOpeningTime']}',stopBooking:'${e['stopBooking']}',Op:'${e['open']}',Close:'${e['close']}',
                                  dayCode:'${e['dayCode']}', Servet:'${e['serviceTime']}',delete:'${e['isDeleted']}',fcmid:'${e['fcmid']}',
                                  up:'${e['updatedTimeStamp']}')));
                            },
                              icon:const Icon(Icons.info_outline),
                            )
                        ),


                        DataCell(
                          Container(
                            child: popUpButton(('${e['ID']}'),
                                context: context),
                          ),

                        ),

                      ],
                    );
                  }).toList(),
                ),
              );

            }
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}



popUpButton(String s, {required BuildContext context}) {
  return PopupMenuButton<String>(
      onSelected: (String value) async{
        // if(value=='unpublish'){
        //
        //
        //   neda( s);
        //
        //
        // }
        if(value=='delete'){
          ushould( s);
        }



      },
      itemBuilder:(BuildContext context)=><PopupMenuEntry<String>>[
        // const PopupMenuItem<String>(
        //   value:'unpublish',
        //   child:ListTile(
        //     leading: Icon(Icons.check),
        //     title: Text('Un Publish'),
        //
        //   ),
        // ),






        const PopupMenuItem<String>(
          value:'delete',
          child:ListTile(
            leading: Icon(Icons.delete_outlined),
            title: Text('Delete Service'),

          ),



        ),
      ]
  );
}

Future<void> ushould(s) async {

  EasyLoading.show(status: 'Deleting Service...');

  var response=await http.post(Uri.parse('https://mymusawoee.000webhostapp.com/api/owner/doctor/deldoc.php'),

      body:{"id":s});



  if(response.statusCode==200){
    var userData=json.decode(response.body);

    if(userData=="yes"){





      EasyLoading.showSuccess('Service deleted...');


    }else{



      EasyLoading.showError('Failed to delete...');


      print(userData);
    }

  }

}


// Future<void> neda(s) async {
//   var response=await http.post(Uri.parse('https://mymusawoee.000webhostapp.com/api/owner/whole/unpublish.php'),
//
//       body:{"id":s});
//
//
//
//   if(response.statusCode==200){
//     var userData=json.decode(response.body);
//
//     if(userData=="yes"){
//
//
//       EasyLoading.showSuccess('Product Un publisehd...');
//
//
//     }else{
//
//       EasyLoading.showError('Failed to un publish...');
//
//
//       print(userData);
//     }
//
//   }
//
//
//
//
// }
