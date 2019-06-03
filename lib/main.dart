import 'package:flutter/material.dart';
import 'todo.dart';

void main() {
  runApp(MaterialApp(
    title: "Lista de Tarefas",
    home: Todo(),
    debugShowCheckedModeBanner: false,
  ));
}
