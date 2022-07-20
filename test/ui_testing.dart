// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:task_manager/main.dart';

void main() {
  setUpAll(() {

  });
  group("adding task", () {
    late Finder addTaskBtn, taskNameField, enterBtn, categoriesDropDownBtn;
    setUp(() {
       addTaskBtn = find.byKey(Key("addTaskBtn"));
       taskNameField = find.byKey(Key("taskNameField"));
       enterBtn = find.byKey(Key("enterBtn"));
       categoriesDropDownBtn = find.byKey(Key("categoriesDropdownBtn"));
    });
    testWidgets('Open Add task dialog test', (WidgetTester tester) async {
      await tester.pumpWidget(Application());
      await tester.tap(addTaskBtn);
      await tester.pump();

      expect(taskNameField, findsOneWidget);
      expect(enterBtn, findsOneWidget);
      expect(categoriesDropDownBtn, findsOneWidget);
    });
    testWidgets('Enter task name without choosing category', (tester) async {
      await tester.pumpWidget(Application());
      await tester.tap(categoriesDropDownBtn);
    });
  });

}
