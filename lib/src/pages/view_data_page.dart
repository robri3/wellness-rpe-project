import 'package:flutter/material.dart';
import 'package:wellnes_rpe/src/classes/PlayerData.dart';
import 'package:wellnes_rpe/src/utils/json_file_handler.dart';

class ViewData extends StatelessWidget {
  // const ViewData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos de los jugadores'),
      ),
      body: _lista(),
    );
  }

  Widget _lista() {
    return FutureBuilder(
      future: jsonFileHandler.readString(),
      initialData: [],
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.data != '') {
          //print(snapshot.data);
          return ListView(
            children: _listaItems(snapshot.data),
          );
        } else {
          return Center(
            child: Text('No hay datos'),
          );
          //return Text('No hay datos');
        }
      },
    );
  }

  List<Widget> _listaItems(data) {
    final List<Widget> opciones = [];
    var tagObjsJson = jsonFileHandler.useJsonDecode(data.toString());

    if (tagObjsJson is List) {
      tagObjsJson.forEach((element) {
        final widgetTemp = Card(
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Column(
            children: [
              ListTile(
                //leading: Icon(Icons.photo, color: Colors.red),
                title: Center(child: Text('Nombre: ' + element['nombre'])),
                subtitle: Column(
                  children: [
                    Text('Fecha del entrenamiento: ' + element['fecha']),
                    Text('Nivel de dolor muscular: ' +
                        element['dolor'].toString()),
                    Text('Nivel de fatiga: ' + element['fatiga'].toString()),
                    Text('Nivel de intensidad: ' +
                        element['intensidad'].toString()),
                  ],
                ),
              ),
            ],
          ),
        );
        opciones
          ..add(widgetTemp)
          ..add(Divider());
      });
    } else {
      final widgetTemp = Card(
        elevation: 5.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          children: [
            ListTile(
              //leading: Icon(Icons.photo, color: Colors.red),
              title: Center(child: Text('Nombre: ' + tagObjsJson['nombre'])),
              subtitle: Column(
                children: [
                  Text('Fecha del entrenamiento: ' + tagObjsJson['fecha']),
                  Text('Nivel de dolor muscular: ' +
                      tagObjsJson['dolor'].toString()),
                  Text('Nivel de fatiga: ' + tagObjsJson['fatiga'].toString()),
                  Text('Nivel de intensidad: ' +
                      tagObjsJson['intensidad'].toString()),
                ],
              ),
            ),
          ],
        ),
      );
      opciones
        ..add(widgetTemp)
        ..add(Divider());

      //print(jsonFileHandler.useJsonEncode(tagObjsJson).toString());
    }
    return opciones;
  }
}
