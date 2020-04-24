import 'package:Academia/controllers/ControllerPai.dart';
import 'package:Academia/services/locator.dart';
import 'package:Academia/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:Academia/models/Pratos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Academia/daos/daoPratos.dart';
import 'package:flutter/services.dart';

class CadastroPratos extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final DocumentSnapshot args;
  var umPrato = Pratos(prato: '', preco: 0);

  CadastroPratos(this.args) {
    if (args != null) {
      umPrato.id = args.documentID;
      umPrato.prato = args["prato"];
      umPrato.preco = args["preco"];
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
                          'Cadastro Pratos',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Divider(thickness: 1),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              child: TextFormField(
                                decoration: InputDecoration(labelText: 'Prato'),
                                initialValue: umPrato.prato,
                                style: Theme.of(context).textTheme.bodyText1,
                                onSaved: (value) => umPrato.prato = value,
                                validator: (value) {
                                  if (!ControllerPai.validarCampo(value)) {
                                    return 'Insira o Prato';
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
                                decoration: InputDecoration(labelText: 'Preco'),
                                initialValue: umPrato.preco.toString(),
                                style: Theme.of(context).textTheme.bodyText1,
                                onSaved: (value) =>
                                    umPrato.preco = double.parse(value),
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
                                if (umPrato.id == null) {
                                  DaoPratos.add(umPrato);
                                } else {
                                  DaoPratos.update(umPrato);
                                }
                                locator<NavigationService>().goBack();
                              }
                            },
                            child: Text('Salvar',
                                style: Theme.of(context).textTheme.bodyText2)),
                        SizedBox(width: 30),
                        FlatButton(
                          onPressed: () {
                            if (umPrato.id == null) {
                              return null;
                            } else {
                              DaoPratos.delete(umPrato);
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
