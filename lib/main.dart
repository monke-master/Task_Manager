import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_manager/categories_list.dart';
import 'package:task_manager/category_page.dart';
import 'package:task_manager/data.dart';
import 'package:task_manager/styles.dart';
import 'package:task_manager/task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() {

  runApp(Application());
}


class Application extends StatelessWidget {

  Widget build(BuildContext context) {
    Data.categories.add("no category");
    Data.categories.add("Baumanka");
    Data.tasks["no category"] = [];
    Data.tasks["no category"]!.add(Task("DOMODEDOVO", "no category"));
    Data.tasks["no category"]!.add(Task("DOMODEDOVO", "no category"));
    Data.tasks["no category"]!.add(Task("DOMODEDOVO", "no category"));
    Data.tasks["no category"]!.add(Task("DOMODEDOVO", "no category"));
    Data.tasks["no category"]!.add(Task("Vlad Gay", "no category"));
    Data.tasks["no category"]!.add(Task("Vlad Gay", "no category"));
    Data.tasks["Baumanka"] = [];
    Data.tasks["Baumanka"]!.add(Task("Gay sex", "Baumanka"));
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('ru', ''),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Task manager',
      home: Home()
    );
  }
}

class Home extends StatefulWidget {
  String _newTaskCategory = "no category";

  Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}


class _HomeState extends State<Home> {

  Widget build(BuildContext context) {
    return Scaffold(
      body: CategoryPage(),
      floatingActionButton: FloatingActionButton(
        key: const Key("addTaskBtn"),
        onPressed: () => showAddTaskDialog(),
        backgroundColor: AppColors.lightBlue,
        child: const Icon(Icons.add),
      ),
    );
  }

  // ???????????? ?????? ???????????????? ?????????? ????????????
  void showAddTaskDialog() {
    List<String> categories = [];
    categories.addAll(Data.categories);
    TextEditingController textController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  // ???????? ???????????????? ????????????
                  content: TextFormField(
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: AppLocalizations.of(context)?.createTask,
                      fillColor: AppColors.lightBlue,
                    ),
                    controller: textController,
                    // ?????????????????? ?????????????????? ?????????????? ?????????? ?????????????????? ?????????????????? ????????????
                    onChanged: (value) => setState(() {}),
                    key: Key("taskNameField"),
                  ),
                  actions: [
                    Container(
                      padding: const EdgeInsets.only(right: 70),
                      // ???????????? ??????????????????
                      child: DropdownButton(
                        key: Key("categoriesDropdownBtn"),
                        value: widget._newTaskCategory,
                        items: Data.categories.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem(
                              value: value,
                              child: Text(value == "no category"
                                  ? AppLocalizations.of(context)!.noCategory : value)
                          );
                        }).toList(),
                        onChanged: (String? value) =>
                            setState(() => widget._newTaskCategory = value!),
                      ),
                    ),
                    // ???????????????? ?????????????? ?? ???????????????????? ???????????? (?? ?????????????????? ???? ???????????? ????????)
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: AppColors.lightBlue
                      ),
                      onPressed: textController.text.isEmpty ? null : ()  {
                          Data.addTask(textController.text, widget._newTaskCategory);
                          _setChanges();
                          Navigator.pop(context);
                      },
                      key: Key("enterBtn"),
                      child: Text(AppLocalizations.of(context)!.enter),
                    ),
                  ],
                );
              }
          );
        }
      );
  }

  // ?????????????????? ?????????????????? ???????????????? ????????????????
  void _setChanges() {
    setState(() {});
  }


}

// ???????????????? ??????????????????
class CategoryPage extends StatefulWidget {

  String _category = "no category";


  @override
  State<StatefulWidget> createState() {
    return _CategoryPageState();
  }

}

// ?????????????????? ???????????????? ??????????????????
class _CategoryPageState extends State<CategoryPage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ???????????? ??????????????????
        SizedBox(
          width: double.infinity,
          height: 100,
          child: CategoriesList(
            selectedCategory: widget._category,
            onCategoryChanged: (String category) =>
              setState(() => widget._category = category),
            onCategoryDeleted: () => setState(() {
              widget._category = "no category";
            }),
          ),
        ),
        // ???????????? ?????????? ?????????????????? ??????????????????
        Expanded(
          child: TaskListPage(widget._category)),
      ],
    );
  }

}

