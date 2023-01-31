import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../crypt/encrypt.dart';
import '../../../login/login.dart';
import '../../../pref/buz.dart';
import '../../../pref/pref.dart';
import '../../custom_drawer.dart';
import 'dart:io';
import 'dart:convert';

import '../../provider/shop.dart';

class AddDrug extends StatefulWidget {
  static const  String id='addrug';

  @override
  State<AddDrug> createState() => _AddDrugState();
}

class _AddDrugState extends State<AddDrug> {


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

  final List<String?> _collections=[
    'Featured Products',
    'Best Selling Products',
    'Recently Added'

  ];



  final List<String?> _measure=[
    'Kgs',
    'gms',
    'Ltrs',
    'Box',
    'Rolls',
    'Bottles'
  ];


  String? dropDownValue;

  bool? _track=false;

  @override
  void initState() {
    getPref();
    getBusiness();
    showCat();
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



  _scaffold(message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(message),
      action: SnackBarAction(label: 'Ok',onPressed: (){
        ScaffoldMessenger.of(context).clearSnackBars();
      },),));
  }


  Future savePro() async {

    EasyLoading.show(status: 'Saving Product...');

    var request=http.MultipartRequest('Post',Uri.parse('https://mymusawoee.000webhostapp.com/api/owner/whole/addPro.php'));
    request.fields['user_id']=encryp('$user_id');

    var photo = await http.MultipartFile.fromPath('shop',_proImage!.path);
    request.files.add(photo);



    request.fields['ownerName']=encryp('$name');
    request.fields['shopName']=encryp('$bizname');
    request.fields['productName']=encryp(_name.text);
    request.fields['descc']=encryp(_desc.text);
    request.fields['price']=encryp(_priceC.text);
    request.fields['compared']=encryp(_priceO.text);
    request.fields['collection']=encryp(_col.text);
    request.fields['brand']=encryp(_brand.text);
    request.fields['category']=encryp(_kate.text);
    request.fields['weight']=encryp(_kg.text);
    request.fields['tax']=encryp(_tax.text);







    var response=await request.send();

    if(response.statusCode==200){




      EasyLoading.showSuccess('Product Saved...');

    }else{

      EasyLoading.showError('Failed to save..');
    }


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
    var _shopPro=Provider.of<ShopProvider>(context);



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
            _appBar('Drug/Product','Collections'),
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

    Widget _listview1({fieldValue,list,textController}){

      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _appBar('Drug/Product','Measurement'),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: false,
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
                              'https://mymusawoee.000webhostapp.com/api/owner/drug/${cat[index]['image']}',
                            ) ,
                          ),

                          onTap: (){

                            setState(() {
                              _kate.text=cat[index]['category'];
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
        title: const Text('Add Drugs/Products ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
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
                        child: const Text('Products/Add',style: TextStyle(color: Colors.lightGreen),),
                      ),
                    ),

                    MaterialButton(
                      color:Colors.lightGreen,
                      child:const Text('Save',style: TextStyle(color: Colors.white),),
                      onPressed:(){

                        if(_proImage==null){
                          _scaffold('Product Image not Selected');
                          return;

                        }


                        if(_fomkey.currentState!.validate()){
                          EasyLoading.show(status: 'Saving Product.......');

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
                padding: EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.grey.shade100,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [


                            TextFormField(
                              controller:_name,
                              validator: (value){
                                if(value!.isEmpty){

                                  return 'Enter Product Name';
                                }

                                setState(() {
                                  proName=value;
                                });
                                return null;
                              },
                              decoration: InputDecoration(


                                  labelText: 'Product Name*',
                                  labelStyle: const TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      )
                                  )
                              ),
                            ),

                            TextFormField(
                              keyboardType:TextInputType.multiline,
                              maxLines: 5,
                              maxLength: 500,
                              validator: (value){
                                if(value!.isEmpty){

                                  return 'Enter Drug/Product Description';
                                }

                                setState(() {
                                  proDesc=value;
                                });
                                return null;
                              },

                              controller:_desc,
                              decoration: InputDecoration(
                                  labelText: 'Drug/Product Description*',
                                  labelStyle: const TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      )
                                  )
                              ),
                            ),


                            //try
                            _proImage==null ?
                            Container(
                                color: Colors.lightGreen,
                                height: 150,
                                width: 150,
                                child: TextButton(
                                  child:const Center(
                                    child: Text('Tap to add Drug/Product Image',style: TextStyle(color:Colors.white ),
                                    ),
                                  ),
                                  onPressed: ()
                                  {
                                    _pickImage().then((value){
                                      setState(() {
                                        _proImage=value;
                                      });
                                    });

                                  },
                                )
                            ): InkWell(
                              onTap: ()
                              {
                                _pickImage().then((value){
                                  setState(() {
                                    _proImage=value;
                                  });
                                });

                              },
                              child: Container(
                                height: 150,
                                width: 150,

                                decoration:BoxDecoration(
                                  color: Colors.lightBlue,
                                  image:DecorationImage(

                                      image:FileImage(File(_proImage!.path),),
                                      fit: BoxFit.cover

                                  ),

                                ),
                              ),
                            ),


                            //failed
                            //  InkWell(
                            //    onTap: (){
                            //
                            //      _pickImage().then((value){
                            //        setState(() {
                            //          _proImage=value;
                            //        });
                            //      });
                            //
                            //    },
                            //    child:  Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child:  _proImage==null ? const SizedBox(
                            //       height: 150,
                            //       width:150,
                            //       child: Card(
                            //         child: Center(
                            //           child: Text('Product Image*'),
                            //         ),
                            //       ),
                            //     ): SizedBox(
                            //       height: 150,
                            //       width:150,
                            //       child: Card(
                            //         child:Container(
                            //             decoration:BoxDecoration(
                            //               color: Colors.lightBlue,
                            //               image:DecorationImage(
                            //
                            //                   image:FileImage(File(_proImage!.path),),
                            //                   fit: BoxFit.cover
                            //
                            //               ),
                            //
                            //             )
                            //         ),
                            //
                            //       ),
                            //     ),
                            // ),
                            //  ),


                            TextFormField(
                              validator: (value){
                                if(value!.isEmpty){

                                  return 'Enter Product Price';
                                }

                                setState(() {
                                  proPC=value;
                                });
                                return null;
                              },

                              controller:_priceC,
                              keyboardType:TextInputType.number,
                              decoration: InputDecoration(

                                  labelText: 'Price*',
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
                                  proPO=value;
                                });
                                return null;
                              },

                              controller:_priceO,
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

                                validator: (value){

                                  if(value!.isEmpty){
                                    return 'Please Enter Collection';
                                  }
                                  return null;
                                },

                              ),
                            ),


                            TextFormField(
                              controller:_brand,
                              validator: (value){
                                if(value!.isEmpty){

                                  return 'Enter Product Brand';
                                }

                                setState(() {
                                  proBrand=value;
                                });
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Brand',
                                  labelStyle: const TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      )
                                  )
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
                                controller:_kate,
                                enabled: false,
                                validator: (value){
                                  if(value!.isEmpty){

                                    return 'Enter Product Category';
                                  }

                                  setState(() {
                                    proCate=value;
                                  });
                                  return null;
                                },
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



                            InkWell(
                              onTap: (){

                                showDialog(context: context, builder:(BuildContext context){
                                  return _listview1(fieldValue: 'Measurement',list: _measure,textController: _kg);

                                });
                              },
                              child: TextFormField(
                                controller:_kg,
                                enabled: false,//enter manually now
                                decoration:const InputDecoration(
                                  labelText: 'Weight e.g kg,gm litrs ,etc',
                                  counterText: 'Weight e.g kg,gm litrs ,etc',
                                ),

                                validator: (value){

                                  if(value!.isEmpty){
                                    return 'Please Enter Measurement';
                                  }
                                  return null;
                                },

                              ),
                            ),


                            TextFormField(
                              controller:_tax,
                              keyboardType: TextInputType.number,
                              validator: (value){
                                if(value!.isEmpty){

                                  return 'Enter  Tax%';
                                }

                                setState(() {
                                  proTax=value;
                                });
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Tax%',
                                  labelStyle: const TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      )
                                  )
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
