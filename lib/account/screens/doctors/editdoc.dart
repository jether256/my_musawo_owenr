import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../../crypt/encrypt.dart';
import '../../../login/login.dart';
import '../../../models/Service.dart';
import '../../../pref/buz.dart';
import '../../../pref/pref.dart';
import '../../custom_drawer.dart';

class EditDoctor extends StatefulWidget {

  final String ID;
  final String cli_id;
  final String doc_id;
  final String dep_id;
  final String name;
  final String email;
  final String image;
  final String Service;
  final String Price;
  final String Com;
  final String phone;
  final String Book;
  final String lon;
  final String lat;
  final String luncClose;
  final String luncOpen;
  final String stopBooking;
  final String Op;
  final String Close;
  final String dayCode;
  final String Servet;
  final String delete;
  final String fcmid;
  final String up;


  EditDoctor ( {
    required this.dep_id,  required this.ID, required this.cli_id, required this.doc_id, required this.name, required this.email, required this.image, required this.Service, required this.Price, required this.Com, required this.phone, required this.Book, required this.lon, required this.lat, required this.luncClose, required this.luncOpen, required this.stopBooking, required this.Op, required this.Close, required this.dayCode, required this.Servet, required this.delete, required this.fcmid, required this.up,
  });


  @override
  State<EditDoctor> createState() => _EditDoctorState();
}

class _EditDoctorState extends State<EditDoctor> {


  String _clinicOpeningTime = "10:00";
  String _clinicClosingTime = "20:00";
  String _lunchOpeningTime = "13:00";
  String _lunchClosingTime = "14:00";

  bool _stopBooking = false;
  final List _dayCode = [];
  bool _monCheckedValue = false;
  bool _tueCheckedValue = false;
  bool _wedCheckedValue = false;
  bool _thuCheckedValue = false;
  bool _friCheckedValue = false;
  bool _satCheckedValue = false;
  bool _sunCheckedValue = false;


  final _serve=TextEditingController();
  final _price=TextEditingController();
  final _comp=TextEditingController();
  final _book=TextEditingController();
  final _serviceTime=TextEditingController();


  String? serveName;
  String? servePrice;
  String? serveComp;
  String? serveBook;

  final _fomkey=GlobalKey<FormState>();

  getDoctor() async{

    setState(() {
      _serve.text=widget.Service;
      _price.text=widget.Price;
      _comp.text=widget.Com;
      _book.text=widget.Book;
      _serviceTime.text=widget.Servet;
      _clinicOpeningTime=widget.Op;
      _clinicClosingTime=widget.Close;
      _lunchOpeningTime=widget.luncOpen;
       _lunchClosingTime=widget.luncClose;
      _stopBooking=widget.stopBooking as bool;

        //var difference=int.parse(_com.text)-double.parse(_price.text);
      //discount=(double.parse(_price.text)/int.parse(_com.text)*100);
      //discount=(difference/int.parse(_com.text)*100);
    });


  }



