import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:wellnes_rpe/src/classes/PlayerData.dart';

class _JsonFileHandler {
  List<dynamic> opciones = [];

  _JsonFileHandler() {
    //cargarData();
  }

  String usePlayerJsonEncode(PlayerData playerData) {
    return jsonEncode(playerData);
  }

  String useJsonEncode(data) {
    return jsonEncode(data);
  }

  dynamic useJsonDecode(jsonPInfo) {
    return jsonDecode(jsonPInfo);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/player_data.json');
  }

  Future<File> writeString(String data) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$data');
  }

  Future<String> readString() async {
    try {
      final file = await _localFile;

      // Read the file
      if (file.existsSync()) {
        final contents = await file.readAsString();
        return (contents);
      } else {
        return '';
      }
    } catch (e) {
      // If encountering an error, return 0
      return 'error';
    }
  }

  deleteFile() async {
    final file = await _localFile;
    if (file.existsSync()) {
      file.delete();
    }
    // Write the file
  }
}

final jsonFileHandler = new _JsonFileHandler();
