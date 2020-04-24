import 'package:Academia/routing/route_generator.dart';
import 'package:Academia/routing/route_names.dart';
import 'package:Academia/services/locator.dart';
import 'package:Academia/services/navigation_service.dart';
import 'package:flutter/material.dart';

class Gerente extends StatefulWidget {
  Gerente({Key key}) : super(key: key);

  @override
  _GerenteState createState() => _GerenteState();
}

class _GerenteState extends State<Gerente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(children: [
            Icon(Icons.restaurant),
            SizedBox(width: 10),
            Text('Restaurante', style: Theme.of(context).textTheme.headline1),
          ]),
          actions: [
            FlatButton(
                child: Text('Clientes',
                    style: Theme.of(context).textTheme.subtitle1),
                onPressed: () => locator<NavigationService>()
                    .navigateTo(rou_ConsultaClientes, null)),
            FlatButton(
                child: Text('Pratos',
                    style: Theme.of(context).textTheme.subtitle1),
                onPressed: () => locator<NavigationService>()
                    .navigateTo(rou_ConsultaPratos, null)),
            FlatButton(
                child: Text('Reservas',
                    style: Theme.of(context).textTheme.subtitle1),
                onPressed: () => locator<NavigationService>()
                    .navigateTo(rou_ConsultaReservas, null)),
            FlatButton(
                child: Text('Pedidos',
                    style: Theme.of(context).textTheme.subtitle1),
                onPressed: () => locator<NavigationService>()
                    .navigateTo(rou_ConsultaPedidos, null)),
            FlatButton(
                child:
                    Text('Mesas', style: Theme.of(context).textTheme.subtitle1),
                onPressed: () => locator<NavigationService>()
                    .navigateTo(rou_ConsultaMesas, null)),
            FlatButton(
                child:
                    Text('Caixa', style: Theme.of(context).textTheme.subtitle1),
                onPressed: () => locator<NavigationService>()
                    .navigateTo(rou_ConsultaCaixas, null)),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Navigator(
                key: locator<NavigationService>().navigatorKey,
                initialRoute: rou_homePage,
                onGenerateRoute: RouteGenerator.generateRoute,
              ),
            )
          ],
        ),
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       Container(
      //         height: 65,
      //         child: DrawerHeader(
      //             padding: EdgeInsets.only(left: 15, top: 15),
      //             decoration:
      //                 BoxDecoration(color: Theme.of(context).primaryColor),
      //             child: Text('Menu',
      //                 style: Theme.of(context).textTheme.subtitle1)),
      //       ),
      //       ListTile(
      //           onTap: () {
      //             print('Clientes');
      //           },
      //           leading: Icon(
      //             Icons.people,
      //             color: Colors.purple,
      //           ),
      //           title: Text('Clientes',
      //               style: Theme.of(context).textTheme.bodyText1)),
      //       Divider(color: Colors.grey, thickness: 1),
      //       ListTile(
      //           onTap: () {
      //             print('Produtos');
      //           },
      //           leading: Icon(
      //             Icons.archive,
      //             color: Colors.purple,
      //           ),
      //           title: Text('Produtos',
      //               style: Theme.of(context).textTheme.bodyText1)),
      //       Divider(color: Colors.grey, thickness: 1),
      //     ],
      //   ),
      // ),
    );
  }
}
