
class BusinessModel {
  final String ID;
  final String userID;
  final String Logo;
 final  String ShopIm;
  final String ShopNem;
 final  String Phone;
 final  String Mail;
 final  String Tax;
  final String Tin;
 final  String Ad;
  final String Lon;
  final String Lat;
 final  String Time1;
 final  String State1;
 final  String Serve;
 final  String open1;
 final  String Rating;
  final String totalRating1;
  final String isTopPicked;
  final String creat_t;

  BusinessModel({
      required this.ID,  required this.userID,  required this.Logo, required this.ShopIm,  required this.ShopNem,  required this.Phone,  required this.Mail,  required this.Tax,  required this.Tin,  required this.Ad,  required this.Lon,  required this.Lat, required this.Time1,  required this.State1,  required this.Serve,  required this.open1,  required this.Rating,  required this.totalRating1,  required this.isTopPicked,  required this.creat_t,
  });


 factory BusinessModel.fromJson(data){
    return   BusinessModel(
    ID:data['ID'],
     userID:data['user_id'],
     Logo:data['logo'],
     ShopIm:data['shopImage'],
     ShopNem:data['bizname'],
    Phone:data['phone1'],
    Mail:data['email1'],
    Tax:data['taxRegistered'],
    Tin:data['tinNumber'],
    Ad:data['address'],
    Lon:data['lon'],
    Lat:data['lat'],
    Time1:data['time1'],
    State1: data['status1'],
    Serve:data['service'],
    open1:data['shopOpen'],
    Rating:data['rating'],
    totalRating1:data['totalRating'],
    isTopPicked:data['isTopPicked'],
    creat_t:data['creat_t'],
    );
  }


   Map<String, dynamic> toMap() {
     return {
       "ID": ID,
       "user_id": userID,
       "logo": Logo,
       "shopImage":ShopIm,
       "bizname":ShopNem ,
       "phone1":Phone ,
       "email1":Mail ,
       "taxRegistered":Tax ,
       "tinNumber": Tin,
       "address":Ad ,
       "lon":Lon ,
       "lat":Lat ,
       "time1":Time1 ,
       "status1":State1 ,
       "service":Serve ,
       "shopOpen":open1 ,
       "rating": Rating,
       "totalRating":totalRating1 ,
       "isTopPicked":isTopPicked ,
       "create_t":creat_t ,
     };
   }



  factory BusinessModel.fromMap(Map<String, dynamic> data) {
    return BusinessModel(
      ID:data['ID'],
      userID:data['user_id'],
      Logo:data['logo'],
      ShopIm:data['shopImage'],
      ShopNem:data['bizname'],
      Phone:data['phone1'],
      Mail:data['email1'],
      Tax:data['taxRegistered'],
      Tin:data['tinNumber'],
      Ad:data['address'],
      Lon:data['lon'],
      Lat:data['lat'],
      Time1:data['time1'],
      State1: data['status1'],
      Serve:data['service'],
      open1:data['shopOpen'],
      Rating:data['rating'],
      totalRating1:data['totalRating'],
      isTopPicked:data['isTopPicked'],
      creat_t:data['creat_t'],
    );
  }

}
