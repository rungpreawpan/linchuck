class OptionsModel {
  int? id;
  String? name;
  List<OptionsDataModel>? optionsDataModel;

  OptionsModel({
    this.id,
    this.name,
    this.optionsDataModel,
  });

  factory OptionsModel.fromJSON(Map<String, dynamic> json) {
    return OptionsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      optionsDataModel: List.from(json['options'])
          .map((e) => OptionsDataModel.fromJSON(e))
          .toList(),
    );
  }
}

class OptionsDataModel {
  int? optionId;
  String? optionName;

  OptionsDataModel({
    this.optionId,
    this.optionName,
  });

  factory OptionsDataModel.fromJSON(Map<String, dynamic> json) {
    return OptionsDataModel(
      optionId: json['option_id'] ?? 0,
      optionName: json['option_name'] ?? '',
    );
  }
}
