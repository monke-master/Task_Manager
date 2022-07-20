import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/data.dart';
import 'package:task_manager/task.dart';

void main() {


  setUp(() {
    Data.categories.clear();
    Data.tasks.clear();
    Data.categories.add("no category");
    Data.categories.add("category 1");
    Data.categories.add("category 2");
    Data.tasks["no category"] = [
      Task("task 1", "no category"),
      Task("task 2", "no category"),
      Task("task 3", "no category"),
    ];
    Data.tasks["category 1"] = [
      Task("task 1", "category 1"),
      Task("task 2", "category 1"),
      Task("task 3", "category 1"),
    ];
    Data.tasks["category 2"] = [
      Task("task 1", "category 2"),
    ];
  });


  group("adding category", () {
    test("adding new category", () {
      Data.addCategory("category 3");
      List<String> expectedCategories = ["no category", "category 1", "category 2", "category 3"];
      expect(Data.categories, expectedCategories);
      expect([], Data.tasks["category 3"]);
    });

    test("adding existing category", () {
      Data.addCategory("category 2");
      List<String> expectedCategories = ["no category", "category 1", "category 2"];
      List<Task> expectedTasks = [Task("task 1", "category 2")];
      expect(Data.categories, expectedCategories);
      expect(Data.tasks["category 2"], expectedTasks);
    });
  });


  test("deleting category", () {
    Data.deleteCategory("category 2");
    List<String> expectedCategories = ["no category", "category 1"];
    expect(Data.categories, expectedCategories);
  });

  test("adding Task", () {
    Data.addTask("task 4", "no category");
    List<Task> expectedTasks = [
      Task("task 4", "no category"),
      Task("task 1", "no category"),
      Task("task 2", "no category"),
      Task("task 3", "no category"),
    ];
    expect(Data.tasks["no category"], expectedTasks);
  });

  group("editing category", () {
    test("editing category with non-existent new name", () {
      Data.editCategory("category 2", "category 2 new");
      List<String> expectedCategories = ["no category", "category 1", "category 2 new"];
      List<Task> expectedTasks = [
        Task("task 1", "category 2 new"),
      ];
      expect(Data.categories, expectedCategories);
      expect(Data.tasks["category 2 new"], expectedTasks);
    });

    test("editing category with existing new name", () {
      Data.editCategory("category 2", "category 1");
      List<String> expectedCategories = ["no category", "category 1", "category 2"];
      List<Task> expectedTasks = [
        Task("task 1", "category 2"),
      ];
      expect(Data.categories, expectedCategories);
      expect(Data.tasks["category 2"], expectedTasks);
    });
  });

  group("getting tasks", () {
    test("getting all tasks", () {
      List<Task> tasks = Data.getTasks("no category");
      List<Task> expectedTasks = [
        Task("task 1", "no category"),
        Task("task 2", "no category"),
        Task("task 3", "no category"),
        Task("task 1", "category 1"),
        Task("task 2", "category 1"),
        Task("task 3", "category 1"),
        Task("task 1", "category 2"),
      ];
      expect(tasks, expectedTasks);
    });

    test("getting task with a certain category", () {
      List<Task> tasks = Data.getTasks("category 2");
      List<Task> expectedTasks = [Task("task 1", "category 2")];
      expect(tasks, expectedTasks);
    });
  });


}

