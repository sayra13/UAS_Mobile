// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:resep/models/recipe.api.dart';
import 'package:resep/models/recipe.dart';
import 'package:resep/views/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Recipe> _recipes;

  void iniState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10),
              Text('Food Recipes'),
            ],
          ),
        ),
        body: FutureBuilder(
          future: RecipeApi.getRecipe(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              _recipes = snapshot.data;
              return ListView.builder(
                  itemCount: _recipes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: RecipeCard(
                          title: _recipes[index].name,
                          cookTime: _recipes[index].totalTime,
                          rating: _recipes[index].rating.toString(),
                          thumbnailUrl: _recipes[index].images),
                      onTap: () {},
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
