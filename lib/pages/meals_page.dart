import 'package:flutter/material.dart';
import '../utils/api_service.dart';
import '../models/meal.dart';

class MealsPage extends StatelessWidget {
  final String category;

  MealsPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals in $category'),
      ),
      body: FutureBuilder<List<Meal>>(
        future: ApiService.fetchMeals(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final meals = snapshot.data!;
            return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return ListTile(
                  leading: Image.network(meal.strMealThumb),
                  title: Text(meal.strMeal),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/mealDetail',
                      arguments: meal.idMeal,
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
