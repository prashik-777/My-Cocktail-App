import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_cocktail/constants.dart';
import 'package:my_cocktail/services/cocktail_manager.dart';
import 'package:http/http.dart';
import 'package:my_cocktail/services/ingredient.dart';
import 'package:my_cocktail/ui_windows/result_window.dart';

class SearchWindow extends StatefulWidget {
  @override
  _SearchWindow createState() => _SearchWindow();
}

class _SearchWindow extends State<SearchWindow> {
  String cocktailName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 200),
              // Logo Text
              Center(
                child: Text(
                  "Cocktails",
                  style: TextStyle(fontSize: 70),
                ),
              ),

              SizedBox(height: 100),

              // Text Input
              TextField(
                onChanged: (value) {
                  cocktailName = value;
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  hintText: "Name a Cocktail?",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: kBorderSide,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: kBorderSide,
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Search Button
              ElevatedButton(
                onPressed: () async {
                  if (cocktailName == null) return;

                  cocktailName.toLowerCase().replaceAll(' ', '_');

                  CocktailManager cm = CocktailManager();

                  var network = await get(Uri.parse(kMainUrl + cocktailName));

                  var json = jsonDecode(network.body);

                  cm.name = json['drinks'][0]['strDrink'];
                  cm.alcoholic = json['drinks'][0]['strAlcoholic'];
                  cm.glassType = json['drinks'][0]['strGlass'];
                  cm.pictureUrl = json['drinks'][0]['strDrinkThumb'];
                  cm.category = json['drinks'][0]['strCategory'];
                  cm.instructions = json['drinks'][0]['strInstructions'];

                  String strIngredientName, strIngredientMeasure;
                  List<Ingredient> ingrdientList = [];

                  for (int i = 1; i < 16; i++) {
                    strIngredientName = 'strIngredient' + i.toString();
                    strIngredientMeasure = 'strMeasure' + i.toString();

                    ingrdientList.add(
                      Ingredient(
                        name: json['drinks'][0][strIngredientName],
                        mesure: json['drinks'][0][strIngredientMeasure],
                      ),
                    );
                  }

                  ingrdientList.removeWhere((element) =>
                      element.name == null && element.mesure == null);

                  ingrdientList.forEach((element) {
                    if (element.mesure == null) {
                      element.mesure = ' ';
                    }
                  });

                  cm.ingredients = ingrdientList;

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ResultWindow(
                          name: cm.name,
                          category: cm.category,
                          alcoholic: cm.alcoholic,
                          glassType: cm.glassType,
                          pictureUrl: cm.pictureUrl,
                          instructions: cm.instructions,
                          ingredients: cm.ingredients);
                    }),
                  );
                },
                child: Text("Search"),
                style: ElevatedButton.styleFrom(
                  primary: kComponentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: kButtonMinSize,
                ),
              ),

              SizedBox(height: 20),

              // Random Button
              ElevatedButton(
                onPressed: () async {
                  CocktailManager cm = CocktailManager();

                  var network = await get(Uri.parse(kRandomUrl));

                  var json = jsonDecode(network.body);

                  cm.name = json['drinks'][0]['strDrink'];
                  cm.alcoholic = json['drinks'][0]['strAlcoholic'];
                  cm.glassType = json['drinks'][0]['strGlass'];
                  cm.pictureUrl = json['drinks'][0]['strDrinkThumb'];
                  cm.category = json['drinks'][0]['strCategory'];
                  cm.instructions = json['drinks'][0]['strInstructions'];

                  String strIngredientName, strIngredientMeasure;
                  List<Ingredient> ingrdientList = [];

                  for (int i = 1; i < 16; i++) {
                    strIngredientName = 'strIngredient' + i.toString();
                    strIngredientMeasure = 'strMeasure' + i.toString();

                    ingrdientList.add(
                      Ingredient(
                        name: json['drinks'][0][strIngredientName],
                        mesure: json['drinks'][0][strIngredientMeasure],
                      ),
                    );
                  }

                  ingrdientList.removeWhere((element) =>
                      element.name == null && element.mesure == null);

                  ingrdientList.forEach((element) {
                    if (element.mesure == null) {
                      element.mesure = ' ';
                    }
                  });

                  cm.ingredients = ingrdientList;

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ResultWindow(
                          name: cm.name,
                          category: cm.category,
                          alcoholic: cm.alcoholic,
                          glassType: cm.glassType,
                          pictureUrl: cm.pictureUrl,
                          instructions: cm.instructions,
                          ingredients: cm.ingredients);
                    }),
                  );
                },
                child: Text("Random"),
                style: ElevatedButton.styleFrom(
                  primary: kComponentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: kButtonMinSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
