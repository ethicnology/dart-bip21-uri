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
  double? amount;
  String? label;
  String? message;
  Map<String, dynamic>? options;
  String? scheme;

  Valid({
    required this.address,
    required this.uri,
    required this.amount,
    required this.label,
    required this.message,
    required this.options,
    required this.scheme,
  });

  Valid.fromJson(Map<dynamic, dynamic> json)
      : address = json['address'],
        uri = json['uri'],
        amount = json['amount'],
        label = json['label'],
        message = json['message'],
        options = json['options'] != null
            ? Map<String, dynamic>.from(json['options'])
            : null,
        scheme = json['scheme'];
}

class Invalid {
  String exception;
  double? amount;
  String? label;
  String? message;
  String? uri;
  String? address;
  Map<String, dynamic>? options;

  Invalid({
    required this.exception,
    required this.amount,
    required this.label,
    required this.message,
    required this.uri,
    required this.address,
  });

  Invalid.fromJson(Map<dynamic, dynamic> json)
      : exception = json['exception'],
        uri = json['uri'],
        address = json['address'],
        amount = json['amount'],
        label = json['label'],
        message = json['message'],
        options = json['options'] != null
            ? Map<String, dynamic>.from(json['options'])
            : null;
}

String _jsonString = File('test/fixtures.json').readAsStringSync();
Map<String, dynamic> _json = jsonDecode(_jsonString);

Fixtures fixtures = Fixtures.fromJSON(_json);
