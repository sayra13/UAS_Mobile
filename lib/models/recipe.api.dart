import 'dart:convert';
import 'package:resep/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
// const req = unirest('GET', 'https://yummly2.p.rapidapi.com/feeds/list');

// req.query({
// 	limit: '24',
// 	start: '0'
// });

// req.headers({
// 	'X-RapidAPI-Key': '44cec715c1mshf3d5f12d2d4d0fcp1d1683jsn11fd0ce8f6e2',
// 	'X-RapidAPI-Host': 'yummly2.p.rapidapi.com'
// });

  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "18", "start": "0", "tag": "list.recipe.popular"});

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "44cec715c1mshf3d5f12d2d4d0fcp1d1683jsn11fd0ce8f6e2",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }

    print(_temp);
    return Recipe.recipesFromSnapshot(_temp);
  }
}
