import 'dart:convert';

import 'package:atividade_1/data/models/task_model.dart';
import 'package:atividade_1/widgets/custom_app_bar.dart';
import 'package:atividade_1/widgets/textbox.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTaskScreenArguments {
  final String title;
  final String description;
  final bool isEditing;

  AddTaskScreenArguments({
    this.title = '',
    this.description = '',
    this.isEditing = false,
  });
}

class AddTaskScreen extends StatefulWidget {
  static const addRouteName = '/add';

  const AddTaskScreen({
    super.key,
  });

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  late SharedPreferences _prefs;
  final String _key = 'myData';
  late List<String> _data = [];
  late String titleKey;
  late String appBarTitle;

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments =
        ModalRoute.of(context)?.settings.arguments as AddTaskScreenArguments?;
    if (arguments != null) {
      appBarTitle = arguments.isEditing? 'Editar tarefa' : 'Adicionar tarefa';
      titleKey = arguments.title;
      _titleController.text = arguments.title;
      _descriptionController.text = arguments.description;
    }
  }

  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _data = _prefs.getStringList(_key) ?? [];
    });
  }

  Future<void> _addTask(String title, String description) async {
    _data.add(
        jsonEncode(TaskModel(title: title, description: description).toJson()));
    await _prefs.setStringList(_key, _data);
  }

  Future<void> _editTask(String title, String description) async {
    final TaskModel task = TaskModel(title: title, description: description);
    final int index = _data.indexWhere((element) {
      return TaskModel.fromMap(jsonDecode(element)).title == titleKey;
    });
    if (index != -1) {
      _data[index] = jsonEncode(task.toJson());
      await _prefs.setStringList(_key, _data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: appBarTitle),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Textbox(
                placeholder: 'Titulo da tarefa', controller: _titleController),
            const SizedBox(
              height: 16,
            ),
            Textbox(
                placeholder: 'Descrição da tarefa',
                controller: _descriptionController),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.deepPurple.withOpacity(.5),
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: () {
                if (_titleController.text.isNotEmpty) {
                  if ((ModalRoute.of(context)?.settings.arguments
                              as AddTaskScreenArguments?)
                          ?.isEditing ??
                      false) {
                    _editTask(
                        _titleController.text, _descriptionController.text);
                  } else {
                    _addTask(
                        _titleController.text, _descriptionController.text);
                  }
                  Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Insira um titulo'),
                    ),
                  );
                }
              },
              child: const Text(
                'Salvar tarefa',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
