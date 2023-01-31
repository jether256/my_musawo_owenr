
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musawowange_admin/account/screens/doctors/service/closingDateService.dart';
import 'package:musawowange_admin/account/screens/doctors/utilities/datePicker.dart';
import 'package:musawowange_admin/account/screens/doctors/utilities/dialogBox.dart';
import 'package:musawowange_admin/account/screens/doctors/widgets/errorWidget.dart';
import 'package:musawowange_admin/account/screens/doctors/widgets/loadingIndicator.dart';
import 'package:musawowange_admin/account/screens/doctors/widgets/noDataWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../crypt/encrypt.dart';
import '../../../login/login.dart';
import '../../../models/closinddate.dart';
import '../../../pref/buz.dart';
import '../../../pref/pref.dart';
import '../../custom_drawer.dart';
import '../widgets/bottomNavigationBarWidget.dart';


class DocClose extends StatefulWidget {

  static const  String id='add doc close';

  @override
  State<DocClose> createState() => _DocCloseState();
}

class _DocCloseState extends State<DocClose> {



  final _kate=TextEditingController();
  final _name=TextEditingController();
  final _desc=TextEditingController();
  final _priceO=TextEditingController();
  final _priceC=TextEditingController();
  final _brand=TextEditingController();
  final _sk=TextEditingController();
  final _kg=TextEditingController();
  final _tax=TextEditingController();
  final _col=TextEditingController();
  final _invQty=TextEditingController();
  final _inQtyLo=TextEditingController();



  String? proName;
  String? proDesc;
  String? proPC;
  String? proPO;
  String? proBrand;
  String? proSk;
  String? proCate;
  String? proKg;
  String? proTax;
  String? stockQty;
  String? stockQtyLo;

  XFile? _proImage;
  final ImagePicker _picker=ImagePicker();


  Future<XFile?> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }


  final _fomkey=GlobalKey<FormState>();




  String? dropDownValue;

  bool? _track=false;

  bool _isEnableBtn = true;
  bool _isLoading = false;
  String doctId="";

  @override
  void initState() {
    getPref();
    getBusiness();
    getclose();
    getAndSetDoctId();
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



  //late List cat = [];
  List<ClosingDateModel> close = [];
  Future getclose() async {
    var response = await http.post(
        Uri.parse("https://mymusawoee.000webhostapp.com/api/owner/doctor/getClose.php"),
      headers: {"Accept": "headers/json"},
        body:{"do_id":'$user_id'},
        );

    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          close.add(ClosingDateModel.fromJson(item));
        }
      });

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
        title: const Text('Add Closing Date ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
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
        bottomNavigationBar: BottomNavBarWidget(
          title: "Update",
          isEnableBtn: _isEnableBtn,
          onPressed: _takeConfirmation,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor:Colors.lightGreen,
          onPressed: () async {

            final res = await DatePicker.datePicker(context);
            if (res != "") {
              _handleUpdate(res);
            }

          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body:FutureBuilder(
            future:getclose(), // fetch all images form the database
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

              if (snapshot.hasData) {

                return  ListView.builder(
                    shrinkWrap: true,
                    itemCount:close.length,
                    itemBuilder: (context,index){
                      return Card(
                        child: ListTile(
                          title: Text(close[index].date),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color:Colors.lightGreen,
                            ),
                            onPressed: () {
                              DialogBoxes.confirmationBox(
                                  context, "Delete", "Are you sure want to delete date", (){
                                _handleDelete(close[index].ID);
                              });

                            },
                          ),
                        ),
                      );
                    });

              } else {

                return LoadingIndicatorWidget();

              }
            })

    );
  }

  _takeConfirmation() {
    DialogBoxes.confirmationBox(
        context, "Update", "Are you sure want to update date", _handleUpdate);
  }

  _handleUpdate(date) async {
    print(date);
    setState(() {
      _isLoading = true;
      _isEnableBtn = false;
    });

    final res = await http.post(Uri.parse("add_closing_date"),
        body: {
          "doctId": doctId,
          "date": date
        });
    if (res.statusCode == 200) {
      print(res.body);
      if (res.body == "success") {

        EasyLoading.showSuccess('Successfully updated...');
      } else if (res.body == "already exists") {



        EasyLoading.showError('already exists');
      }
      else {

        EasyLoading.showError('Something went wrong');
      }

    }

    setState(() {
      _isLoading = false;
      _isEnableBtn = true;
    });
  }

  _handleDelete(String id)async{
    setState(() {
      _isLoading = true;
      _isEnableBtn = false;
    });

    final res = await ClosingDateService.deleteData(id);
    if (res == "success") {

      EasyLoading.showSuccess('Successfully deleted...');
    }
    else {
      EasyLoading.showError('Something went wrong..');
    }

    setState(() {
      _isLoading = false;
      _isEnableBtn = true;
    });
  }



  void getAndSetDoctId() async{
    setState(() {
      _isLoading=true;
    });
    SharedPreferences preferences=await SharedPreferences.getInstance();
    doctId=preferences.getString("doctId")!;
    setState(() {
      _isLoading=false;
    });
  }



}
