import 'dart:ui';

class Task {
  String? name;
  String? category;
  bool completed = false;

  Task(this.name, this.category);

  @override
  String toString() {
    return "$category $name";
  }

  @override
  operator ==(o) {
    return o is Task &&
    o.name == name &&
    o.category == category &&
    o.completed == completed;
  }

  @override
  int get hashCode => hashValues(name, category, completed);


}