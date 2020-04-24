import 'package:Academia/controllers/ControllerPai.dart';
import 'package:Academia/services/locator.dart';
import 'package:Academia/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:Academia/models/Caixas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Academia/daos/daoCaixas.dart';
import 'package:flutter/services.dart';

class CadastroCaixas extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final DocumentSnapshot args;
  var umCaixa = Caixas(dtAbert: DateTime.now(), dtFecha: DateTime.now(), idAtend: '', valorEntrada: 0);

  CadastroCaixas(this.args) {
    if (args != null) {
      umCaixa.id = args.documentID;
      umCaixa.dtAbert = (args["dtAbert"] as Timestamp).toDate();
      umCaixa.dtFecha = (args["dtFecha"] as Timestamp).toDate();
      umCaixa.idAtend = args["idAtend"];
      umCaixa.valorEntrada = args["valorEntrada"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: SizedBox(
          width: 500,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Cadastro Caixas',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Divider(thickness: 1),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'id Atendente'),
                                initialValue: umCaixa.idAtend,
                                style: Theme.of(context).textTheme.bodyText1,
                                onSaved: (value) =>
                                    umCaixa.idAtend = value,
                                validator: (value) {
                                  if (!ControllerPai.validarCampo(value)) {
                                    return 'Campo Obrigatório';
                                  }
                                  return null;
                                },
                              ),
                              width: 400,
                            ),
                            SizedBox(
                              child: TextFormField(
                                decoration: InputDecoration(labelText: 'Data Abertura'),                                
                                initialValue: umCaixa.dtAbert.toString(),
                                style: Theme.of(context).textTheme.bodyText1,
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: umCaixa.dtAbert,
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2021),
                                  ).then((value) => umCaixa.dtAbert = value);
                                },
                                onSaved: (value) => umCaixa.dtAbert = DateTime.parse(value),
                                validator: (value) {
                                  if (!ControllerPai.validarCampo(value)) {
                                    return 'Campo Obrigatório';
                                  }
                                  return null;
                                },
                              ),
                              width: 400,
                            ),
                            SizedBox(
                              child: TextFormField(
                                decoration: InputDecoration(labelText: 'Data Fechamento'),                                
                                initialValue: umCaixa.dtFecha.toString(),
                                style: Theme.of(context).textTheme.bodyText1,
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: umCaixa.dtFecha,
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2021),
                                  ).then((value) => umCaixa.dtFecha = value);
                                },
                                onSaved: (value) => umCaixa.dtFecha = DateTime.parse(value),
                                validator: (value) {
                                  if (!ControllerPai.validarCampo(value)) {
                                    return 'Campo Obrigatório';
                                  }
                                  return null;
                                },
                              ),
                              width: 400,
                            ),
                            SizedBox(
                              child: TextFormField(
                                inputFormatters: <TextInputFormatter>[
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(labelText: 'Valor Entrada'),
                                initialValue: umCaixa.valorEntrada.toString(),
                                style: Theme.of(context).textTheme.bodyText1,
                                onSaved: (value) =>
                                    umCaixa.valorEntrada = num.parse(value),
                                validator: (value) {
                                  if (!ControllerPai.validarCampo(value)) {
                                    return 'Insira o Preço';
                                  }
                                  return null;
                                },
                              ),
                              width: 150,
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                if (umCaixa.id == null) {
                                  DaoCaixas.add(umCaixa);
                                } else {
                                  DaoCaixas.update(umCaixa);
                                }
                                locator<NavigationService>().goBack();
                              }
                            },
                            child: Text('Salvar',
                                style: Theme.of(context).textTheme.bodyText2)),
                        SizedBox(width: 30),
                        FlatButton(
                          onPressed: () {
                            if (umCaixa.id == null) {
                              return null;
                            } else {
                              DaoCaixas.delete(umCaixa);
                            }
                            locator<NavigationService>().goBack();
                          },
                          child: Text('Excluir',
                              style: Theme.of(context).textTheme.bodyText2),
                          color: Colors.redAccent,
                        ),
                        SizedBox(width: 30),
                        FlatButton(
                          onPressed: () {
                            locator<NavigationService>().goBack();
                          },
                          child: Text('Sair',
                              style: Theme.of(context).textTheme.bodyText1),
                          color: Colors.cyanAccent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
