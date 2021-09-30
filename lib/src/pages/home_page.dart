import 'package:flutter/material.dart';
import 'package:wellnes_rpe/src/utils/json_file_handler.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              'Elija una opcion',
            ),
          ),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300.0,
              height: 70.0,
              child: FloatingActionButton.extended(
                heroTag: null,
                onPressed: () {
                  Navigator.pushNamed(context, 'inputData');
                },
                icon: Icon(Icons.new_label),
                backgroundColor: Colors.pink,
                label: Text('Ingresar datos de jugador'),
              ),
            ),
            Divider(
              height: 100.0,
            ),
            SizedBox(
              width: 300.0,
              height: 70.0,
              child: FloatingActionButton.extended(
                heroTag: null,
                onPressed: () {
                  Navigator.pushNamed(context, 'viewData');
                },
                icon: Icon(Icons.list_alt),
                backgroundColor: Colors.pink,
                label: Text('Ver datos de jugadores'),
              ),
            ),
            Divider(
              height: 100.0,
            ),
            SizedBox(
              width: 300.0,
              height: 70.0,
              child: FloatingActionButton.extended(
                heroTag: null,
                onPressed: () {
                  jsonFileHandler.deleteFile();
                },
                icon: Icon(Icons.delete),
                backgroundColor: Colors.pink,
                label: Text('Eliminar Datos'),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
