import 'package:Academia/models/Pedidos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'daoPai.dart';

class DaoPedidos extends DaoPai {
  static add(Pedidos umPedido) {
    Firestore.instance.collection('pedidos').document().setData({
      'idFatura': umPedido.idFatura,
      'status': umPedido.status,
    });
  }

  static update(Pedidos umPedido) {
    Firestore.instance.collection('pedidos').document(umPedido.id).updateData({
      'idFatura': umPedido.idFatura,
      'status': umPedido.status,
    });
  }

  static delete(Pedidos umPedido) {
    Firestore.instance.collection('pedidos').document(umPedido.id).delete();
  }

  static Stream<QuerySnapshot> buscarTodosReg() {
    return Firestore.instance.collection('pedidos').snapshots();
  }
}