  @override
  void initState() {
    getPref();
    getBusiness();
    showCat();
    getDoctor();
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



  //https://mymusawoe.000webhostapp.com/api/owner/doctor/available.php

  Future savePro() async {

    EasyLoading.show(status: 'Editing Service...');

    String newDays = "";
    if (_dayCode.isNotEmpty) {
      for (int i = 0; i < _dayCode.length; i++) {
        if (i == 0) {
          newDays = _dayCode[0].toString();
        } else {
          newDays = newDays + "," + _dayCode[i].toString();
        }
      }
    }

    var response=await http.post(Uri.parse('https://mymusawoee.000webhostapp.com/api/owner/doctor/editServe.php'),
        body:{
          "ID":encryp(widget.ID),
          "doc_id":encryp('$user_id'),
          "shopName":encryp('$bizname'),
          "email":encryp('$email1'),
          "image":encryp('$logo'),
          "service":encryp(_serve.text),
          "price":encryp(_price.text),
          "compared":encryp(_comp.text),
          "phone":encryp('$num1'),
          "booking":encryp(_book.text),
          "lon":encryp('$lon'),
          "lat":encryp('$lon'),
          "lunchClosingTime":encryp(_lunchClosingTime),
          "lunchOpeningTime":encryp(_lunchOpeningTime),
          "stopBooking": _stopBooking ? encryp("true" ): encryp("false"),
          "open": encryp(_clinicClosingTime),
          "close":encryp( _clinicOpeningTime),
          "dayCode":encryp( newDays),
          "serviceTime": encryp(_serviceTime.text),
        });

    if(response.statusCode==200){

      EasyLoading.showSuccess('Service  Edited...');



      }else{



      EasyLoading.showError('Failed to edit');

    }




  }


  // late List cat = [];
  List<ServiceDocModel> cat = [];
  Future showCat() async {
    var response = await http.post(
        Uri.parse("https://mymusawoee.000webhostapp.com/api/owner/doctor/servdoc.php"),
        headers: {"Accept": "headers/json"});
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          cat.add(ServiceDocModel.fromJson(item));
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

    Widget _appBar(title,fieldValue){

      return  AppBar(
        backgroundColor: Colors.lightGreen,
        iconTheme: const IconThemeData(color: Colors.white),
        shape: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
        automaticallyImplyLeading: false,
        title: Text('$title>$fieldValue',style: const TextStyle(color: Colors.white,fontSize: 14),),
      );
    }


    Widget _category(){

      return  Dialog(

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //going to use it so many times lets create our own app bar
            _appBar('Service ',''),

            Expanded(
              child: FutureBuilder(
                future: showCat(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount:cat.length ,
                      itemBuilder:(context,index){

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:NetworkImage(
                              'https://mymusawoee.000webhostapp.com/api/owner/doctor/doc/${cat[index].Im}',
                            ) ,
                          ),

                          onTap: (){

                            setState(() {
                              _serve.text=cat[index].Title;
                            });
                            Navigator.pop(context);

                          },
                          title: Text(cat[index].Title,style:const TextStyle(fontSize:15,color: Colors.black),),
                        );


                      });
                },
              ),
            ),
          ],

        ),
      );


    }

    Widget _ava(){

      return  Dialog(

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //going to use it so many times lets create our own app bar
            _appBar('Drug/Product ','Categories'),

            Expanded(
              child: FutureBuilder(
                future: showCat(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount:cat.length ,
                      itemBuilder:(context,index){

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:NetworkImage(
                              'https://mymusawoee.000webhostapp.com/api/owner/doctor/doc/${cat[index].Im}',
                            ) ,
                          ),

                          onTap: (){

                            setState(() {
                              _serve.text=cat[index].Title;
                            });
                            Navigator.pop(context);

                          },
                          title: Text(cat[index].Title,style:const TextStyle(fontSize:15,color: Colors.black),),
                        );


                      });
                },
              ),
            ),
          ],

        ),
      );


    }

    Widget  _buildDayCheckedBox(String title, bool checkedValue, int dayCode) {
      return CheckboxListTile(
        activeColor:Colors.lightGreen,
        title: Text(title),
        value: checkedValue,
        onChanged: (newValue) {
          switch (dayCode) {
            case 1:
              {
                setState(() {
                  _monCheckedValue = newValue!;
                  if (newValue) {
                    _dayCode.add(dayCode);
                  } else {
                    _dayCode.remove(dayCode);
                  }
                });
              }
              break;
            case 2:
              {
                setState(() {
                  _tueCheckedValue = newValue!;
                  if (newValue) {
                    _dayCode.add(dayCode);
                  } else {
                    _dayCode.remove(dayCode);
                  }
                });
              }
              break;
            case 3:
              {
                setState(() {
                  _wedCheckedValue = newValue!;
                  if (newValue) {
                    _dayCode.add(dayCode);
                  } else {
                    _dayCode.remove(dayCode);
                  }
                });
              }
              break;
            case 4:
              {
                setState(() {
                  _thuCheckedValue = newValue!;
                  if (newValue) {
                    _dayCode.add(dayCode);
                  } else {
                    _dayCode.remove(dayCode);
                  }
                });
              }
              break;
            case 5:
              {
                setState(() {
                  _friCheckedValue = newValue!;
                  if (newValue) {
                    _dayCode.add(dayCode);
                  } else {
                    _dayCode.remove(dayCode);
                  }
                });
              }
              break;
            case 6:
              {
                setState(() {
                  _satCheckedValue = newValue!;
                  if (newValue) {
                    _dayCode.add(dayCode);
                  } else {
                    _dayCode.remove(dayCode);
                  }
                });
              }
              break;
            case 7:
              {
                setState(() {
                  _sunCheckedValue = newValue!;
                  if (newValue) {
                    _dayCode.add(dayCode);
                  } else {
                    _dayCode.remove(dayCode);
                  }
                  print(_dayCode);
                });
              }
          }
        },
        controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
      );
    }

    Widget textField(String title) {
      return TextFormField(
        onTap: () async {
          TimeRange result = await showTimeRangePicker(
            start: TimeOfDay(
                hour: int.parse(_clinicOpeningTime.substring(0, 2)),
                minute: int.parse(_clinicOpeningTime.substring(3, 5))),
            end: TimeOfDay(
                hour: int.parse(_clinicClosingTime.substring(0, 2)),
                minute: int.parse(_clinicClosingTime.substring(3, 5))),
            strokeColor:Colors.lightGreen,
            handlerColor:Colors.lightGreen,
            selectedColor:Colors.lightGreen,
            context: context,
          );

          print("result " + result.toString());
          if (result != null) {
            setState(() {
              if (result.toString().substring(17, 22) ==
                  result.toString().substring(37, 42)) {


                showDialog(
                  context: (context),
                  builder:(context)=> AlertDialog(
                    shape:Border.all(color: Colors.grey),
                    backgroundColor: Colors.purple,
                    title:const Text('Message',style: TextStyle(color: Colors.white),),
                    content:const Text('Please Select Different Times',style: TextStyle(color: Colors.white),) ,
                    actions:<Widget> [

                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:MaterialStateProperty.all(Colors.lightGreen ),
                        ),
                        onPressed:(){
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel',style: TextStyle(color: Colors.white),),),

                    ],
                  ),
                );



              } else {
                _clinicOpeningTime = result.toString().substring(17, 22);
                _clinicClosingTime = result.toString().substring(37, 42);
                //_isEnableBtn = true;
              }
            });
          }

          print("op $_clinicOpeningTime clo $_clinicClosingTime");
        },
        readOnly: true,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          // prefixIcon:Icon(Icons.,),
          //labelText: title,
            hintText: title,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).dividerColor),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
            )),
      );
    }

    Widget luchTimetextField(String title) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: TextFormField(
          onTap: () async {
            // print("kkkkkkkkkkkkkkkkkkkkkk");
            TimeRange result = await showTimeRangePicker(
              start: TimeOfDay(
                  hour: int.parse(_lunchOpeningTime.substring(0, 2)),
                  minute: int.parse(_lunchOpeningTime.substring(3, 5))),
              end: TimeOfDay(
                  hour: int.parse(_lunchClosingTime.substring(0, 2)),
                  minute: int.parse(_lunchClosingTime.substring(3, 5))),
              strokeColor:Colors.lightGreen,
              handlerColor:Colors.lightGreen,
              selectedColor:Colors.lightGreen,
              context: context,
            );

            //  print("result>>>>>>>>>>>>>>>>>> " + result.toString());
            if (result != null) {
              setState(() {
                if (result.toString().substring(17, 22) ==
                    result.toString().substring(37, 42)) {

                  showDialog(
                    context: (context),
                    builder:(context)=> AlertDialog(
                      shape:Border.all(color: Colors.grey),
                      backgroundColor: Colors.purple,
                      title:const Text('Message',style: TextStyle(color: Colors.white),),
                      content:const Text('Please Select Different Times',style: TextStyle(color: Colors.white),) ,
                      actions:<Widget> [

                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:MaterialStateProperty.all(Colors.lightGreen ),
                          ),
                          onPressed:(){
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel',style: TextStyle(color: Colors.white),),),

                      ],
                    ),
                  );



                } else {
                  _lunchOpeningTime = result.toString().substring(17, 22);
                  _lunchClosingTime = result.toString().substring(37, 42);
                  //    isEnableBtn = true;
                }
              });
            }
          },
          readOnly: true,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              labelText: title,//Price before discount
              labelStyle: const TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  )
              )
          ),
        ),
      );
    }

    Widget _stopBookingWidget() {
      return ListTile(
        title: const Text("online booking"),
        subtitle: _stopBooking
            ? const Text("turn off to start online booking")
            : const Text("turn on to stop online booking"),
        trailing: IconButton(
          icon: _stopBooking
              ? const Icon(
            Icons.toggle_on_outlined,
            color: Colors.green,
            size: 35,
          )
              : const Icon(
            Icons.toggle_off_outlined,
            color: Colors.red,
            size: 35,
          ),
          onPressed: () {
            setState(() {
              _stopBooking = !_stopBooking;
            });
          },
        ),
      );
    }

    Widget  _serviceTimeInputField() {
      return TextFormField(
        maxLines: 1,
        controller: _serviceTime,
        validator: (item) {
          if (item!.length > 0) {
            if (item.length < 3) {
              return null;
            } else {
              return "Enter valid interval";
            }
          } else {
            return "Enter time interval";
          }
        },
        keyboardType: TextInputType.phone,
        decoration:InputDecoration(
            labelText:'Time interval in (MIN)',
            labelStyle: const TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                )
            )
        ),
      );
    }





    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Doctor Service ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
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
                        child: const Text('Service/Edit',style: TextStyle(color: Colors.lightGreen),),
                      ),
                    ),

                    MaterialButton(
                      color:Colors.lightGreen,
                      child:const Text('Save',style: TextStyle(color: Colors.white),),
                      onPressed:(){

                        if(_fomkey.currentState!.validate()){
                          EasyLoading.show(status: 'Editing Service.......');
                          savePro();
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
                              onTap: (){
                                //lets show the list of cars instead of manually typing
                                showDialog(context: context,builder: (BuildContext context){

                                  return _category();
                                });

                              },
                              child: TextFormField(
                                controller:_serve,
                                enabled: false,
                                validator: (value){
                                  if(value!.isEmpty){

                                    return 'Enter Service';
                                  }

                                  setState(() {
                                    serveName=value;
                                  });
                                  return null;
                                },
                                decoration: InputDecoration(
                                    labelText: 'Service',
                                    labelStyle: const TextStyle(color: Colors.grey),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                        )
                                    )
                                ),
                              ),
                            ),


                            _serviceTimeInputField(),

                            textField("Opening Time: $_clinicOpeningTime"),
                            textField("Closing Time: $_clinicClosingTime"),
                            luchTimetextField(
                                "Lunch Opening Time: $_lunchOpeningTime"),
                            luchTimetextField(
                                "Lunch Closing Time: $_lunchClosingTime"),
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                    "Select any days where you want to close booking in every week",
                                    style: TextStyle(
                                        fontSize: 14,fontWeight: FontWeight.bold
                                    )),
                              ),
                            ),
                            _buildDayCheckedBox("Monday", _monCheckedValue, 1),
                            _buildDayCheckedBox("Tuesday", _tueCheckedValue, 2),
                            _buildDayCheckedBox("Wednesday", _wedCheckedValue, 3),
                            _buildDayCheckedBox("Thursday", _thuCheckedValue, 4),
                            _buildDayCheckedBox("Friday", _friCheckedValue, 5),
                            _buildDayCheckedBox("Saturday", _satCheckedValue, 6),
                            _buildDayCheckedBox("Sunday", _sunCheckedValue, 7),




                            TextFormField(
                              validator: (value){
                                if(value!.isEmpty){

                                  return 'Enter Service Price';
                                }

                                setState(() {
                                  servePrice=value;
                                });
                                return null;
                              },

                              controller:_price,
                              keyboardType:TextInputType.number,
                              decoration: InputDecoration(

                                  labelText: 'Service Price*',
                                  labelStyle: const TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      )
                                  )
                              ),
                            ),


                            TextFormField(
                              validator: (value){
                                //not compulsary

                                if(value!.isEmpty){//always compared price should be higher
                                  return 'Compared Price should be higher than price';
                                }

                                setState(() {
                                  serveComp=value;
                                });
                                return null;
                              },

                              controller:_comp,
                              keyboardType:TextInputType.number,
                              decoration: InputDecoration(

                                  labelText: 'Compared Price*',//Price before discount
                                  labelStyle: const TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      )
                                  )
                              ),
                            ),



                            TextFormField(
                              controller:_book,
                              validator: (value){
                                if(value!.isEmpty){

                                  return 'Enter Booking Fee';
                                }

                                setState(() {
                                  serveBook=value;
                                });
                                return null;
                              },
                              decoration: InputDecoration(


                                  labelText: 'Booking Fee*',
                                  labelStyle: const TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      )
                                  )
                              ),
                            ),

                            _stopBookingWidget(),

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
