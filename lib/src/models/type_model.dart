class TypeModel{
  List<TypeItem> type;

  TypeModel(this.type);

  factory TypeModel.fromJson(List<dynamic> json){
    List<TypeItem> mapType = List<TypeItem>.from(json.map((item){
      return TypeItem.fromJson(item);
    }));

    return TypeModel(mapType.toList());
  }
}

class TypeItem{

  final int id;
  final String name;

  TypeItem({this.id, this.name});

  factory TypeItem.fromJson(Map<String, dynamic> json){
    return TypeItem(
      id: json["id"],
      name: json["name"]
    );
  }
}