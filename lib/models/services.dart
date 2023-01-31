class ServiceModel {
  final String ID;
  final String Nem;
  final  String Im;

  ServiceModel({
    required this.ID,  required this.Nem,required this.Im,
  });


  factory ServiceModel.fromJson(data){
    return   ServiceModel(
      ID:data['id'],
      Nem:data['name'],
      Im:data['pic'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      "id": ID,
      "name":Nem,
      "pic":Im,
    };
  }



  factory ServiceModel.fromMap(Map<String, dynamic> data) {
    return   ServiceModel(
      ID:data['id'],
      Nem:data['name'],
      Im:data['pic'],
    );
  }

}
