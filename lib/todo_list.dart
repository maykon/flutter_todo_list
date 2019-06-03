import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  final List list;
  final Function onFinish;
  final Function onDismissed;
  final Function onRefresh;

  TodoList({
    Key key,
    @required this.list,
    this.onFinish,
    this.onDismissed,
    this.onRefresh,
  }) : super(key: key);

  Widget _buildList(BuildContext context, int index) {
    bool checked = list[index]["ok"];
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      child: CheckboxListTile(
        title: Text(list[index]["title"]),
        value: checked,
        secondary: CircleAvatar(
          child: Icon(checked ? Icons.check : Icons.error),
        ),
        onChanged: (bool value) => onFinish(index, value),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (dir) => onDismissed(context, index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        child: ListView.builder(
          padding: EdgeInsets.only(top: 10.0),
          itemBuilder: _buildList,
          itemCount: list.length,
        ),
        onRefresh: onRefresh,
      ),
    );
  }
}
