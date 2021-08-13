import 'package:json_annotation/json_annotation.dart';

part 'specialist.g.dart';

@JsonSerializable(explicitToJson: true)
class Specialists {
  int id;
  int name;

  Specialists({this.id, this.name});

  factory Specialists.fromJson(Map<String, dynamic> json) =>
      _$SpecialistsFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialistsToJson(this);
}
