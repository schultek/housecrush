import 'package:flutter/painting.dart';

const ColorSwatch hcLight = ColorSwatch(4285693069, {
  1000: Color.fromRGBO(0, 0, 0, 1),
  900: Color.fromRGBO(4, 14, 32, 1),
  800: Color.fromRGBO(14, 29, 55, 1),
  700: Color.fromRGBO(35, 49, 73, 1),
  600: Color.fromRGBO(75, 87, 107, 1),
  500: Color.fromRGBO(114, 124, 141, 1),
  400: Color.fromRGBO(166, 175, 192, 1),
  300: Color.fromRGBO(213, 218, 227, 1),
  200: Color.fromRGBO(238, 241, 246, 1),
  100: Color.fromRGBO(248, 249, 252, 1),
  0: Color.fromRGBO(255, 255, 255, 1),
});

const ColorSwatch hcDark = ColorSwatch(4284706424, {
  1000: Color.fromRGBO(0, 0, 0, 1),
  900: Color.fromRGBO(20, 28, 35, 1),
  800: Color.fromRGBO(39, 50, 59, 1),
  750: Color.fromRGBO(45, 57, 67, 1),
  700: Color.fromRGBO(54, 67, 79, 1),
  600: Color.fromRGBO(70, 85, 97, 1),
  500: Color.fromRGBO(99, 110, 120, 1),
  400: Color.fromRGBO(141, 152, 165, 1),
  300: Color.fromRGBO(184, 193, 203, 1),
  200: Color.fromRGBO(214, 220, 227, 1),
  100: Color.fromRGBO(235, 239, 245, 1),
  0: Color.fromRGBO(255, 255, 255, 1),
});

const ColorSwatch hcBlue = ColorSwatch(4280842997, {
  900: Color.fromRGBO(1, 37, 91, 1),
  800: Color.fromRGBO(0, 53, 132, 1),
  700: Color.fromRGBO(10, 78, 181, 1),
  600: Color.fromRGBO(8, 95, 226, 1),
  500: Color.fromRGBO(40, 122, 245, 1),
  400: Color.fromRGBO(179, 212, 252, 1),
  300: Color.fromRGBO(222, 237, 255, 1),
  200: Color.fromRGBO(235, 243, 254, 1),
  100: Color.fromRGBO(248, 251, 255, 1)
});

const Color hcLightBlue = Color.fromRGBO(222, 237, 255, 1);

final Color hcRed = Color(int.parse('ffa1232b', radix: 16));

final Color hcGreen = Color(int.parse('ff41C58D', radix: 16));
final Color hcYellow = Color(int.parse('ffFFD43D', radix: 16));

Color colorForPriority(int priority) {
  switch (priority) {
    case 1:
      return const Color(0xFFE8475C);
    case 2:
      return const Color(0xFFF3B910);
    case 3:
      return const Color(0xFF0DBE60);
    case 4:
      return const Color(0xFF0EBBDC);
    case 5:
      return const Color(0xFF8676FF);
    default:
      return const Color(0xFFE8475C);
  }
}
