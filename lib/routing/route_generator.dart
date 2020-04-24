import 'package:Academia/daos/DaoCaixas.dart';
import 'package:Academia/daos/DaoClientes.dart';
import 'package:Academia/daos/DaoMesas.dart';
import 'package:Academia/daos/DaoPedidos.dart';
import 'package:Academia/daos/DaoPratos.dart';
import 'package:Academia/daos/DaoReservas.dart';
import 'package:Academia/routing/route_names.dart';
import 'package:Academia/views/CadastroCaixas.dart';
import 'package:Academia/views/CadastroClientes.dart';
import 'package:Academia/views/CadastroMesas.dart';
import 'package:Academia/views/CadastroPedidos.dart';
import 'package:Academia/views/CadastroPratos.dart';
import 'package:Academia/views/CadastroReservas.dart';
import 'package:Academia/views/ConsultaPai.dart';
import 'package:Academia/views/homePage.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case rou_homePage:
        return MaterialPageRoute(builder: (context) => HomePage());

      case rou_ConsultaClientes:
        return MaterialPageRoute(
          builder: (context) => ConsultaPai(
            rou_CadastroClientes,
            DaoClientes.buscarTodosReg(),
            ['nome', 'email', 'fone'],
          ),
        );
      case rou_ConsultaPratos:
        return MaterialPageRoute(
          builder: (context) => ConsultaPai(
            rou_CadastroPratos,
            DaoPratos.buscarTodosReg(),
            ['prato', 'preco'],
          ),
        );
      case rou_ConsultaMesas:
        return MaterialPageRoute(
          builder: (context) => ConsultaPai(
            rou_CadastroMesas,
            DaoMesas.buscarTodosReg(),
            ['status', 'maxPessoas'],
          ),
        );
        case rou_ConsultaPedidos:
        return MaterialPageRoute(
          builder: (context) => ConsultaPai(
            rou_CadastroPedidos,
            DaoPedidos.buscarTodosReg(),
            ['idFatura', 'status'],
          ),
        );
        case rou_ConsultaReservas:
        return MaterialPageRoute(
          builder: (context) => ConsultaPai(
            rou_CadastroReservas,
            DaoReservas.buscarTodosReg(),
            ['data', 'idCliente','idMesa','qtdePessoas'],
          ),
        );
        case rou_ConsultaCaixas:
        return MaterialPageRoute(
          builder: (context) => ConsultaPai(
            rou_CadastroCaixas,
            DaoCaixas.buscarTodosReg(),
            ['dtAbert', 'dtFecha', 'idAtend', 'valorEntrada'],
          ),
        );

      case rou_CadastroClientes:
        return MaterialPageRoute(
            builder: (context) => CadastroClientes(args));
      case rou_CadastroPratos:
        return MaterialPageRoute(
            builder: (context) => CadastroPratos(args));
      case rou_CadastroReservas:
        return MaterialPageRoute(
            builder: (context) => CadastroReservas(args));
      case rou_CadastroPedidos:
        return MaterialPageRoute(
            builder: (context) => CadastroPedidos(args));
      case rou_CadastroMesas:
        return MaterialPageRoute(
            builder: (context) => CadastroMesas(args));
      case rou_CadastroCaixas:
        return MaterialPageRoute(
            builder: (context) => CadastroCaixas(args));

      default:
        return _errorRoute();
    }
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Container(
      child: Center(
        child: Text('Caminho não encontrado', style: TextStyle(color: Colors.black)),
      ),
    );
  });
}
