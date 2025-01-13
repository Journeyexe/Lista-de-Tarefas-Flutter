import 'package:atividade_1/data/models/task_model.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final TaskModel item;
  const DeleteDialog({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Deletar ${item.title}?'),
      content: const Text('Esta ação é irreversível!'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Nao'),
        ),
        TextButton(
          child: const Text('Sim'),
          onPressed: () {
            Navigator.of(context).pop(true); // Fecha o pop-up
          },
        ),
      ],
    );
  }
}
