import 'package:Academia/services/locator.dart';
import 'package:Academia/services/navigation_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConsultaPai extends StatelessWidget {
  final String _rouCadastro;
  final Stream<QuerySnapshot> _stream;
  final List<String> _colDataTable;

  ConsultaPai(this._rouCadastro, this._stream, this._colDataTable);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(overflow: Overflow.visible, children: [
        ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: listaPai(),
        ),
        Positioned(
          child: FlatButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                locator<NavigationService>().navigateTo(_rouCadastro, null);
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

  Widget listaPai() {
    return new StreamBuilder(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new DataTable(
          showCheckboxColumn: false,
          columns: _colDataTable
              .map((column) => DataColumn(label: Text(column)))
              .toList(),
          rows: linhasPai(snapshot),
        );
      },
    );
  }

  List<DataRow> linhasPai(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<DataRow> newList =
        snapshot.data.documents.map((DocumentSnapshot documentSnapshot) {
      return new DataRow(
        cells: _colDataTable.map((cell) {
          switch (documentSnapshot.data[cell].runtimeType) {
            case Timestamp:
              return DataCell(Text((documentSnapshot.data[cell] as Timestamp)
                  .toDate()
                  .toString()));
            // case int:
            // return DataCell(Text(documentSnapshot.data[cell]));
            // debugPrint(documentSnapshot.data[cell].runtimeType.toString()

            default:
              return DataCell(Text(documentSnapshot.data[cell].toString()));
          }
        }).toList(),
        onSelectChanged: (bool value) {
          locator<NavigationService>()
              .navigateTo(_rouCadastro, documentSnapshot);
        },
      );
    }).toList();
    return newList;
  }
}
