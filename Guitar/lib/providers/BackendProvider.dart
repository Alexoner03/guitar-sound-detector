import 'package:flutter/foundation.dart';
import 'package:guitar/models/BackendModels.dart';

import '../services/BackendService.dart';

class BackendProvider with ChangeNotifier {
  UserInfo? userInfo;

  Future<UserInfo?> getByEmail(String email) async {
    userInfo = await BackendService.getUserByEmail(email);
    notifyListeners();
    return userInfo;
  }

  Future<UserInfo?> createUser(String email) async {
    userInfo = await BackendService.createUser(email);
    notifyListeners();
    return userInfo;
  }

  Future<UserInfo?> updateChords(List<Sound> chords) async {
    userInfo = await BackendService.updateChords(userInfo!.email,chords);
    notifyListeners();
    return userInfo;
  }

  Future<UserInfo?> updateNotes(List<Sound> notes) async {
    userInfo = await BackendService.updateNotes(userInfo!.email,notes);
    notifyListeners();
    return userInfo;
  }

  Future<UserInfo?> updateTests(List<Test> tests) async {
    userInfo = await BackendService.updateTests(userInfo!.email,tests);
    notifyListeners();
    return userInfo;
  }

  clear(){
    userInfo = null;
    notifyListeners();
  }

}