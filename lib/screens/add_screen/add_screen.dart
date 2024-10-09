import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/constant/colors.dart';
import 'package:todo_bloc/model/todo_model.dart';

class Add extends StatelessWidget {
  Add({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create a task"),
        backgroundColor: white,
        foregroundColor: black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "Task Title",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                        hintText: "Title...",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: mainColor, width: 1.5)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: mainColor, width: 1.5)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: mainColor, width: 1.5))),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "Description",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    controller: descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                    cursorColor: mainColor,
                    maxLines: null,
                    minLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        hintText: "Descrition...",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: mainColor, width: 1.5)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: mainColor, width: 1.5)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: mainColor, width: 1.5))),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: FilledButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          final todo = TodoModel(
                              title: titleController.text,
                              description: descriptionController.text,
                              isCompleted: false,
                              createdAt: DateTime.now());
                          context
                              .read<TodoBloc>()
                              .add(AddTodoEvent(todo: todo));
                          Navigator.pop(context);
                        }
                      },
                      style: FilledButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          backgroundColor: mainColor,
                          foregroundColor: white),
                      child: const Text("SAVE"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
