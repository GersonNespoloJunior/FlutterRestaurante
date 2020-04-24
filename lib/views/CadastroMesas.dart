import 'package:Academia/controllers/ControllerPai.dart';
import 'package:Academia/services/locator.dart';
import 'package:Academia/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:Academia/models/Mesas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Academia/daos/daoMesas.dart';
import 'package:flutter/services.dart';

class CadastroMesas extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final DocumentSnapshot args;
  var umaMesa = Mesas(status: '', maxPessoas: 0);

  CadastroMesas(this.args) {
    if (args != null) {
      umaMesa.id = args.documentID;
      umaMesa.status = args["status"];
      umaMesa.maxPessoas = args["maxPessoas"];
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
                          'Cadastro Mesas',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Divider(thickness: 1),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Status'),
                                initialValue: umaMesa.status,
                                style: Theme.of(context).textTheme.bodyText1,
                                onSaved: (value) =>
                                    umaMesa.status = value,
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
                                decoration: InputDecoration(
                                    labelText: 'Quantidade Pessoas Máx.'),
                                initialValue: umaMesa.maxPessoas.toString(),
                                style: Theme.of(context).textTheme.bodyText1,
                                onSaved: (value) =>
                                    umaMesa.maxPessoas = num.parse(value),
                                validator: (value) {
                                  if (!ControllerPai.validarCampo(value)) {
                                    return 'Campo Obrigatório';
                                  }
                                  return null;
                                },
                              ),
                              width: 250,
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
                                if (umaMesa.id == null) {
                                  DaoMesas.add(umaMesa);
                                } else {
                                  DaoMesas.update(umaMesa);
                                }
                                locator<NavigationService>().goBack();
                              }
                            },
                            child: Text('Salvar',
                                style: Theme.of(context).textTheme.bodyText2)),
                        SizedBox(width: 30),
                        FlatButton(
                          onPressed: () {
                            if (umaMesa.id == null) {
                              return null;
                            } else {
                              DaoMesas.delete(umaMesa);
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
