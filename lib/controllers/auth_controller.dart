import 'dart:async';
import 'dart:io';

import 'package:chat_app/repositories/firebase/firebase_method.dart';
import 'package:chat_app/repositories/models/app_user.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

enum AuthStatus { none, authenticate, unauthenticate }

class AuthController extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.none;

  FirebaseMethod _firebaseMethod = FirebaseMethod();

  late StreamSubscription _authStreamSubscription;
  bool isLoading = false;
  AppUser? appUser;

  AuthController() {
    _init();
  }

  void _init() {
    _authStreamSubscription =
        _firebaseMethod.userChangeStream().listen((user) async {
      if (user != null) {
        await _firebaseMethod.getUser(user.uid).then((value) async {
          if (value != null) {
            appUser = value;
            authStatus = AuthStatus.authenticate;
            print("Aaa");
          }
        });
      } else {
        appUser = null;
        authStatus = AuthStatus.unauthenticate;
      }

      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _authStreamSubscription.cancel();
  }

  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    _loading();
    await _firebaseMethod.signInWithEmailAndPassword(
        email: email, password: password);
    _unLoading();
  }

  Future signOut() async {
    _loading();
    await _firebaseMethod.signOut();
    _unLoading();
  }

  Future createAccount(
      {required String name,
      required String email,
      required String password}) async {
    _loading();
    await _firebaseMethod.createAccountWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        onDone: (user) {
          appUser = user;
          authStatus = AuthStatus.authenticate;
          _unLoading();
        });
  }

  Future<bool> updateUser({required String displayName, File? avatar}) async {
    _loading();
    try {
      await _firebaseMethod.updateUser(
          userId: appUser!.uid!,
          displayName:
              displayName.isEmpty ? appUser!.displayName! : displayName,
          avatar: avatar);
      appUser = await _firebaseMethod.getUser(appUser!.uid!);
      Utils.showToast("Cập nhật thành công");
      _unLoading();
      return true;
    } on FirebaseException catch (e) {
      _unLoading();
      Utils.showToast(e.message ?? "");
      return false;
    }
  }

  _loading() {
    isLoading = true;
    notifyListeners();
  }

  _unLoading() {
    isLoading = false;
    notifyListeners();
  }
}
