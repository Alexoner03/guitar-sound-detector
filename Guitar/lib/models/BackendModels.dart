// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  UserInfo({
    required this.id,
    required this.email,
    required this.chords,
    required this.notes,
    required this.tests,
    required this.v,
  });

  String id;
  String email;
  List<Sound> chords;
  List<Sound> notes;
  List<Test> tests;
  int v;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["_id"],
    email: json["email"],
    chords: List<Sound>.from(json["chords"].map((x) => Sound.fromJson(x))),
    notes: List<Sound>.from(json["notes"].map((x) => Sound.fromJson(x))),
    tests: List<Test>.from(json["tests"].map((x) => Test.fromJson(x))),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "chords": List<dynamic>.from(chords.map((x) => x.toJson())),
    "notes": List<dynamic>.from(notes.map((x) => x.toJson())),
    "tests": List<dynamic>.from(tests.map((x) => x.toJson())),
    "__v": v,
  };
}

class Sound {
  Sound({
    required this.name,
    required this.passed,
    required this.score,
  });

  String name;
  bool passed;
  double score;

  factory Sound.fromJson(Map<String, dynamic> json) => Sound(
    name: json["name"],
    passed: json["passed"],
    score: json["score"] is int ? (json["score"] as int).toDouble() : json["score"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "passed": passed,
    "score": score,
  };
}

class Test {
  Test({
    required this.level,
    required this.score,
  });

  String level;
  double score;

  factory Test.fromJson(Map<String, dynamic> json) => Test(
    level: json["level"],
    score: json["score"] is int ? (json["score"] as int).toDouble() : json["score"],
  );

  Map<String, dynamic> toJson() => {
    "level": level,
    "score": score,
  };
}