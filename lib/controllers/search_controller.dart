import 'package:chat_app/repositories/firebase/firebase_method.dart';
import 'package:chat_app/repositories/models/app_user.dart';
import 'package:flutter/material.dart';

class SearchController extends ChangeNotifier {
  List<AppUser> _listAllUser = [];
  List<AppUser> _listSearchUser = [];
  List<AppUser> get listSearchUser => _listSearchUser;
  List<AppUser> get listAllUser => _listAllUser;

  FirebaseMethod _firebaseMethod = FirebaseMethod();

  SearchController(String uid) {
    _init(uid);
  }

  _init(String uid) async {
    _listAllUser = await _firebaseMethod.searchUser(uid);
    notifyListeners();
  }

  searchUser(String text) {
    List<AppUser> list = [];
    if (text.isNotEmpty) {
      _listAllUser.forEach((element) {
        final displayName = element.displayName!.toLowerCase();
        final email = element.email!.toLowerCase();
        final query = text.toLowerCase();
        if (displayName.contains(query) || email.contains(query)) {
          list.add(element);
        }
      });
      _listSearchUser = list;
    } else {
      _listSearchUser = [];
    }
    notifyListeners();
  }

  clearSearch() {
    _listSearchUser = [];
    notifyListeners();
  }
}
