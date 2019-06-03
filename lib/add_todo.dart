import 'package:flutter/material.dart';

class AddTodo extends StatelessWidget {
  final _todoController = TextEditingController();
  final Function onAdd;

  AddTodo({Key key, this.onAdd}) : super(key: key);

  void _addTodo(BuildContext context) {
    if (_todoController.text.isEmpty) return;
    onAdd(_todoController.text);
    _todoController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: "Nova Tarefa",
                labelStyle: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
              controller: _todoController,
            ),
          ),
          RaisedButton(
            onPressed: () => _addTodo(context),
            color: Colors.blueAccent,
            child: Text("ADD"),
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
