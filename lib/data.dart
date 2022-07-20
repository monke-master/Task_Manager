import 'package:task_manager/task.dart';

// Данные
class Data {
  // Пары Категория - Список задач
  static Map<String, List<Task>> tasks = {};
  // Список категорий
  static List<String> categories = [];

  // Добавление категории
  static addCategory(String newCategory) {
    if (!Data.categories.contains(newCategory)) {
      Data.categories.add(newCategory);
      Data.tasks[newCategory] = [];
    }
  }

  // Удаление категории
  static deleteCategory(String category) {
    Data.tasks.remove(category);
    Data.categories.remove(category);
  }

  // Добавление задачи
  static addTask(String taskName, String category) {
    Data.tasks[category]!.insert(
        0,
        Task(taskName, category));
  }

  // Изменение категории(Если категории с новым названием еще нет)
  static editCategory(String oldCategory, String newCategory) {
    if (!Data.categories.contains(newCategory)) {
      Data.categories[Data.categories.indexOf(oldCategory)] = newCategory;
      List<Task> newList = [];
      for (Task task in Data.tasks[oldCategory]!) {
        task.category = newCategory;
        newList.add(task);
      }
      Data.tasks.remove(oldCategory);
      Data.tasks[newCategory] = newList;

    }
  }

  // Получение списка задач выбранной категории
  static getTasks(String category) {
    List<Task> tasks = [];
    if (category == "no category") {
      for (String cat in Data.tasks.keys) {
        tasks.addAll(Data.tasks[cat]!);
      }
    } else {
      tasks.addAll(Data.tasks[category]!);
    }
    return tasks;
  }
}