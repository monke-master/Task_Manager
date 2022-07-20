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

  TasksList(this._activeTasks, this._completedTasks);

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
          return _activeTaskContainer(context, activeTasks[index]);
        }
        if (index == -1) {
          return _emptyHeader(context);
        }
        if (index == activeTasks.length) {
          return _completedTasksHeader(context);
        }
        return _completedTaskContainer(context, completedTasks[index - activeTasks.length - 1]);
    }
    );
  }

  // List of active tasks
  Widget _activeTaskContainer(BuildContext context, Task task) {
    return GestureDetector(
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (DismissDirection direction) {
            setState(() {
              Data.tasks[task.category]?.remove(task);
                widget._activeTasks.remove(task);
            });
          },
          background: Container(
            color: AppColors.red,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child: _activeTaskWidget(context, task),
        ),
        onTap: () {
          // TODO
          // Make page with task's information
        },
    );
  }

  Widget _activeTaskWidget(BuildContext context, Task task) {
    return Container(
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
                setState(() {
                  widget._activeTasks.remove(task);
                  Data.tasks[task.category]!.remove(task);
                  task.completed = true;
                  Data.tasks[task.category]!.add(task);
                  widget._completedTasks.add(task);
                });
              },
            ),
          ),
          Text(
            task.name!,
            style: defaultTxt(),
          ),
        ],
      ),
    );
  }

  // Completed tasks header
  Widget _completedTasksHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
      child: Text(
        AppLocalizations.of(context)!.completedTasks,
        style: defaultTxt(),
      )
    );
  }

  Widget _completedTaskContainer(BuildContext context, Task task) {
    return GestureDetector(
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (DismissDirection direction) {
          setState(() {
            Data.tasks[task.category]?.remove(task);
            widget._completedTasks.remove(task);
          });
        },
        background: Container(
          color: Colors.red,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        child: _completedTaskWidget(context, task),
      ),
      onTap: () {
        // TODO
        // Make page with task's information
      },
    );
  }


  // List of completed tasks
  Widget _completedTaskWidget(BuildContext context, Task task) {
    return Container(
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
                  setState(() {
                    widget._activeTasks.add(task);
                    Data.tasks[task.category]!.remove(task);
                    task.completed = false;
                    widget._completedTasks.remove(task);
                    Data.tasks[task.category]!.add(task);
                  });
                },
              )
          ),
          Text(
            task.name!,
            style: completedTaskTxt(),
          ),
        ],
      ),
    );

  }


  // Empty header if there is no any active tasks
  Widget _emptyHeader(BuildContext context) {
    return Container(
      alignment: Alignment.center,
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
        child: Text(
          AppLocalizations.of(context)!.noTasks,
          style: defaultTxt(),
          textAlign: TextAlign.center,
        )
    );
  }
}