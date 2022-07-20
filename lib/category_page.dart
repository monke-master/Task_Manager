import 'package:flutter/material.dart';
import 'package:task_manager/data.dart';
import 'package:task_manager/task.dart';
import 'package:task_manager/task_list.dart';



// Страница задач выбранной категории
class TaskListPage extends StatefulWidget {
  String? _category;

  TaskListPage(this._category, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TaskListPageState();
  }

}

// Состояние страницы задач выбранной категории
class _TaskListPageState extends State<TaskListPage> {

  @override
  Widget build(BuildContext context) {
    String category = widget._category!;
    // Получение задач выбранной категории
    List<Task> tasks = Data.getTasks(category);
    // Сортировка на активные/выполненные
    List<Task> activeTasks = [];
    List<Task> completedTask = [];
    for (Task task in tasks) {
      if (task.completed) {
        completedTask.add(task);
      } else {
        activeTasks.add(task);
      }
    }
    // Вывод списка
    return Column(
      children: [
        Expanded(
            child: TasksList(activeTasks, completedTask)
        ),
      ],
    );
  }


}

