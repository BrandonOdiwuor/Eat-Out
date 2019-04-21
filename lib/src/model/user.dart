import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final id;
  final name;
  final DocumentReference reference;

  User({@required this.id, @required this.name, this.reference});

  User.fromMap(Map<String, dynamic> map, {this.reference}) :
      assert(map['id'] != null),
      assert(map['name'] != null),
      id = map['id'],
      name = map['name'];

  User.fromSnapshot({@required DocumentSnapshot snapshot}) :
      this.fromMap(snapshot.data, reference: snapshot.reference);
}