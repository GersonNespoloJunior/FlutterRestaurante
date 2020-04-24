import 'package:Academia/controllers/ControllerPai.dart';
import 'package:Academia/services/locator.dart';
import 'package:Academia/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:Academia/models/Pedidos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Academia/daos/daoPedidos.dart';

class CadastroPedidos extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final DocumentSnapshot args;
  var umPedido = Pedidos(idFatura: '', status: '');

  CadastroPedidos(this.args) {
    if (args != null) {
      umPedido.id = args.documentID;
      umPedido.idFatura = args["idFatura"];
      umPedido.status = args["status"];
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
                          'Cadastro Pedidos',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Divider(thickness: 1),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'id Fatura'),
                                initialValue: umPedido.idFatura,
                                style: Theme.of(context).textTheme.bodyText1,
                                onSaved: (value) => umPedido.idFatura = value,
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
                                decoration:
                                    InputDecoration(labelText: 'Status'),
                                initialValue: umPedido.status,
                                style: Theme.of(context).textTheme.bodyText1,
                                onSaved: (value) => umPedido.status = value,
                                validator: (value) {
                                  if (!ControllerPai.validarCampo(value)) {
                                    return 'Campo Obrigatório';
                                  }
                                  return null;
                                },
                              ),
                              width: 250,
                            ),
                            SizedBox(
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Pratos'),
                                // initialValue: umPedido.idFatura,
                                style: Theme.of(context).textTheme.bodyText1,
                                // onSaved: (value) => umPedido.idFatura = value,
                                // validator: (value) {
                                //   if (!ControllerPai.validarCampo(value)) {
                                //     return 'Campo Obrigatório';
                                //   }
                                //   return null;
                                // },
                              ),
                              width: 400,
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
                                if (umPedido.id == null) {
                                  DaoPedidos.add(umPedido);
                                } else {
                                  DaoPedidos.update(umPedido);
                                }
                                locator<NavigationService>().goBack();
                              }
                            },
                            child: Text('Salvar',
                                style: Theme.of(context).textTheme.bodyText2)),
                        SizedBox(width: 30),
                        FlatButton(
                          onPressed: () {
                            if (umPedido.id == null) {
                              return null;
                            } else {
                              DaoPedidos.delete(umPedido);
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
