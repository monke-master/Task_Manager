import 'package:flutter/material.dart';
import 'package:task_manager/data.dart';
import 'package:task_manager/task.dart';

class CategoriesList extends StatefulWidget {

  Function(String) onCategoryChanged;

  CategoriesList({required this.onCategoryChanged});

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
        itemCount: Data.categories.length,
        itemBuilder: (context, index) => buildCategory(context, Data.categories[index]));

  }

  Widget buildCategory(BuildContext context, String category) {
    return InkResponse(
      child:Container(
        child: Text((category == "no category") ? "all" : category),
        padding: EdgeInsets.only(top: 50, left: 16, right: 16),
      ), onTap: () => widget.onCategoryChanged(category),

    );
  }



}