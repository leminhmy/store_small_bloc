class MapModel{
  int? id;
  String? idProvince;
  String? idDistrict;
  String? idCommune;
  String? name;

  MapModel({
   required this.id,
   required this.idProvince,
   required this.idDistrict,
   required this.idCommune,
   required this.name,
  });

  MapModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    idProvince = json['idProvince'];
    idDistrict = json['idDistrict'];
    idCommune = json['idCommune'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "idProvince": this.idProvince,
      "idDistrict": this.idDistrict,
      "idCommune": this.idCommune,
      "name": this.name,
    };
  }
}