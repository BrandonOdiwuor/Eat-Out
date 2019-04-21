import 'user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  User user = User();

  void fetch(String userId) async {
    Stream<QuerySnapshot> stream = Firestore.instance.collection('users')
        .where('id', isEqualTo: userId).snapshots();
    await for(QuerySnapshot querySnapshot in stream) {
      querySnapshot.documents.forEach((snapshot) {
        user = User.fromSnapshot(snapshot: snapshot);
      });
    }
  }

  void upload(String id, String name) async {
    user = User(id: id, name: name);
    Firestore.instance.collection('users').document().setData({
      'id': id,
      'name': name,
    });
  }
}