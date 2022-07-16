import 'package:flutter/material.dart';
import 'package:task_manager/data.dart';
import 'package:task_manager/styles.dart';
import 'package:task_manager/task.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksList extends StatefulWidget{
  List<Task> tasks = [];
  List<Task> _activeTasks = [];
  List<Task> _completedTasks = [];
  VoidCallback onListChanged;

  TasksList(this._activeTasks, this._completedTasks, {required this.onListChanged});

  @override
  State<StatefulWidget> createState() {
    return _TasksListState();
  }

}

class _TasksListState extends State<TasksList> {

  @override
  Widget build(BuildContext context) {
    List<Task> activeTasks = widget._activeTasks;
    List<Task> completedTasks = widget._completedTasks;
    // Count of headers
    int headersCount = activeTasks.isEmpty ? 2 : 1;
    if (completedTasks.isEmpty) {
      headersCount--;
    }
    // Building list view
    return ListView.builder(
      itemCount: activeTasks.length + completedTasks.length + headersCount,
      itemBuilder: (context, index) {
        if (activeTasks.isEmpty) {
          index -= 1;
        } else if (index < activeTasks.length) {
          return buildActiveTask(context, activeTasks[index]);
        }
        if (index == -1) {
          return emptyHeader(context);
        }
        if (index == activeTasks.length) {
          return completedTasksHeader(context);
        }
        return buildCompletedTask(context, completedTasks[index - activeTasks.length - 1]);
    }
    );
  }

  // List of active tasks
  Widget buildActiveTask(BuildContext context, Task task) {
    return InkResponse(
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 10),
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 5, right: 10),
                child: IconButton(
                  icon: SvgPicture.asset("res/assets/buttons/active.svg"),
                  onPressed: () {
                    Data.tasks[task.category]!.remove(task);
                    task.complete = true;
                    Data.tasks[task.category]!.add(task);
                    widget.onListChanged();
                  },
                ),
              ),
              Text(
                task.name!,
                style: taskTxt(),
              ),
            ],
          ),
        ),
        onTap: () {
          // TODO
          // Make page with task's information
        }
    );
  }

  // Completed tasks header
  Widget completedTasksHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
      child: Text(
        AppLocalizations.of(context)!.completedTasks,
        style: taskTxt(),
      )
    );
  }

  // List of completed tasks
  Widget buildCompletedTask(BuildContext context, Task task) {
    return InkResponse(
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 10),
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 5, right: 10),
              child: IconButton(
                icon: SvgPicture.asset("res/assets/buttons/completed.svg"),
                onPressed: () {
                  Data.tasks[task.category]!.remove(task);
                  task.complete = false;
                  Data.tasks[task.category]!.add(task);
                  widget.onListChanged();
                },
              )
            ),
            Text(
              task.name!,
              style: completedTaskTxt(),
            ),
          ],
        ),
      ),
      onTap: () {
        // TODO
        // Make page with task's information
      }
    );
  }

  // Empty header if there is no any active tasks
  Widget emptyHeader(BuildContext context) {
    return Container(
      alignment: Alignment.center,
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
        child: Text(
          AppLocalizations.of(context)!.noTasks,
          style: taskTxt(),
          textAlign: TextAlign.center,
        )
    );
  }
}