import 'package:flutter/material.dart';
import 'package:untitled/user.dart';
class PieData {
  static List<Data> data = [
    Data(name: 'Present', percent: 70, color: const Color(0xff0293ee)),
    Data(name: 'Absent', percent: 30, color: const Color(0xfff8b250)),

  ];
}

class Data {
  final String name;

  final double percent;

  final Color color;

  Data({required this.name, required this.percent, required this.color});
}