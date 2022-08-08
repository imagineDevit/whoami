import 'package:henri_sedjame/models/me.dart';

class Data {
  late final Me me;

  Data();

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data()
        ..me = Me.fromJson(json["me"]);
  }
}