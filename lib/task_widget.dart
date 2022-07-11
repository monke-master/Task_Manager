import 'package:flutter/material.dart';
import 'package:task_manager/data.dart';
import 'package:task_manager/task.dart';


class TasksList extends StatelessWidget{
  List<Task> tasks = [];
  VoidCallback onListChanged;

  TasksList(this.tasks, {required this.onListChanged});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) =>
      tasks[index].complete ? buildCompetedTask(context, tasks[index]) : buildActiveTask(context, tasks[index]),
    );
  }

  Widget buildActiveTask(BuildContext context, Task task) {
    return InkResponse(
        child: Text(task.name!),
        onTap: () {
          Data.tasks[task.category]!.remove(task);
          task.complete = true;
          Data.tasks[task.category]!.add(task);
          onListChanged();
        }
    );
  }

  Widget buildCompetedTask(BuildContext context, Task task) {
    return InkResponse(
        child: Text(
          task.name!,
          style: TextStyle(decoration: TextDecoration.lineThrough),
        ),
        onTap: () {
          Data.tasks[task.category]!.remove(task);
          task.complete = false;
          Data.tasks[task.category]!.add(task);
          onListChanged();
        }
    );
  }

}