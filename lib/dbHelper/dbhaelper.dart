import 'dart:async';

import 'package:musawowange_admin/models/Service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/available.dart';
import '../models/business.dart';
import '../models/person.dart';


class DBConn{

  late Database _db;

  Future<Database> get ebdata async {

    if(_db==null){

      _db=await initDB();
    }

    return _db;

  }

  Future<Database> initDB() async{
    String dbPath=join(await getDatabasesPath(),"ebdata.db");
    var eTradeDb=await openDatabase(dbPath,version: 1,onCreate: createDB);
    return eTradeDb;
  }


  //Business
  Future<void> createDB(Database ebdata,int version) async{
    await ebdata.execute("CREATE TABLE business(ID int,user_id text,logo text,shopImage text,bizname text, phone1 text, email1 text,taxRegistered text,tinNumber text, address text, lon text, lat text,time1 text, status1 text,service text,shopOpen text,rating text,totalRating text,isTopPicked text,create_t text)");
    await ebdata.execute("CREATE TABLE specialist(id int,title text,desc1 text,image text,)");
    await ebdata.execute("CREATE TABLE availability(id int,mon text,tues text,wed text,thurs text,fri text,sat text,sun text,)");
    await ebdata.execute("CREATE TABLE docserve(ID int,cli_id text,doc_id text,dept_id text,service text,price text,compared text,booking text,openi text,close text,created text,update1 text,day text,)");
  }

  Future<int>  insertData( BusinessModel trndata) async{
    final Database db= await this.ebdata;
    var result=await db.insert("business", trndata.toMap());
    return result;
  }


  Future<List> getAllRecords(String dbTable) async{
    var dbClient=await this.ebdata;
    var result=await dbClient.rawQuery("SELECT * FROM business");
    return result.toList();
  }

  Future<void> updateTrans( BusinessModel busdata) async {
    Database db =await this.ebdata;
    var result =await db.update("business",busdata.toMap(),
    where:"ID=?" ,
    whereArgs: [busdata.ID]
  );
}


Future<int> deleteTrans(String ID) async {
    final db=await this.ebdata;
    var result= await db.rawDelete("delete * from business where ID=$ID");
    return result;

}

Future<int> deleteAllTrans() async{
  final db=await this.ebdata;
  var result= await db.rawDelete("delete * from business");
  return result;

}



//Service
  Future<int>  insertServiceData( ServiceDocModel trndata) async{
    final Database db= await this.ebdata;
    var result=await db.insert("specialist", trndata.toMap());
    return result;
  }


  Future<List> getAllServiceRecords(String dbTable) async{
    var dbClient=await this.ebdata;
    var result=await dbClient.rawQuery("SELECT * FROM specialist");
    return result.toList();
  }

  Future<void> updateServiceData( ServiceDocModel busdata) async {
    Database db =await this.ebdata;
    var result =await db.update("specialist",busdata.toMap(),
        where:"id=?" ,
        whereArgs: [busdata.ID]
    );
  }


  Future<int> deleteDocervice(String ID) async {
    final db=await this.ebdata;
    var result= await db.rawDelete("delete * from specialist where id=$ID");
    return result;

  }

  Future<int> deleteAllDocServices() async{
    final db=await this.ebdata;
    var result= await db.rawDelete("delete * from specialist");
    return result;

  }


  //available
  Future<int>  insertAvaData( AvaModel  trndata) async{
    final Database db= await this.ebdata;
    var result=await db.insert("availability", trndata.toMap());
    return result;
  }


  Future<List> getAllAvaRecords(String dbTable) async{
    var dbClient=await this.ebdata;
    var result=await dbClient.rawQuery("SELECT * FROM availability");
    return result.toList();
  }

  Future<void> updateAvaData( AvaModel busdata) async {
    Database db =await this.ebdata;
    var result =await db.update("availability",busdata.toMap(),
        where:"id=?" ,
        whereArgs: [busdata.ID]
    );
  }


  Future<int> deleteAva(String ID) async {
    final db=await this.ebdata;
    var result= await db.rawDelete("delete * from availability where id=$ID");
    return result;

  }

  Future<int> deleteAllAva() async{
    final db=await this.ebdata;
    var result= await db.rawDelete("delete * from availability");
    return result;

  }




  //Doc Services
  Future<int>  insertPaData(PersonalServiceModel  trndata) async{
    final Database db= await this.ebdata;
    var result=await db.insert("docserve", trndata.toMap());
    return result;
  }


  Future<List> getAllPaRecords(String dbTable) async{
    var dbClient=await this.ebdata;
    var result=await dbClient.rawQuery("SELECT * FROM  docserve");
    return result.toList();
  }

  Future<void> updatePaData(PersonalServiceModel busdata) async {
    Database db =await this.ebdata;
    var result =await db.update(" docserve",busdata.toMap(),
        where:"ID=?" ,
        whereArgs: [busdata.ID]
    );
  }


  Future<int> deletePa(String ID) async {
    final db=await this.ebdata;
    var result= await db.rawDelete("delete * from  docserve where ID=$ID");
    return result;

  }

  Future<int> deleteAllPa() async{
    final db=await this.ebdata;
    var result= await db.rawDelete("delete * from  docserve");
    return result;

  }



}