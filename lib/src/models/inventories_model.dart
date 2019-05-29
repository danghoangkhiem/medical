class InventoriesModel{
  List<InventoriesItem> listInventories;

  InventoriesModel({this.listInventories});

  factory InventoriesModel.fromJson(List<dynamic> json){
    List<InventoriesItem> mapInventories = List<InventoriesItem>.from(json.map((item){
      return InventoriesItem.fromJson(item);
    }));

    return InventoriesModel(listInventories: mapInventories.toList());
  }
}

class InventoriesItem{
  final int key;
  final String label;
  final int import;
  final int export;
  final int stock;

  InventoriesItem({this.key, this.label,this.import, this.export, this.stock});

  factory InventoriesItem.fromJson(Map<String, dynamic> json){
    return InventoriesItem(
      key: json["key"],
      label: json["label"],
      import: json["import"],
      export: json["export"],
      stock: json["stock"]
    );
  }

}

