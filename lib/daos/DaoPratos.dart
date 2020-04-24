import 'package:Academia/models/Pratos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'daoPai.dart';

class DaoPratos extends DaoPai {
  static add(Pratos umPrato) {
    Firestore.instance.collection('pratos').document().setData({
      'prato': umPrato.prato,
      'preco': umPrato.preco,
    });
  }

  static update(Pratos umPrato) {
    Firestore.instance
        .collection('pratos')
        .document(umPrato.id)
        .updateData({
      'prato': umPrato.prato,
      'preco': umPrato.preco,
    });
  }

  static delete(Pratos umPrato) {
    Firestore.instance.collection('pratos').document(umPrato.id).delete();
  }

  static Stream<QuerySnapshot> buscarTodosReg() {
    return Firestore.instance.collection('pratos').snapshots();
  }
}
