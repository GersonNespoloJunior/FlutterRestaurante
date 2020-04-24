import 'package:Academia/models/Mesas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'daoPai.dart';

class DaoMesas extends DaoPai {
  static add(Mesas umaMesa) {
    Firestore.instance.collection('mesas').document().setData({
      'status': umaMesa.status,
      'maxPessoas': umaMesa.maxPessoas,
    });
  }

  static update(Mesas umaMesa) {
    Firestore.instance.collection('mesas').document(umaMesa.id).updateData({
      'status': umaMesa.status,
      'maxPessoas': umaMesa.maxPessoas,
    });
  }

  static delete(Mesas umaMesa) {
    Firestore.instance.collection('mesas').document(umaMesa.id).delete();
  }

  static Stream<QuerySnapshot> buscarTodosReg() {
    return Firestore.instance.collection('mesas').snapshots();
  }
}
