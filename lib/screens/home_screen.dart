import 'dart:convert';

import 'package:atividade_1/data/models/task_model.dart';
import 'package:atividade_1/screens/add_task_screen.dart';
import 'package:atividade_1/widgets/custom_app_bar.dart';
import 'package:atividade_1/widgets/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences _prefs;
  final String _key = 'myData';
  late List<String>? _data = [];
  late List<TaskModel> _tasks = [];

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _data = _prefs.getStringList(_key);
      _tasks = _getTasks();
    });
  }

  List<TaskModel> _getTasks() {
    return (_data ?? []).map((taskString) {
      Map<String, dynamic> taskMap = jsonDecode(taskString);
      return TaskModel.fromMap(taskMap);
    }).toList();
  }

  Future<void> _delete(task) async {
    setState(() {
      // _prefs.remove(_key);
      _data!.remove(task);
    });
    await _prefs.setStringList(_key, _data?.toList() ?? []);
  }

  Future<void> _changeStatus(task, value) async {
    final int index = _tasks.indexOf(task);
    if (index != -1) {
      _tasks[index].isDone = value;
      _data![index] = jsonEncode(_tasks[index].toJson());
      await _prefs.setStringList(_key, _data!.toList());
    }
  }

  void _showPopup(BuildContext context, TaskModel item) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return DeleteDialog(
          item: item,
        );
      },
    );

    if (result != null && result) {
      _delete(jsonEncode(item.toJson()));
      _initializePreferences();
      snackBar();
    }
  }

  void snackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tarefa deletada com sucesso!'),
        showCloseIcon: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Lista de tarefas',
        isHomePage: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .8,
              child: ListView.separated(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final item = _tasks[index];
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 250,
                          child: ListTile(
                            leading: Checkbox(
                              value: item.isDone,
                              onChanged: (value) {
                                _changeStatus(item, value);
                                _initializePreferences();
                              },
                            ),
                            title: Text(
                              item.title,
                              style: TextStyle(
                                color: item.isDone ? Colors.grey : Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              item.description,
                              style: TextStyle(
                                color: item.isDone ? Colors.grey : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(
                                  onPressed: () async {
                                    final result = await Navigator.of(context)
                                        .pushNamed(AddTaskScreen.addRouteName,
                                            arguments: AddTaskScreenArguments(
                                              title: item.title,
                                              description: item.description,
                                              isEditing: true,
                                            ));
                                    if (result == true) {
                                      _initializePreferences();
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(
                                  onPressed: () => _showPopup(context, item),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.deepPurple.withOpacity(.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result =
              await Navigator.pushNamed(context, AddTaskScreen.addRouteName);
          if (result == true) {
            _initializePreferences();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
