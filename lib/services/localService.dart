import 'package:cloud_firestore/cloud_firestore.dart';

class LocalService {
  getlocal(String uid) {
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    return FirebaseFirestore.instance.collection('locales').get();
  }
}

// .then((QuerySnapshot querySnapshot) => {
//               querySnapshot.docs.forEach((doc) {
//                 print(doc["nombre"]);
//               })
//             });
