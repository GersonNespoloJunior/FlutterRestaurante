import 'package:Academia/controllers/ControllerPai.dart';
import 'package:Academia/services/locator.dart';
import 'package:Academia/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:Academia/models/Reservas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Academia/daos/daoReservas.dart';
import 'package:flutter/services.dart';

class CadastroReservas extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final DocumentSnapshot args;
  var umaReserva = Reservas();

  CadastroReservas(this.args) {
    if (args != null) {
      umaReserva.id = args.documentID;
      umaReserva.data = (args["data"] as Timestamp).toDate();
      umaReserva.idCliente = args["idCliente"];
      umaReserva.idMesa = args["idMesa"];
      umaReserva.qtdePessoas = args["qtdePessoas"];
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
                          'Cadastro Reservas',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Divider(thickness: 1),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'id Cliente'),
                                initialValue: umaReserva.idCliente,
                                style: Theme.of(context).textTheme.bodyText1,
                                onSaved: (value) =>
                                    umaReserva.idCliente = value,
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
                                    InputDecoration(labelText: 'id Mesa'),
                                initialValue: umaReserva.idMesa,
                                style: Theme.of(context).textTheme.bodyText1,
                                onSaved: (value) => umaReserva.idMesa = value,
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
                                decoration: InputDecoration(labelText: 'Data'),                                
                                initialValue: umaReserva.data == null ? DateTime.now().toString() :umaReserva.data.toString(),
                                style: Theme.of(context).textTheme.bodyText1,
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: umaReserva.data == null ? DateTime.now() : umaReserva.data,
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2021),
                                  ).then((value) => umaReserva.data = value);
                                },
                                onSaved: (value) => umaReserva.data = DateTime.parse(value),
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
                                    labelText: 'Quantidade Pessoas'),
                                initialValue: umaReserva.qtdePessoas == null ? '0' : umaReserva.qtdePessoas.toString(),
                                style: Theme.of(context).textTheme.bodyText1,
                                onSaved: (value) =>
                                    umaReserva.qtdePessoas = num.parse(value),
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
                                if (umaReserva.id == null) {
                                  DaoReservas.add(umaReserva);
                                } else {
                                  DaoReservas.update(umaReserva);
                                }
                                locator<NavigationService>().goBack();
                              }
                            },
                            child: Text('Salvar',
                                style: Theme.of(context).textTheme.bodyText2)),
                        SizedBox(width: 30),
                        FlatButton(
                          onPressed: () {
                            if (umaReserva.id == null) {
                              return null;
                            } else {
                              DaoReservas.delete(umaReserva);
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
