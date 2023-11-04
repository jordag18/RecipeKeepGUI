import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../model/recipe.dart';
import '../pages/recipe_detail_page.dart';

class buildNotes extends StatelessWidget {
  late List<Recipe> recipes;

  buildNotes(this.recipes, {super.key});


  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(8),
      itemCount: recipes.length,
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        final recipe = recipes[index];

        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RecipeDetailPage(recipeId: recipe.id!),
            ));

            //refreshRecipes();
          },
          //child: RecipeCardWidget(recipe: recipe, index: index),
        );
      },
    );
  }
}