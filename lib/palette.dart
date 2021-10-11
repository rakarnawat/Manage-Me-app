import 'package:flutter/material.dart';
class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xff000000, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xffffffff ),//10%
      100: const Color(0xffffffff),//20%
      200: const Color(0xffffffff),//30%
      300: const Color(0xffffffff),//40%
      400: const Color(0xffffffff),//50%
      500: const Color(0xffffffff),//60%
      600: const Color(0xffffffff),//70%
      700: const Color(0xffffffff),//80%
      800: const Color(0xffffffff),//90%
      900: const Color(0xff000000),//100%
    },
  );
  static const MaterialColor kToLight = MaterialColor(
    0xffffffff, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xffffffff ),//10%
      100: const Color(0xffffffff),//20%
      200: const Color(0xffffffff),//30%
      300: const Color(0xffffffff),//40%
      400: const Color(0xffffffff),//50%
      500: const Color(0xffffffff),//60%
      600: const Color(0xffffffff),//70%
      700: const Color(0xffffffff),//80%
      800: const Color(0xffffffff),//90%
      900: const Color(0xff000000),//100%
    },
  );
}