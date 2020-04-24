import 'Pai.dart';

class Reservas extends Pai {
  DateTime data;
  String idCliente;
  String idMesa;
  int qtdePessoas;

  Reservas({
    this.data,
    this.idCliente,
    this.idMesa,
    this.qtdePessoas
  });
}
