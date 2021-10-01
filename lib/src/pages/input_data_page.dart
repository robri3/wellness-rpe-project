import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wellnes_rpe/src/classes/PlayerData.dart';
import 'package:wellnes_rpe/src/pages/show_added_data_page.dart';
import 'package:wellnes_rpe/src/utils/Widgets/Widgets.dart';
import 'package:wellnes_rpe/src/utils/json_file_handler.dart';

class InputData extends StatefulWidget {
  @override
  _InputDataState createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  String _nombre = '';
  String _fecha = '';
  List<int> _opciones = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int _optDolor = 5;
  int _optFatiga = 5;
  int _optIntensidad = 5;

  bool check = false;

  int getOpcionDrop(String opt) {
    if (opt == 'dolor') {
      return _optDolor;
    } else if (opt == 'fatiga') {
      return _optFatiga;
    } else {
      return _optIntensidad;
    }
  }

  void setOpcionDrop(String opt, int newValue) {
    if (opt == 'dolor') {
      _optDolor = newValue;
    } else if (opt == 'fatiga') {
      _optFatiga = newValue;
    } else {
      _optIntensidad = newValue;
    }
  }

  TextEditingController _inputNameContoller = new TextEditingController();
  TextEditingController _inputFieldDateContoller = new TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _inputFieldDateContoller.dispose();
    _inputNameContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Ingresar datos'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        children: [
          _createInputName(),
          Divider(),
          _createInputDate(context),
          Divider(),
          _createDropdown('¿Cuanto te duelen los musculos?', 'dolor'),
          Divider(),
          _createDropdown('¿Cuan fatigado estas hoy?', 'fatiga'),
          Divider(),
          _createDropdown('¿Que tan intensa sentiste la sesion?', 'intensidad'),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(70.0),
        child: SizedBox(
          height: 80.0,
          width: 350.0,
          child: FloatingActionButton.extended(
            heroTag: null,
            onPressed: () {
              _persistData(context);
              //jsonFileHandler.deleteFile();
            },
            icon: Icon(Icons.add),
            backgroundColor: Colors.pink,
            label: Text('Confirmar datos'),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _createInputName() {
    return TextField(
      keyboardType: TextInputType.name,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))],
      controller: _inputNameContoller,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        icon: Icon(Icons.text_fields),
        hintText: 'Ingrese el nombre',
        labelText: 'Jugador',
      ),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
      },
    );
  }

  Widget _createInputDate(BuildContext context) {
    return TextField(
      controller: _inputFieldDateContoller,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        icon: Icon(Icons.date_range),
        hintText: 'Seleccione la fecha',
        labelText: 'Fecha',
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2018),
        lastDate: new DateTime.now(),
        locale: Locale('es', 'ES'));
    if (picked != null) {
      setState(() {
        _fecha = picked.day.toString() +
            '-' +
            picked.month.toString() +
            '-' +
            picked.year.toString();
        _inputFieldDateContoller.text = _fecha;
      });
    }
  }

  Widget _createDropdown(String texto, String tipoDrop) {
    return Row(
      children: [
        Icon(Icons.accessibility_new_sharp),
        SizedBox(width: 10.0),
        Text(texto),
        SizedBox(width: 20.0),
        DropdownButton(
          value: getOpcionDrop(tipoDrop),
          items: getOpcionesDropdown(),
          onChanged: (opt) {
            setState(() {
              setOpcionDrop(tipoDrop, int.parse(opt.toString()));
            });
          },
        ),
      ],
    );
  }

  List<DropdownMenuItem<int>> getOpcionesDropdown() {
    List<DropdownMenuItem<int>> _listaTemp = [];

    _opciones.forEach((element) {
      _listaTemp.add(
        DropdownMenuItem(
          child: Text(element.toString()),
          value: element,
        ),
      );
    });
    return _listaTemp;
  }

  Future<void> _persistData(BuildContext context) async {
    if (_inputNameContoller.text != '' && _inputFieldDateContoller.text != '') {
      check = true;
    }

    if (check == false) {
      widgetUtils.mostrarAlerta(context, 'Error', 'Hay campos sin completar');
    } else {
      PlayerData playerData = PlayerData(_inputNameContoller.text,
          _inputFieldDateContoller.text, _optDolor, _optFatiga, _optIntensidad);
      String jsonPlayerInfo = jsonFileHandler.usePlayerJsonEncode(playerData);
      jsonFileHandler.readString().then((value) {
        if (value == '') {
          jsonFileHandler.writeString(jsonPlayerInfo);
        } else {
          var tagObjsJson = jsonFileHandler.useJsonDecode(value);

          if (tagObjsJson is List) {
            List<String> tempS = [];
            tempS.add(jsonPlayerInfo);
            tagObjsJson.forEach((element) {
              tempS.add(jsonFileHandler.useJsonEncode(element));
            });

            jsonFileHandler.writeString(tempS.toString());
          } else {
            List<dynamic> listaTemp = [];
            listaTemp.add(jsonPlayerInfo);
            listaTemp.add(value);
            String insertar = listaTemp.toString();
            jsonFileHandler.writeString(insertar);
          }
        }
      });

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => InputShow.conValores(
            nom: _inputNameContoller.text,
            date: _inputFieldDateContoller.text,
            dolor: _optDolor,
            fatiga: _optFatiga,
            intensidad: _optIntensidad),
      ));
    }
  }
}
