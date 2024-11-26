import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/* Colors */
class AppColors {
  static const bronce = Color.fromRGBO(235, 219, 206, 1);
  static const grey = Color.fromARGB(255, 163, 161, 161);
  static const orange = Color(0xFFFE9301);
  static const darkOrange = Color.fromRGBO(255, 135, 44, 1);
  static const green = Color(0xFFA8C638);
  static const brownLight = Color.fromRGBO(1, 125, 197, 1);
  static const blue = Color.fromRGBO(1, 125, 197, 1);
  static const blueDark = Color(0xff263554);
  static const white = Color.fromARGB(255, 255, 255, 255);
  static const gold = Color.fromRGBO(222, 158, 61, 1);
  static const cream = Color.fromRGBO(255, 247, 235, 1);
  static const lightGreen = Color.fromRGBO(46, 226, 146, 1);
  static const newBrownBlblueDark = Color.fromRGBO(109, 68, 32, 1);
  static const black = Color.fromRGBO(0, 0, 0, 1);
  static const blueSplash = Color.fromRGBO(51, 70, 113, 1);
  static const blueAppbar = Color.fromRGBO(75, 105, 169, 1);
  static const blueSecondary = Color.fromRGBO(86, 116, 180, 1);
  static const blueScaffold = Color(0xff334671);
  static const blueNoticias = Color.fromARGB(255, 0, 0, 0);
  static const binanceYellow = Color(0xffEBBE14);
}

class AppIcons {
  static const paperPlane = FontAwesomeIcons.paperPlane;
  static const pencilAlt = FontAwesomeIcons.penToSquare;
  static const closeCircle = Icons.cancel_outlined;
  static const accountOutline = Icons.account_circle_outlined;
  static const messageOutline = Icons.messenger_outline_sharp;
  static const checkCircle = Icons.check_circle_outline;
  static const iconPlus = Icons.add_circle_outline;
  static const save = Icons.save;
  static const personOutline = Icons.person_outline;
  static const nonCheckCircle = Icons.circle_outlined;
  static const search = Icons.search;
  static const arrowDowm = Icons.arrow_drop_down_sharp;
  static const relojArena = Icons.hourglass_bottom;
  static const calendario = Icons.calendar_month_sharp;
  static const manual = Icons.back_hand_sharp;
  static const vitacora = Icons.menu_book;
  static const filtro = Icons.filter_list;
}

final myTheme = ThemeData(
  primaryColor: AppColors.blue,
  colorScheme: const ColorScheme.light(
    primary: AppColors.blue,
    secondary: AppColors.blue,
  ),
  cardTheme: CardTheme(
    color: AppColors.blueAppbar,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
  ),
  focusColor: AppColors.blueAppbar,
  scaffoldBackgroundColor: AppColors.white,
  iconTheme: const IconThemeData(size: 30, color: AppColors.blue),
  textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.blue),
  appBarTheme: const AppBarTheme(
    elevation: 3,
    backgroundColor: AppColors.white,
    iconTheme: IconThemeData(color: AppColors.blue),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: AppColors.blueNoticias,
    ),
  ),
);

/* TextStyles */

TextStyle appDropdown = const TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

abstract class AppTextStyle {
  static const TextStyle h1White = TextStyle(
      fontSize: 20,
      color: AppColors.blue,
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.bold);
  static const TextStyle h1Style = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );
  static const TextStyle h2Style = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );
  static const TextStyle h3Style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );
  static const TextStyle tituloNoticiaStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.blueNoticias,
  );
  static const TextStyle subNoticiaStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: AppColors.blueNoticias,
  );
  static const TextStyle minimarketStyle = TextStyle(
    fontSize: 15,
    color: AppColors.blueNoticias,
  );
  static const h2BlackStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const h2RedStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 240, 26, 11),
  );
  static const mediumBlackStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );
  static const bigBlackStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );
  static const mediumGreyStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black54,
  );
  static const littleTransGreyStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.black26,
  );
  static const bigTransGreyStyle = TextStyle(
    fontSize: 32,
    color: Colors.black26,
  );
  static const litteTagStyle =
      TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w900);
}

/* Durations */

Duration durationLoading = const Duration(seconds: 15);
