import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guitar/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

class FirestoreService {
  static getUserInfo(context) async {
    final prov = Provider.of<AuthProvider>(context, listen: false);
    final instance = FirebaseFirestore.instance.collection('/usuariosinfo').doc(prov.user!.email);
    print(instance.toString());
  }
}