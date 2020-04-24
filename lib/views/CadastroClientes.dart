import 'package:Academia/controllers/ControllerPai.dart';
import 'package:Academia/services/locator.dart';
import 'package:Academia/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:Academia/models/Clientes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Academia/daos/daoClientes.dart';

class CadastroClientes extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final DocumentSnapshot args;
  var umCliente = Clientes();

  CadastroClientes(this.args) {
    if (args != null) {
      umCliente.id = args.documentID;
      umCliente.nome = args["nome"];
      umCliente.email = args["email"];
      umCliente.fone = args["fone"];
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
                          'Cadastro Clientes',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Divider(thickness: 1),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Nome Completo'),
                                initialValue: umCliente.nome,
                                style: Theme.of(context).textTheme.bodyText1,
                                onSaved: (value) => umCliente.nome = value,
                                validator: (value) {
                                  if (!ControllerPai.validarCampo(value)) {
                                    return 'Insira seu Nome Completo';
                                  }
                                  return null;
                                },
                              ),
                              width: 400,
                            ),
                            SizedBox(
                              child: TextFormField(
                                decoration: InputDecoration(labelText: 'Email'),
                                initialValue: umCliente.email,
                                style: Theme.of(context).textTheme.bodyText1,
                                onSaved: (value) => umCliente.email = value,
                                validator: (value) {
                                  if (!ControllerPai.validarCampo(value)) {
                                    return 'Insira seu Email';
                                  }
                                  return null;
                                },
                              ),
                              width: 250,
                            ),
                            SizedBox(
                              child: TextFormField(
                                decoration: InputDecoration(labelText: 'Fone'),
                                initialValue: umCliente.fone,
                                style: Theme.of(context).textTheme.bodyText1,
                                onSaved: (value) => umCliente.fone = value,
                                validator: (value) {
                                  if (!ControllerPai.validarCampo(value)) {
                                    return 'Insira seu Telefone';
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
                                if (umCliente.id == null) {
                                  DaoClientes.add(umCliente);
                                } else {
                                  DaoClientes.update(umCliente);
                                }
                                locator<NavigationService>().goBack();
                              }
                            },
                            child: Text('Salvar',
                                style: Theme.of(context).textTheme.bodyText2)),
                        SizedBox(width: 30),
                        FlatButton(
                          onPressed: () {
                            if (umCliente.id == null) {
                              return null;
                            } else {
                              DaoClientes.delete(umCliente);
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
