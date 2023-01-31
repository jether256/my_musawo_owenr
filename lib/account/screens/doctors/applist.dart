import 'package:flutter/material.dart';
import 'package:musawowange_admin/account/screens/doctors/pendingdoc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../login/login.dart';
import '../../../pref/pref.dart';
import '../../custom_drawer.dart';
import 'addocserv.dart';

class DoctappointmentList extends StatefulWidget {

  static const  String id='doc applist';

  @override
  State<DoctappointmentList> createState() => _DoctappointmentListState();
}

class _DoctappointmentListState extends State<DoctappointmentList> {

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Doctor Appointment List',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
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
        drawer: CustomD(),
        body:Column(
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
                        child: Row(
                          children: const [
                            Text('Appointments'),
                            SizedBox(width:10),
                            CircleAvatar(
                              backgroundColor: Colors.black54,
                              maxRadius: 8,
                              child: FittedBox(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('20',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                ),
                              ),
                            )
                          ],

                        ),
                      ),
                    ),

                    MaterialButton(
                      color:Colors.lightGreen,
                      child:const Text('Add Service',style: TextStyle(color: Colors.white),),
                      onPressed:(){
                        Navigator.pushReplacementNamed(context,AddDocServe.id);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const TabBar(
                indicatorColor: Colors.lightGreen,
                labelColor: Colors.lightGreen,
                unselectedLabelColor: Colors.grey,
                tabs:[
                  Tab(text: 'All',),
                  Tab(text: 'Finished',),
                ]
            ),

            Expanded(
              child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children:[
                    pendingdocApp(),
                    pendingdocApp(),
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
