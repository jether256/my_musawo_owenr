class UserModel {

  final String ID;
  final  String name;
  final String  email;
  final String  num;
  final  String  pass;
  final String  pic;
  final String  lo;
  final String  lat;
  final String  ad;
  final  String  city;
  final String  country;
  final String  status;
  final  String  type;
  final String  log;
  final String  create;
  final String  create_date;
  final String  create_t;
  final String  update_t;
  final String  fcmid;

  UserModel({required this.ID,required this.name,required this.email,required this.num,required this.pass,required this.pic,required this.lo,required this.lat,required this.ad,required this.city,required this.country,required this.status,required this.type,required this.log,required this.create,required this.create_date, required this.create_t, required this.fcmid,required this.update_t,  });


  factory UserModel.fromJson(json){
    return   UserModel(
      ID:json['id'],
      name:json['name'],
      email:json['email'],
      num:json['number'],
      pass:json['password'],
      pic :json['pic'],
      lo:json['lon'],
      lat:json['lat'],
      ad:json['address'],
      city:json['city'],
      country:json['country'],
      status:json['status'],
      type:json['type'],
      create:json['create'],
      log:json['last_log'],
      create_date: json['create_date'],
      create_t: json['create_t'],
      update_t: json['update_t'],
      fcmid: json['fcmid'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      "id": ID,
      "name":name,
      "email":email,
      "number":num,
      "password":pass,
      "pic":pic,
      "lon":lo,
      "lat":lat,
      "address":ad,
      "city":city,
      "country":country,
      "status":status,
      "type":type,
      "create":create,
      "last_log":log,
      "create_date":create_date,
      "create_t":create_t,
      "update_t":update_t,
      "fcmid":fcmid,
    };
  }



  factory UserModel.fromMap(Map<String, dynamic> json) {
    return   UserModel(
      ID:json['id'],
      name:json['name'],
      email:json['email'],
      num:json['number'],
      pass:json['password'],
      pic :json['pic'],
      lo:json['lon'],
      lat:json['lat'],
      ad:json['address'],
      city:json['city'],
      country:json['country'],
      status:json['status'],
      type:json['type'],
      create:json['create'],
      log:json['last_log'],
      create_date: json['create_date'],
      create_t: json['create_t'],
      update_t: json['update_t'],
      fcmid: json['fcmid'],
    );
  }

}
