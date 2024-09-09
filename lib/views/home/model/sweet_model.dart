class SweetModel {
  int? id;
  int? percent;
  String? name;

  SweetModel({
    this.id,
    this.percent,
    this.name,
  });

  factory SweetModel.fromJSON(Map<String, dynamic> json) {
    return SweetModel(
      id: json['sweet_id'] ?? 0,
      percent: json['sweet_num'] ?? 0,
      name: json['sweet_desc'] ?? '',
    );
  }
}
