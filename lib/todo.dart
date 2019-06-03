import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo/add_todo.dart';
import 'package:todo/todo_file.dart';
import 'todo_list.dart';

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List _list = [];

  @override
  void initState() {
    super.initState();
    readData().then((content) {
      setState(() {
        _list = json.decode(content);
      });
    });
  }

  void _onAddTodo(String todo) {
    Map<String, dynamic> newTodo = Map();
    newTodo["title"] = todo;
    newTodo["ok"] = false;
    setState(() {
      _list.add(newTodo);
    });
    saveData(_list);
  }

  void _onFinishTodo(int index, bool checked) {
    setState(() {
      _list[index]["ok"] = checked;
    });
    saveData(_list);
  }

  void _onDismissed(BuildContext context, int index) {
    var lastIndexRemoved = index;
    var lastRemoved = _list.elementAt(index);
    setState(() {
      _list.removeAt(index);
    });
    saveData(_list);
    _showSnackBar(context, lastIndexRemoved, lastRemoved);
  }

  void _showSnackBar(
      BuildContext context, int index, Map<String, dynamic> item) {
    final snack = SnackBar(
      content: Text("Tarefa ${item["title"]} removida."),
      action: SnackBarAction(
        label: "Desfazer",
        onPressed: () {
          setState(() {
            _list.insert(index, item);
          });
          saveData(_list);
        },
      ),
      duration: Duration(seconds: 2),
    );
    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(snack);
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _list.sort((a, b) {
        if (a["ok"] && !b["ok"]) return 1;
        if (!a["ok"] && b["ok"]) return -1;
        return 0;
      });
    });
    saveData(_list);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: <Widget>[
          AddTodo(onAdd: _onAddTodo),
          TodoList(
            list: _list,
            onFinish: _onFinishTodo,
            onDismissed: _onDismissed,
            onRefresh: _onRefresh,
          ),
        ],
      ),
    );
  }
}
