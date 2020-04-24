import 'package:Academia/daos/daoPai.dart';
import 'package:Academia/models/Clientes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DaoClientes extends DaoPai {
  static add(Clientes umCliente) {
    Firestore.instance.collection('clientes').document().setData({
      'email': umCliente.email,
      'fone': umCliente.fone,
      'nome': umCliente.nome
    });
  }

  static update(Clientes umCliente) {
    Firestore.instance
        .collection('clientes')
        .document(umCliente.id)
        .updateData({
      'email': umCliente.email,
      'fone': umCliente.fone,
      'nome': umCliente.nome
    });
  }

  static delete(Clientes umCliente) {
    Firestore.instance.collection('clientes').document(umCliente.id).delete();
  }

  static Stream<QuerySnapshot> buscarTodosReg() {
    return Firestore.instance.collection('clientes').snapshots();
  }
}
