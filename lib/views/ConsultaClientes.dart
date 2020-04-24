import 'package:Academia/daos/daoClientes.dart';
import 'package:Academia/routing/route_names.dart';
import 'package:Academia/services/locator.dart';
import 'package:Academia/services/navigation_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConsultaClientes extends StatefulWidget {
  // args = Provider.of<Map<dynamic, dynamic>>(context);
  ConsultaClientes({Key key}) : super(key: key);

  @override
  _ConsultaClientesState createState() => _ConsultaClientesState();
}

class _ConsultaClientesState extends State<ConsultaClientes> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(overflow: Overflow.visible, children: [
        ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: ListaClientes(),
        ),
        Positioned(
          child: FlatButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                // locator<NavigationService>()
                    // .navigateTo(Provider.of<Map<dynamic, dynamic>>(context), null);
              },
              child: Text(
                'Adicionar',
                style: Theme.of(context).textTheme.bodyText2,
              )),
          right: 5,
          bottom: 0,
        ),
      ]),
    );
  }
}

class ListaClientes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: DaoClientes.buscarTodosReg(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new DataTable(
          sortAscending: true,
          columns: <DataColumn>[
            DataColumn(label: Text('Nome')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Fone')),
          ],
          rows: linhasClientes(snapshot.data),
        );
      },
    );
  }
}

List<DataRow> linhasClientes(QuerySnapshot snapshot) {
  List<DataRow> newList =
      snapshot.documents.map((DocumentSnapshot documentSnapshot) {
    return new DataRow(
      cells: <DataCell>[
        DataCell(Text(documentSnapshot["nome"])),
        DataCell(Text(documentSnapshot["email"])),
        DataCell(Text(documentSnapshot["fone"]), showEditIcon: true, onTap: () {
          locator<NavigationService>()
              .navigateTo(rou_CadastroClientes, documentSnapshot);
        }),
      ],
    );
  }).toList();
  return newList;
}
