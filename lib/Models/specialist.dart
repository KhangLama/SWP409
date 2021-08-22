import 'package:json_annotation/json_annotation.dart';

part 'specialist.g.dart';

@JsonSerializable(explicitToJson: true)
class Specialists {
  String id;
  String name;
  List symptoms;

  Specialists({this.id, this.name, this.symptoms});

  factory Specialists.fromJson(Map<String, dynamic> json) =>
      _$SpecialistsFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialistsToJson(this);
}
