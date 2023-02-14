import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.indigo,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          centerTitle: true
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0
        )
      ),
      title: 'Productos App',
      initialRoute: LoginScreen.routerName,
      routes: {
        HomeScreen.routerName:(_) => const HomeScreen() ,
        LoginScreen.routerName: (_) => const LoginScreen(),
      },
    );
  }
}