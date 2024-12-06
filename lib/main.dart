import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/login_page.dart';
import 'pages/categories_page.dart';
import 'pages/meals_page.dart';
import 'pages/meal_detail_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MealDB App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return snapshot.data! ? Home() : LoginPage();
          }
        },
      ),
      routes: {
        '/categories': (context) => CategoriesPage(username: ModalRoute.of(context)!.settings.arguments as String),
        '/meals': (context) => MealsPage(category: ModalRoute.of(context)!.settings.arguments as String),
        '/mealDetail': (context) => MealDetailPage(idMeal: ModalRoute.of(context)!.settings.arguments as String),
      },
    );
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            final username = prefs.getString('username')!;
            Navigator.pushReplacementNamed(context, '/categories', arguments: username);
          },
          child: Text('Go to Categories'),
        ),
      ),
    );
  }
}
