import 'package:flutter/material.dart';
import 'bloc/todo_bloc.dart';
import 'data/todo.dart';
import 'main.dart';

class TodoScreen extends StatelessWidget {
  final Todo todo;
  final bool isNew;
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtCompleteBy = TextEditingController();
  final TextEditingController txtPriority = TextEditingController();

  final TodoBloc bloc;
  TodoScreen(this.todo, this.isNew) : bloc = TodoBloc();
  @override
  Widget build(BuildContext context) {
    final double padding = 20.0;
    txtName.text = todo.name;
    txtDescription.text = todo.description;
    txtCompleteBy.text = todo.completeBy;
    txtPriority.text = todo.priority.toString();
    return Scaffold(
        appBar: AppBar(
          title: Text('Todo Details'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(padding),
                child: TextField(
                  controller: txtName,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Name'),
                )),
            Padding(
                padding: EdgeInsets.all(padding),
                child: TextField(
                  controller: txtDescription,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Description'),
                )),
            Padding(
                padding: EdgeInsets.all(padding),
                child: TextField(
                  controller: txtCompleteBy,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Complete by'),
                )),
            Padding(
                padding: EdgeInsets.all(padding),
                child: TextField(
                  controller: txtPriority,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Priority',
                  ),
                )),
            Padding(
                padding: EdgeInsets.all(padding),
                child: MaterialButton(
                  color: Colors.green,
                  child: Text('Save'),
                  onPressed: () {
                    save().then((_) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (Route<dynamic> route) => false,
                        ));
                  },
                )),
          ],
        )));
  }

  Future save() async {
    todo.name = txtName.text;
    todo.description = txtDescription.text;
    todo.completeBy = txtCompleteBy.text;
    todo.priority = int.tryParse(txtPriority.text);
    if (isNew) {
      bloc.todoInsertSink.add(todo);
    } else {
      bloc.todoUpdateSink.add(todo);
    }
  }
}
