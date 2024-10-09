import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/constant/colors.dart';
import 'package:todo_bloc/screens/add_screen/add_screen.dart';
import 'package:todo_bloc/screens/home_screen/widgets/home_icon.dart';
import 'package:todo_bloc/screens/home_screen/widgets/top_part.dart';
import 'package:todo_bloc/screens/view_screen/view_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(FetchTodoEvent());

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.read<TodoBloc>().add(FetchTodoEvent());
              },
              icon: refreshIcon())
        ],
        backgroundColor: white,
        foregroundColor: black,
        title: const Text(
          'ToDo',
          style: TextStyle(fontSize: 40),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TopPart(height: height, width: width),
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 5),
            child: Text(
              "Tasks",
              style: TextStyle(
                  color: black, fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
          Expanded(
              child: BlocConsumer<TodoBloc, TodoState>(
                  listenWhen: (previous, current) =>
                      current.hasError || current.isSuccess,
                  listener: (context, state) {
                    if (state.hasError || state.isSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.message),
                        backgroundColor: mainColor,
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.todoList.isEmpty) {
                      return const Center(
                        child: Text("No Todos..."),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: state.todoList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: state.todoList[index].isCompleted
                                    ? mainColor
                                    : null,
                                border:
                                    Border.all(color: mainColor, width: 1.5),
                                borderRadius: BorderRadius.circular(15)),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewTodo(
                                              todo: state.todoList[index],
                                            )));
                              },
                              title: Text(
                                state.todoList[index].title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              leading: GestureDetector(
                                onTap: () {
                                  bool status =
                                      !state.todoList[index].isCompleted;
                                  context.read<TodoBloc>().add(
                                      CompletedTodoEvent(
                                          todo: state.todoList[index],
                                          id: state.todoList[index].id!,
                                          isCompleted: status));
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: state.todoList[index].isCompleted
                                            ? secondaryColor
                                            : null,
                                        border: Border.all(
                                            color: secondaryColor, width: 3),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: state.todoList[index].isCompleted
                                        ? tickIcon()
                                        : null),
                              ),
                              subtitle: Text(DateFormat('yMMMd')
                                  .format(state.todoList[index].createdAt)),
                              trailing: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Confirm Deletion"),
                                          content: const Text(
                                              "Are you sure you want to delete"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                context.read<TodoBloc>().add(
                                                      DeleteTodoEvent(
                                                          id: state
                                                              .todoList[index]
                                                              .id!),
                                                    );
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Delete"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: deleteIcon()),
                            ),
                          );
                        },
                      );
                    }
                  })),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        shape: const CircleBorder(),
        child: addIcon(),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Add())),
      ),
    );
  }
}
