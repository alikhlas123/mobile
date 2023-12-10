import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServiceStudio {
  final CollectionReference studio =
      FirebaseFirestore.instance.collection('studio');
  Stream<QuerySnapshot> getStud() {
    final userStud = studio.snapshots();
    return userStud;
  }
}

class FireStoreServiceSound {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('sound');
  Stream<QuerySnapshot> getUsers() {
    final userStream = users.snapshots();
    return userStream;
  }
}

class FireStoreServiceMusik {
  final CollectionReference musik =
      FirebaseFirestore.instance.collection('musik');
  Stream<QuerySnapshot> getMusik() {
    final musikstream = musik.snapshots();
    return musikstream;
  }
}

class FireStoreServiceLighting {
  final CollectionReference lighting =
      FirebaseFirestore.instance.collection('lighting');
  Stream<QuerySnapshot> getLighting() {
    final lightingstream = lighting.snapshots();
    return lightingstream;
  }
}

class FireStoreServiceProfile {
  final CollectionReference profile =
      FirebaseFirestore.instance.collection('register');
  Stream<QuerySnapshot> getProfile() {
    final profiletream = profile.snapshots();
    return profiletream;
  }
}
