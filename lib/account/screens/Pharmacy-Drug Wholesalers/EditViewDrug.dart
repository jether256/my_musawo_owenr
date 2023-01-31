import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:musawowange_admin/crypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../login/login.dart';
import '../../../pref/buz.dart';
import '../../../pref/pref.dart';

class EditViewDrug extends StatefulWidget {
  static const  String id='edit-drug';


  final String productId;
  final String proNa;
  final String proPrice;
  final String proDe;
  final String proBra;
  final String proCol;
  final String proTax;
  final String prowei;
  final String procom;
  final String procat;
  final String pro_id;

  final String proImage;
  EditViewDrug({ required this.productId, required this.proNa, required this.proPrice, required this.proDe, required this.proBra, required this.proCol, required this.proTax, required this.prowei, required this.procom, required this.procat, required this.proImage, required this.pro_id}) ;


  @override
  State<EditViewDrug> createState() => _EditViewDrugState();
}

class _EditViewDrugState extends State<EditViewDrug> {


  final _fomkey=GlobalKey<FormState>();

  final _brand=TextEditingController();
  final _proName=TextEditingController();
  final _wei=TextEditingController();
  final _price=TextEditingController();
  final _com=TextEditingController();
  final _desss=TextEditingController();
  final _cat=TextEditingController();
  final _col=TextEditingController();
  final _tax=TextEditingController();
  late double discount;
  late String? image;



  final List<String?> _collections=[
    'Featured Products',
    'Best Selling Products',
    'Recently Added'

  ];

  @override
  void initState() {
    getProducts();
    getPref();
    getBusiness();
    showCat();
    super.initState();
  }

