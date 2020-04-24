import 'Pai.dart';

abstract class Pessoas extends Pai {
  String nome;
  String email;
  String fone;

  Pessoas({
    this.nome,
    this.email,
    this.fone,
  });
}
