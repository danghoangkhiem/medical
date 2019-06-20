class MedRepModel{
  List<MedRepItem> listMedRep;

  MedRepModel(this.listMedRep);

  factory MedRepModel.fromJson(List<dynamic> json){
    List<MedRepItem> mapMedRep = List<MedRepItem>.from(json.map((item){
      return MedRepItem.fromJson(item);
    }));

    return MedRepModel(mapMedRep.toList());

  }

}

class MedRepItem{
  final String name;
  final String code;

  MedRepItem({this.name, this.code});

  factory MedRepItem.fromJson(Map<String, dynamic> json){
    return MedRepItem(
      name: json["name"],
      code: json["code"]
    );
  }
}