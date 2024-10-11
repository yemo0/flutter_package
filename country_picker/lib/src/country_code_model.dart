import 'dart:convert';

CountryCodeModel countryCodeModelFromJson(String str) => CountryCodeModel.fromJson(json.decode(str));

String countryCodeModelToJson(CountryCodeModel data) => json.encode(data.toJson());

class CountryCodeModel {
  String? e164Cc;
  String? iso2Cc;
  int? e164Sc;
  bool? geographic;
  int? level;
  String? name;
  String? example;
  String? displayName;
  String? fullExampleWithPlusSign;
  String? displayNameNoE164Cc;
  String? e164Key;

  CountryCodeModel({
    this.e164Cc,
    this.iso2Cc,
    this.e164Sc,
    this.geographic,
    this.level,
    this.name,
    this.example,
    this.displayName,
    this.fullExampleWithPlusSign,
    this.displayNameNoE164Cc,
    this.e164Key,
  });

  factory CountryCodeModel.fromJson(Map<String, dynamic> json) => CountryCodeModel(
        e164Cc: json["e164_cc"],
        iso2Cc: json["iso2_cc"],
        e164Sc: json["e164_sc"],
        geographic: json["geographic"],
        level: json["level"],
        name: json["name"],
        example: json["example"],
        displayName: json["display_name"],
        fullExampleWithPlusSign: json["full_example_with_plus_sign"],
        displayNameNoE164Cc: json["display_name_no_e164_cc"],
        e164Key: json["e164_key"],
      );

  Map<String, dynamic> toJson() => {
        "e164_cc": e164Cc,
        "iso2_cc": iso2Cc,
        "e164_sc": e164Sc,
        "geographic": geographic,
        "level": level,
        "name": name,
        "example": example,
        "display_name": displayName,
        "full_example_with_plus_sign": fullExampleWithPlusSign,
        "display_name_no_e164_cc": displayNameNoE164Cc,
        "e164_key": e164Key,
      };
}
