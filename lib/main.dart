import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'package:visiting_card_generator/screens/queue_page.dart';
import 'package:visiting_card_generator/screens/test_page.dart';
import 'package:visiting_card_generator/screens/print_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: HomePage(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/test': (context) => const TestPage(),
          '/queue': (context) => const QueuePage(),
          // '/Print': (context) => const _printCard(),
        }
    );
  }
}
