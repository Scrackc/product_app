import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsService(),),
        ChangeNotifierProvider(create: (_) => AuthService(),),
      ],
      child: const MyApp(),
    );
  }
}

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
      scaffoldMessengerKey: NotificationsService.messengerKey,
      title: 'Productos App',
      initialRoute: CheckAuthScreen.routerName,
      routes: {
        HomeScreen.routerName:(_) => const HomeScreen() ,
        LoginScreen.routerName: (_) => const LoginScreen(),
        ProductScreen.routerName: (_) => const ProductScreen(),
        RegisterScreen.routerName: (_) => const RegisterScreen(),
        CheckAuthScreen.routerName: (_) => const CheckAuthScreen(),
      },
    );
  }
}