  late List cat = [];
  Future showCat() async {
    var response = await http.post(
        Uri.parse("https://mymusawoee.000webhostapp.com/api/owner/whole/cat.php"),
        headers: {"Accept": "headers/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);


      setState(() {
        cat = jsonData;

      });

      print(jsonData);
      return jsonData;
    }
  }
  getProducts() async{



    setState(() {
      _brand.text=widget.proBra;
      _proName.text=widget.proNa;
      _wei.text=widget.prowei;
      _price.text=widget.proPrice;
      _com.text=widget.procom;
      _col.text=widget.procom;
      _desss.text=widget.proDe;
      _cat.text=widget.procat;
      _col.text=widget.proCol;
      _tax.text=widget.proTax;
      image=widget.proImage;
      //var difference=int.parse(_com.text)-double.parse(_price.text);
      discount=(double.parse(_price.text)/int.parse(_com.text)*100);
      //discount=(difference/int.parse(_com.text)*100);
    });


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



  Future savePro() async {

    EasyLoading.show(status: 'Saving.......');

    var response=await http.post(Uri.parse('https://mymusawoee.000webhostapp.com/api/owner/whole/editPro.php'),

        body:{
          "pro_id":encryp(widget.pro_id),
          "user_id":encryp('$user_id'),
          "productName":encryp(_proName.text),
          "brand":encryp(_brand.text),
          "weight":encryp(_wei.text),
          "price":encryp(_price.text),
          "compared":encryp(_com.text),
          "descc":encryp(_desss.text),
          "category":encryp(_cat.text),
          "collection":encryp(_col.text),
        });



    if(response.statusCode==200){
      var userData=json.decode(response.body);

      if(userData=="done"){




        EasyLoading.showSuccess('Product Edited...');


      }else{


        EasyLoading.showError('Failed to Edit..');

        print(userData);
      }

    }




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



    Widget _listview({fieldValue,list,textController}){

      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _appBar('Spare','Collections'),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder:(BuildContext context, int index){
                    return ListTile(
                      onTap: (){
                        textController.text=list[index];
                        Navigator.pop(context);
                      },


                      title: Text(list[index]),

                    );
                  }),
            )
          ],
        ),
      );
    }


    Widget _category(){

      return  Dialog(

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //going to use it so many times lets create our own app bar
            _appBar('Drugs/Products ','Categories'),

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
                              'https://mymusawoee.000webhostapp.com/api/owner/drug/${cat[index]['image']}',
                            ) ,
                          ),

                          onTap: (){

                            setState(() {
                              _cat.text=cat[index]['category'];
                            });
                            Navigator.pop(context);

                          },
                          title: Text(cat[index]['category'],style:const TextStyle(fontSize:15,color: Colors.black),),
                        );


                      });
                },
              ),
            ),
          ],

        ),
      );


    }



    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(widget.proNa,style: const TextStyle(color: Colors.white),),
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
      bottomSheet: Container(
        height: 60,
        child: Row(
          children: [
            Expanded(child: InkWell(
                onTap: ()
                {
                Navigator.pop(context);
                },
                child: Container(color:Colors.black12,child: const Center(child: Text('Cancel',style: TextStyle(color: Colors.white),)),
                ))),
            Expanded(child: InkWell(
                onTap: ()
                {


                  if(_fomkey.currentState!.validate()){

                    savePro();

                  }

                },
                child: Container(color:Colors.lightBlue,child: const Center(child: Text('Save',style: TextStyle(color: Colors.white))),))),

          ],
        ),
      ),
      body:Form(
        key:_fomkey ,
        child:Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 60),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Product ID:'),
                      Container(

                        child:Text(widget.pro_id,style: const TextStyle(color:Colors.redAccent,fontSize: 15),) ,

                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 30,
                        width: 200,
                        child: TextFormField(
                          controller: _brand,

                          decoration: InputDecoration(
                              hintText: 'Brand',
                              hintStyle: const TextStyle(color:Colors.grey),
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor:Colors.lightBlue.withOpacity(.1),
                              contentPadding: const EdgeInsets.only(left: 10,right: 10)

                          ),
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: 20,
                    child: TextFormField(
                      controller: _proName,

                      style: const TextStyle(fontSize: 30),
                      decoration: const InputDecoration(
                        border: InputBorder.none,

                        hintText: 'Product Name',
                        hintStyle: TextStyle(color:Colors.redAccent),


                        contentPadding: EdgeInsets.zero,

                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: _wei,

                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Weight',
                        hintStyle: TextStyle(color:Colors.grey),


                        contentPadding: EdgeInsets.zero

                    ),
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Container(
                          width: 80,
                          child: TextFormField(
                            controller: _price,

                            style: const TextStyle(fontSize: 15, ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixText: '\Shs',
                              hintText: 'Price',
                              hintStyle: TextStyle(color:Colors.grey),

                              contentPadding: EdgeInsets.zero,

                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 80,
                          child: TextFormField(
                            controller: _com,

                            style: const TextStyle(fontSize: 15,decoration:TextDecoration.lineThrough),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixText: '\Shs',
                                hintText: 'Price',
                                hintStyle: TextStyle(color:Colors.grey),

                                contentPadding: EdgeInsets.zero

                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(3)
                          ),
                          child: Text('${discount.toStringAsFixed(0)} % OFF',style: const TextStyle(color:Colors.white),),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10,),
                  const Text('Inclusive of all Taxes',style:TextStyle(color: Colors.grey,fontSize: 20),),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:Container(height:300,child: CachedNetworkImage(imageUrl:'https://mymusawoee.000webhostapp.com/api/owner/whole/product/${widget.proImage}')),
                  ),

                  const Text("About this Product",style: TextStyle(fontSize: 20),),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: null,
                      controller: _desss,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(color: Colors.grey),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),

                    ),
                  ),

                  InkWell(
                    onTap: (){
                      //lets show the list of cars instead of manually typing
                      showDialog(context: context,builder: (BuildContext context){

                        return _category();
                      });

                    },
                    child: TextFormField(
                      controller:_cat,
                      enabled: false,
                      decoration: InputDecoration(
                          labelText: 'Category',
                          labelStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              )
                          )
                      ),
                    ),
                  ),
                  //
                  InkWell(
                    onTap: (){

                      showDialog(context: context, builder:(BuildContext context){
                        return _listview(fieldValue: 'Collections',list: _collections,textController: _col);

                      });
                    },
                    child: TextFormField(
                      controller: _col,

                      enabled: false,//enter manually now

                      decoration:const InputDecoration(
                        labelText: 'Collection',
                        counterText: 'Collection',
                      ),


                    ),
                  ),

                  Row(
                    children:  [
                      const Text('Tax %:'),
                      Expanded(
                        child: TextFormField(
                          controller: _tax,

                          style: const TextStyle(fontSize: 15, ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,


                            hintStyle: TextStyle(color:Colors.grey),

                            contentPadding: EdgeInsets.zero,

                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],

          ),
        ),

      ),
    );
  }
}
