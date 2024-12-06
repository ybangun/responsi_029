import 'package:flutter/material.dart';
import '../utils/api_service.dart';
import '../models/meal_detail.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailPage extends StatelessWidget {
  final String idMeal;

  MealDetailPage({required this.idMeal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Detail'),
      ),
      body: FutureBuilder<MealDetail>(
        future: ApiService.fetchMealDetail(idMeal),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final mealDetail = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(mealDetail.strMealThumb),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(mealDetail.strMeal, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Category: ${mealDetail.strCategory}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Area: ${mealDetail.strArea}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Instructions: ${mealDetail.strInstructions}'),
                  ),
                  ElevatedButton(
                  onPressed: () async {
                    final Uri url = Uri.parse(mealDetail.strYoutube);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Text('Watch Tutorial'),
),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
