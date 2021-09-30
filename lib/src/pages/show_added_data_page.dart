import 'package:flutter/material.dart';

class InputShow extends StatelessWidget {
  String nom = '';
  String date = '';
  int dolor = 0;
  int fatiga = 0;
  int intensidad = 0;
  InputShow.conValores(
      {required this.nom,
      required this.date,
      required this.dolor,
      required this.fatiga,
      required this.intensidad});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Informacion del jugador')),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Container(
            height: 550.0,
            child: _lista(),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: SizedBox(
            height: 80.0,
            width: 200.0,
            child: FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              icon: Icon(Icons.reply_outlined),
              backgroundColor: Colors.pink,
              label: Text('Menu principal'),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget _lista() {
    return ListView(
      children: [
        ListTile(
          title: Text('Nombre del jugador:'),
          subtitle: Text(nom),
          leading: Icon(Icons.person),
        ),
        Divider(),
        ListTile(
          title: Text('Fecha del entrenamiento: '),
          subtitle: Text(date),
          leading: Icon(Icons.date_range_outlined),
        ),
        Divider(),
        ListTile(
          title: Text('Dolor muscular (1 al 10)'),
          subtitle: Text(dolor.toString()),
          leading: Icon(Icons.person),
        ),
        Divider(),
        ListTile(
          title: Text('Fatiga que sintió (1 al 10)'),
          subtitle: Text(fatiga.toString()),
          leading: Icon(Icons.person),
        ),
        Divider(),
        ListTile(
          title: Text('Intensidad de la sesión (1 al 10)'),
          subtitle: Text(intensidad.toString()),
          leading: Icon(Icons.person),
        ),
      ],
    );
  }
}
