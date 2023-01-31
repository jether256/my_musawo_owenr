class ServiceDocModel {
  final String ID;
  final String Title;
  final String Desc;
  final  String Im;

  ServiceDocModel({
    required this.ID,  required this.Title,  required this.Desc, required this.Im,
  });


  factory ServiceDocModel.fromJson(data){
    return   ServiceDocModel(
      ID:data['id'],
      Title:data['title'],
      Desc:data['desc1'],
      Im:data['image'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      "id": ID,
      "title":Title,
      "desc1":Desc,
      "image":Im,
    };
  }



  factory ServiceDocModel.fromMap(Map<String, dynamic> data) {
    return ServiceDocModel(
      ID:data['id'],
      Title:data['title'],
      Desc:data['desc1'],
      Im:data['image'],
    );
  }

}
