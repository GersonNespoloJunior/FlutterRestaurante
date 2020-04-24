import 'package:Academia/models/Reservas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'daoPai.dart';

class DaoReservas extends DaoPai {
  static add(Reservas umaReserva) {
    Firestore.instance.collection('reservas').document().setData({
      'data': umaReserva.data,
      'idCliente': umaReserva.idCliente,
      'idMesa': umaReserva.idMesa,
      'qtdePessoas': umaReserva.qtdePessoas,
    });
  }

  static update(Reservas umaReserva) {
    Firestore.instance
        .collection('reservas')
        .document(umaReserva.id)
        .updateData({
      'data': umaReserva.data,
      'idCliente': umaReserva.idCliente,
      'idMesa': umaReserva.idMesa,
      'qtdePessoas': umaReserva.qtdePessoas,
    });
  }

  static delete(Reservas umaReserva) {
    Firestore.instance.collection('reservas').document(umaReserva.id).delete();
  }

  static Stream<QuerySnapshot> buscarTodosReg() {
    return Firestore.instance.collection('reservas').snapshots();
  }
}
