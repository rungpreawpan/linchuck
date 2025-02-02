class UnitModel {
  int? unitId;
  String? unitName;
  String? unitNameEn;

  UnitModel({
    this.unitId,
    this.unitName,
    this.unitNameEn,
  });

  factory UnitModel.fromJSON(Map<String, dynamic> json) {
    return UnitModel(
      unitId: json['unit_id'] ?? 0,
      unitName: json['unit_name'] ?? '',
      unitNameEn: json['unit_name_en'] ?? '',
    );
  }
}
