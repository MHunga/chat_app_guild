import 'dart:io';

import 'package:chat_app/repositories/models/app_user.dart';
import 'package:chat_app/repositories/models/message.dart';
import 'package:chat_app/repositories/models/room_chat.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FirebaseMethod {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

  Stream<User?> userChangeStream() async* {
    yield* _auth.userChanges();
  }

  Future createAccountWithEmailAndPassword(
      {required String email,
      required String password,
      required String name,
      Function(AppUser)? onDone}) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (value.user != null) {
          final appUser = AppUser(
              uid: value.user!.uid,
              displayName: name,
              email: value.user!.email,
              photoUrl: value.user!.photoURL);
          await createUserToDatabase(appUser).then((value) => onDone!(appUser));
        }
      });
      Utils.showToast("Đăng nhập thành công");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Utils.showToast("Mật khẩu quá yếu");
      } else if (e.code == 'email-already-in-use') {
        Utils.showToast("Tài khoản đã tồn tại");
      } else {
        Utils.showToast("Có lỗi xảy ra, Vui lòng thử lại sau!");
      }
    }
  }

  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Utils.showToast("Đăng nhập thành công");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Utils.showToast("Không tìm thấy người dùng nào cho email này.");
      } else if (e.code == 'wrong-password') {
        Utils.showToast("Sai mật khẩu!");
      } else {
        Utils.showToast("Có lỗi xảy ra, Vui lòng thử lại sau!");
      }
    }
  }

  Future signOut() async {
    return _auth.signOut();
  }

  Future createUserToDatabase(AppUser appUser) async {
    await _firestore.collection("users").doc(appUser.uid).set(appUser.toJson());
  }

  Future<AppUser?> getUser(String uid) async {
    final snapshot = await _firestore.collection("users").doc(uid).get();
    if (snapshot.exists) {
      return AppUser.fromJson(snapshot.data()!);
    }
  }

  Future sendMessage(
      {required RoomChat roomChat, required Message message}) async {
    await _firestore
        .collection("chats")
        .doc(roomChat.id)
        .collection("messages")
        .doc(message.id)
        .set(message.toJson());
    await _firestore
        .collection("chats")
        .doc(roomChat.id)
        .set(roomChat.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamRoomChat(
      String userId) async* {
    yield* _firestore
        .collection("chats")
        .where("members_id", arrayContains: userId)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamMessage(
      String idRoomChat) async* {
    yield* _firestore
        .collection("chats")
        .doc(idRoomChat)
        .collection("messages")
        .orderBy("time_stamp", descending: true)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getStreamUser(
      String uid) async* {
    yield* _firestore.collection("users").doc(uid).snapshots();
  }

  Future<List<AppUser>> searchUser(String uid) async {
    List<AppUser> listUser = [];
    final snapshot = await _firestore.collection("users").get();
    for (var doc in snapshot.docs) {
      if (doc.id != uid) {
        print(doc.data());
        listUser.add(AppUser.fromJson(doc.data()));
      }
    }
    return listUser;
  }

  Future<String?> getIdRoomChat(String senderId, String recieverId) async {
    final snapshot = await _firestore.collection("chats").get();
    for (var doc in snapshot.docs) {
      List<dynamic> membersId = doc.get("members_id");
      if (membersId.any((element) => element == senderId) &&
          membersId.any((element) => element == recieverId)) {
        return doc.get("id");
      }
    }
  }

  Future updateUser(
      {required String userId,
      required String displayName,
      File? avatar}) async {
    if (avatar != null) {
      String? photoUrl = await uploadFile(userId, avatar);
      await _firestore
          .collection("users")
          .doc(userId)
          .update({"display_name": displayName, "photo_url": photoUrl});
    } else {
      await _firestore
          .collection("users")
          .doc(userId)
          .update({"display_name": displayName});
    }
  }

  Future<String?> uploadFile(String userId, File file) async {
    String fileName = Uuid().v4();
    try {
      final uploaTask =
          await _storage.ref('users/$userId/$fileName.jpg').putFile(file);
      return uploaTask.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      Utils.showToast(e.message ?? "");
    }
  }
}
