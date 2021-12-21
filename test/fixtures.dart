import 'dart:convert';
import 'dart:io';

class Fixtures {
  List<Valid> valid;
  List<Invalid> invalid;

  Fixtures({required this.valid, required this.invalid});

  Fixtures.fromJSON(Map<dynamic, dynamic> json)
      : valid = json['valid']
            .cast<Map<String, dynamic>>()
            .map((v) => Valid.fromJson(v))
            .cast<Valid>()
            .toList(),
        invalid = json['invalid']
            .cast<Map<String, dynamic>>()
            .map((v) => Invalid.fromJson(v))
            .cast<Invalid>()
            .toList();
}

class Valid {
  String address;
  String uri;
  bool compliant;
  Map<String, dynamic>? options;
  String? urnScheme;

  Valid(
      {required this.address,
      required this.uri,
      required this.compliant,
      required this.options,
      required this.urnScheme});

  Valid.fromJson(Map<dynamic, dynamic> json)
      : address = json['address'],
        uri = json['uri'],
        compliant = json['compliant'] ?? false,
        options = json['options'] != null
            ? Map<String, dynamic>.from(json['options'])
            : null,
        urnScheme = json['urnScheme'];
}

class Invalid {
  String exception;
  String? uri;
  String? address;
  Map<String, dynamic>? options;

  Invalid(
      {required this.exception,
      required this.uri,
      required this.address,
      required this.options});

  Invalid.fromJson(Map<dynamic, dynamic> json)
      : exception = json['exception'],
        uri = json['uri'],
        address = json['address'],
        options = json['options'] != null
            ? Map<String, dynamic>.from(json['options'])
            : null;
}

String _jsonString = File('test/fixtures.json').readAsStringSync();
Map<String, dynamic> _json = jsonDecode(_jsonString);

Fixtures fixtures = Fixtures.fromJSON(_json);
