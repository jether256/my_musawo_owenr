class AvaModel {
  final String ID;
  final String mon;
  final  String tues;
  final  String wed;
  final  String thurs;
  final  String fri;
  final  String sat;
  final  String sun;
  final String up;

  AvaModel({
  required this.ID, required this.mon, required this.tues, required this.wed, required this.thurs, required this.fri, required this.sat, required this.sun, required this.up,
});


  factory AvaModel.fromJson(data){
    return   AvaModel(
      ID:data['id'],
      mon:data['mon'],
      tues:data['tues'],
      wed:data['wed'],
      thurs:data['thurs'],
      fri:data['fri'],
      sat:data['sat'],
      sun:data['sun'],
      up:data['update1'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      "id": ID,
      "mon":mon,
      "tues":tues,
      "wed":wed,
      "thurs":thurs,
      "fri":fri,
      "sat":sat,
      "sun":sun,
      "update1":up,
    };
  }



  factory AvaModel.fromMap(Map<String, dynamic> data) {
    return   AvaModel(
      ID:data['id'],
      mon:data['mon'],
      tues:data['tues'],
      wed:data['wed'],
      thurs:data['thurs'],
      fri:data['fri'],
      sat:data['sat'],
      sun:data['sun'],
      up:data['update1'],
    );
  }

}
