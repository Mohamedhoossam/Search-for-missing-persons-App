import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newnew/shared/style/colors.dart';
ThemeData darkTheme =ThemeData(
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.black
  ),
  colorScheme: ColorScheme.dark(primary: defaultColor,),
  scaffoldBackgroundColor: Colors.black,
  appBarTheme:  AppBarTheme(
    titleSpacing: 20,
    systemOverlayStyle:const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Colors.black,
    elevation: 0,
    titleTextStyle: const TextStyle(color: Colors.white,fontSize: 18),
    centerTitle: true,
    iconTheme: IconThemeData(
      color: defaultColor,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      elevation: 20,
      backgroundColor: Colors.black
  ),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
      ),
      bodyText2: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      )
  ),
);

ThemeData lightTheme =ThemeData(
    drawerTheme:  DrawerThemeData(
        backgroundColor: defaultColor
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme:  AppBarTheme(
      titleSpacing: 20,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white.withOpacity(.1),
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: const TextStyle(fontFamily: 'Jannah',color: Colors.black,fontSize: 18),
      centerTitle: true,
      iconTheme: IconThemeData(
        color: defaultColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        unselectedItemColor: Colors.grey,
        elevation: 20,
        backgroundColor: Colors.white
    ),
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.black,

        ),
        bodyText2: TextStyle(
          fontSize: 12,
         // fontFamily: 'jannah',
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        )
    ),
    colorScheme: ColorScheme.light(primary: defaultColor,)




);