import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:musawowange_admin/account/screens/clinic/addclinic.dart';
import 'package:musawowange_admin/account/screens/clinic/clinic.dart';
import 'package:musawowange_admin/account/screens/doctors/addocserv.dart';
import 'package:musawowange_admin/account/screens/doctors/doctors.dart';
import 'package:musawowange_admin/account/screens/doctors/serv.dart';
import 'package:musawowange_admin/account/screens/hospitals/hospital.dart';


import 'package:musawowange_admin/splash.dart';
import 'package:musawowange_admin/wait.dart';


import 'package:provider/provider.dart';

import 'Provider/locationPro.dart';
import 'account/home.dart';
import 'account/provider/auth.dart';
import 'account/provider/garap.dart';
import 'account/provider/proid.dart';
import 'account/provider/shop.dart';
import 'account/provider/typepro.dart';
import 'account/provider/vendPro.dart';
import 'account/provider/washPack.dart';
import 'account/provider/washPro.dart';
import 'account/screens/Pharmacy-Drug Wholesalers/addDrug.dart';
import 'account/screens/Pharmacy-Drug Wholesalers/drug.dart';
import 'account/screens/Pharmacy-Drug Wholesalers/publisheddrug.dart';
import 'account/screens/Pharmacy-Drug Wholesalers/unpublisheddrug.dart';
import 'account/screens/account/account.dart';
import 'account/screens/account/business.dart';
import 'account/screens/banner.dart';
import 'account/screens/doctors/addClose.dart';
import 'account/screens/doctors/addcl.dart';
import 'account/screens/doctors/applist.dart';
import 'account/screens/doctors/docserv.dart';
import 'account/screens/hospitals/addHospital.dart';
import 'location.dart';
import 'login/linda.dart';
import 'login/login.dart';
import 'login/reg.dart';
import 'login/regsiter.dart';
import 'map/map.dart';


void main() async{

  Provider.debugCheckInvalidValueType=null;
  runApp(

    MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create:(_) => AuthProvider(),
        ),


        ChangeNotifierProvider(
          create:(_) => LocationProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => BusinessProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => WashServiceProvider(),
        ),


        ChangeNotifierProvider(
          create:(_) => WashPackProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => typeProvider(),
        ),


        ChangeNotifierProvider(
          create:(_) => GaraProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => ShopProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => ProductIDProvider(),
        ),


      ],
      child: const MyApp(),
    ),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Musawo Wange',
      theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          fontFamily: 'Gothic'
      ),
      builder:EasyLoading.init(),
      initialRoute: Splash.id,// first route
      routes: {
        //we will add the screens here for easy navigation
        Splash.id:(context)=>Splash(),
        LoginForm.id:(context)=>LoginForm(),
        Register.id:(context)=>Register(),
        Wait.id:(context)=>Wait(),
        Reg.id:(context)=>Reg(),
        locationL.id:(context)=>locationL(),
        Mapma.id:(context)=>Mapma(),
        linda.id:(context)=>linda(),
        HomeScreen.id:(context)=>HomeScreen(),

        //phramacy and whole sellers
        AddDrug.id:(context)=>AddDrug(),
        DrugScreen.id:(context)=>DrugScreen(),
        PublishedDrug.id:(context)=>PublishedDrug(),
        UnpublisehedDrug.id:(context)=>UnpublisehedDrug(),

        //hospital
        AddHospital.id:(context)=>AddHospital(),
        Hospital.id:(context)=>Hospital(),
        DoctorService.id:(context)=>DoctorService(),
        DoctappointmentList.id:(context)=>DoctappointmentList(),

        //clinic
        AddClinic.id:(context)=>AddClinic(),
        Clinic.id:(context)=>Clinic(),

        //doctor
        AddDocServe.id:(context)=>AddDocServe(),
        DocService.id:(context)=>DocService(),
        Doctors.id:(context)=>Doctors(),
        DocClose.id:(context)=>DocClose(),
        CloseDate.id:(context)=>CloseDate(),

        //account
        Banners.id:(context)=>Banners(),
        EditAccount.id:(context)=>EditAccount(),
        EditBusiness.id:(context)=>EditBusiness(),

      },
    );
  }
}

