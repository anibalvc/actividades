import 'package:binance_api_test/core/models/usuarios_response.dart';
import 'package:flutter/material.dart';

class UsuariosProvider with ChangeNotifier {
  final List<UsuariosData> _usuariosData = [
    UsuariosData(
        id: "1",
        loginUsuario: "Operario1",
        nombrePerfil: "Operario 1",
        tipoUsuario: "Operario",
        password: "123456"),
    UsuariosData(
        id: "2",
        loginUsuario: "Operario2",
        nombrePerfil: "Operario 2",
        tipoUsuario: "Operario",
        password: "123456"),
    UsuariosData(
        id: "3",
        loginUsuario: "Operario3",
        nombrePerfil: "Operario 3",
        tipoUsuario: "Operario",
        password: "123456"),
    UsuariosData(
        id: "4",
        loginUsuario: "JefeMina1",
        nombrePerfil: "Jefe de Mina 1",
        tipoUsuario: "Jefe de Mina",
        password: "123456"),
    UsuariosData(
        id: "5",
        loginUsuario: "JefeMina2",
        nombrePerfil: "Jefe de Mina 2",
        tipoUsuario: "Jefe de Mina",
        password: "123456"),
    UsuariosData(
        id: "6",
        loginUsuario: "JefeMina3",
        nombrePerfil: "Jefe de Mina 3",
        tipoUsuario: "Jefe de Mina",
        password: "123456"),
  ];
  List<UsuariosData> get usuarios => _usuariosData;
}
