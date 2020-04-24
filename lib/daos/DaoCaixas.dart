import 'package:Academia/models/Caixas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'daoPai.dart';

class DaoCaixas extends DaoPai {
  static add(Caixas umCaixa) {
    Firestore.instance.collection('caixas').document().setData({
      'dtAbert': umCaixa.dtAbert,
      'dtFecha': umCaixa.dtFecha,
      'idAtend': umCaixa.idAtend,
      'valorEntrada': umCaixa.valorEntrada,
    });
  }

  static update(Caixas umCaixa) {
    Firestore.instance
        .collection('caixas')
        .document(umCaixa.id)
        .updateData({
      'dtAbert': umCaixa.dtAbert,
      'dtFecha': umCaixa.dtFecha,
      'idAtend': umCaixa.idAtend,
      'valorEntrada': umCaixa.valorEntrada,
    });
  }

  static delete(Caixas umCaixa) {
    Firestore.instance.collection('caixas').document(umCaixa.id).delete();
  }

  static Stream<QuerySnapshot> buscarTodosReg() {
    return Firestore.instance.collection('caixas').snapshots();
  }
}
