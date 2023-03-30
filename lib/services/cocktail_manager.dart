import 'package:my_cocktail/services/ingredient.dart';

class CocktailManager {
  String name;
  String category;
  String alcoholic;
  String glassType;
  String pictureUrl;
  String instructions;
  List<Ingredient> ingredients;

  CocktailManager(
      {this.name,
      this.category,
      this.alcoholic,
      this.glassType,
      this.pictureUrl,
      this.instructions,
      this.ingredients});
}
