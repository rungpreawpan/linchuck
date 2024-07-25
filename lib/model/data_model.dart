class DataModel {
  int? id;
  String? name;

  DataModel({
    this.id,
    this.name,
  });

  factory DataModel.fromJSON(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}
