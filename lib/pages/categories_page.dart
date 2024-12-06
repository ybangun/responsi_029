import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/category.dart' as my_category; 
import '../utils/api_service.dart';

class CategoriesPage extends StatefulWidget {
  final String username;

  CategoriesPage({required this.username});

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late Future<List<my_category.Category>> _categoriesFuture; // Use the alias here

  @override
  void initState() {
    super.initState();
    _categoriesFuture = ApiService.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${widget.username}'),
      ),
      body: FutureBuilder<List<my_category.Category>>( // Use the alias here
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final categories = snapshot.data!;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return ListTile(
                  leading: Image.network(category.strCategoryThumb),
                  title: Text(category.strCategory),
                  subtitle: Text(category.strCategoryDescription),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/meals',
                      arguments: category.strCategory,
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