import 'package:flutter/material.dart';
import 'package:todo_db_template/domain/todo/todo_model.dart';

class ScreenTodoHome extends StatefulWidget {
  const ScreenTodoHome({super.key});

  @override
  State<ScreenTodoHome> createState() => _ScreenTodoHomeState();
}

class _ScreenTodoHomeState extends State<ScreenTodoHome> {
  final todoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int id = 0;
  List<TodoModel> todoModelList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
              child: Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextFormField(
                          controller: todoController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Task Cannot be empty!';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              hintText: 'Task Name',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                id = id + 1;
                                TodoModel t = TodoModel(
                                    todoId: id.toString(),
                                    todoName: todoController.text,
                                    todoStatus: '0');
                                todoModelList.add(t);
                              });
                              todoController.text = '';
                            }
                          },
                          child: const Text('Add')),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * .8,
                child: ListView.builder(
                  itemBuilder: (BuildContext, index) {
                    return ListTile(
                      onTap: () {
                        setState(() {
                          for (var doc in todoModelList) {
                            if (doc.todoId == todoModelList[index].todoId) {
                              doc.todoStatus =
                                  doc.todoStatus == '0' ? '1' : '0';
                            }
                          }
                        });
                      },
                      leading: Text((index + 1).toString()),
                      title: Text(todoModelList[index].todoName),
                      subtitle: Text(
                        todoModelList[index].todoStatus == '0'
                            ? 'Not Completed'
                            : 'Completed',
                        style: TextStyle(
                            color: todoModelList[index].todoStatus == '0'
                                ? Colors.red
                                : Colors.green),
                      ),
                    );
                  },
                  itemCount: todoModelList.length,
                ))
          ],
        ),
      ),
    );
  }
}
