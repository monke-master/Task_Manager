import 'package:flutter/material.dart';

// Цвета приложения и стили виджетов

class AppColors {
  static Color lightBlue = const Color.fromARGB(255, 0, 128, 255);
  static Color blue = const Color.fromARGB(255, 0, 87, 173);
  static Color gray = const Color.fromARGB(255, 108, 108, 108); 
  static Color red = const Color.fromARGB(255, 254, 0, 0);
}



TextStyle _categoryTxt() {
  return const TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}

ButtonStyle categoryBtn(bool selected) {
  return ElevatedButton.styleFrom(
    primary: selected ? AppColors.lightBlue : AppColors.blue,
    textStyle: _categoryTxt(),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),

    ),
  );
}

TextStyle defaultTxt() {
  return const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold
  );
}


TextStyle completedTaskTxt() {
  return TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.lineThrough,
    color: AppColors.gray,
  );
}
