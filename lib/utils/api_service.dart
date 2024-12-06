import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:responsi_029/models/category.dart';
import 'package:responsi_029/models/meal.dart';
import 'package:responsi_029/models/meal_detail.dart';


class ApiService {
  static Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return (data['categories'] as List).map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<List<Meal>> fetchMeals(String category) async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=$category'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return (data['meals'] as List).map((json) => Meal.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }

  static Future<MealDetail> fetchMealDetail(String idMeal) async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$idMeal'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return MealDetail.fromJson(data['meals'][0]);
    } else {
      throw Exception('Failed to load meal detail');
    }
  }
}
