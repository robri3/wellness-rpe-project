import 'package:flutter/material.dart';
import 'package:wellnes_rpe/src/pages/home_page.dart';

import 'package:wellnes_rpe/src/pages/input_data_page.dart';
import 'package:wellnes_rpe/src/pages/view_data_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'inputData': (BuildContext context) => InputData(),
    'viewData': (BuildContext context) => ViewData(),
    //'player_data' : (BuildContext context) => DataPage(),
  };
}
