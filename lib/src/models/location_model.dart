class LocationModel {
  final int id;
  final String name;

  LocationModel({this.id, this.name});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(id: json["id"], name: json["name"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}