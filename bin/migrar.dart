import 'dart:io';

import 'package:brilliant_server/configuracion.dart';
import 'package:brilliant_server/bd/conexion.dart';

void main() {
  final config = Config.desdeEntorno(Platform.environment);
  final db = abrirBaseDeDatos(config.databasePath);
  print('Migraciones aplicadas sobre ${config.databasePath}');
  db.dispose();
}
