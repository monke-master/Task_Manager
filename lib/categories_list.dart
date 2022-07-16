import 'package:flutter/material.dart';
import 'package:task_manager/data.dart';
import 'package:task_manager/styles.dart';
import 'package:task_manager/task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoriesList extends StatefulWidget {

  Function(String) onCategoryChanged;
  String? selectedCategory;


  CategoriesList(this.selectedCategory, {Key? key, required this.onCategoryChanged}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CategoriesListState();
  }

}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: Data.categories.length + 1,
        itemBuilder: (context, index) {
          if (index == Data.categories.length) {
            return addCategoryBtn(context);
          }
          return buildCategory(context, Data.categories[index]);
        }
    );
  }


  Widget buildCategory(BuildContext context, String category) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 8, right: 8, ),
      child: ElevatedButton(
        style: categoryBtn(category == widget.selectedCategory),

        child: Text((category == "no category") ? "all" : category),
        onPressed: () => widget.onCategoryChanged(category)
      ),
    );

  }


  Widget addCategoryBtn(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 8, right: 8),
      child: ElevatedButton(
        style: categoryBtn(false),
        onPressed: () => showAddCategoryDialog(context),
        child: const Text("+"),
      ),
    );
  }

  void showAddCategoryDialog(BuildContext context) {
    TextEditingController textController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: Text(AppLocalizations.of(context)!.newCategory),
                content: TextFormField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: AppLocalizations.of(context)?.newCategory,
                    fillColor: AppColors.lightBlue,
                  ),
                  controller: textController,
                  onChanged: (value) => setState(() {}),
                ),
                actions: [
                  TextButton(
                    child: Text("Enter"),
                    onPressed: textController.text.isEmpty? null : () {
                      String newCategory = textController.text;
                      if (!Data.categories.contains(newCategory)) {
                        Data.categories.add(newCategory);
                        Data.tasks[newCategory] = [];
                      }
                      setChanges();
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            }
        );}
    );
  }

  void setChanges() {
    setState(() {});
  }

}