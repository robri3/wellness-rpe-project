import 'package:flutter/material.dart';

class _WidgetUtils {
  List<dynamic> opciones = [];

  _WidgetUtils() {
    //cargarData();
  }

  void mostrarAlerta(BuildContext context, String titulo, String msg) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(
            titulo,
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(msg),
              // FlutterLogo(
              //   size: 100.0,
              // ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
      barrierDismissible: true,
    );
  }
}

final widgetUtils = new _WidgetUtils();
