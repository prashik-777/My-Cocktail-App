import 'package:flutter/material.dart';
import 'package:my_cocktail/constants.dart';
import 'package:my_cocktail/services/ingredient.dart';
import 'package:my_cocktail/ui_components/ingredient_widget.dart';
import 'package:my_cocktail/ui_components/instruction_widget.dart';

class ResultWindow extends StatelessWidget {
  final String name;
  final String category;
  final String alcoholic;
  final String glassType;
  final String pictureUrl;
  final String instructions;
  final List<Ingredient> ingredients;

  ResultWindow({
    @required this.name,
    @required this.category,
    @required this.alcoholic,
    @required this.glassType,
    @required this.pictureUrl,
    @required this.instructions,
    @required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Cocktail Name
            Center(
              child: Text(
                name,
                style: kHeaderTextStyle,
              ),
            ),

            //Cocktail Details
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 40,
              decoration: BoxDecoration(
                color: kGroupBackgroundColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(category),
                  Text('-'),
                  Text(alcoholic),
                  Text('-'),
                  Text(glassType),
                ],
              ),
            ),

            //Cocktail Image
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(pictureUrl),
                ),
              ),
            ),

            //Cocktail Ingredients
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 200,
              decoration: kBoxDecorationStyle,
              child: IngredientWidget(
                ingredientList: ingredients,
              ),
            ),

            //Cocktail Instructions
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 200,
              decoration: kBoxDecorationStyle,
              child: InstructionWidget(
                instructions: instructions,
              ),
            ),

            //Return Button
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Return"),
                style: ElevatedButton.styleFrom(
                    primary: kComponentColor,
                    minimumSize: kButtonMinSize,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
