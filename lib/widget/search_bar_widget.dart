import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:recipe_keep_project/widget/recipe_card_widget.dart';
import '../model/recipe.dart';
import '../pages/recipe_detail_page.dart';

class searchBar extends SearchDelegate {
  late List<Recipe> recipes;
  bool searchByTitle = true;

  searchBar(this.recipes);

  Widget buildNotes(recipeList) => StaggeredGridView.countBuilder(
    padding: EdgeInsets.all(8),
    itemCount: recipeList.length,
    staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    itemBuilder: (context, index) {
      final recipe = recipeList[index];

      return GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RecipeDetailPage(recipeId: recipe.id!),
          ));
        },
        child: RecipeCardWidget(recipe: recipe, index: index),
      );
    },
  );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      PopupMenuButton(
        initialValue: searchByTitle,
        onSelected: (bool value) {
          searchByTitle = value;
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<bool>>[
        const PopupMenuItem(
          value: true,
          child: Text('Search by Title'),
        ),
        const PopupMenuItem(
          value: false,
          child: Text('Search by Tags'),
        ),
      ],
        icon: const Icon(Icons.keyboard_control),
      ),
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Recipe> matchQuery = [];
    for (var recipe in recipes) {
      if (searchByTitle) {
        if (recipe.title.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(recipe);
        }
      }
      else {
        if(recipe.tags.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(recipe);
        }
      }
    }

    return buildNotes(matchQuery);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Recipe> matchQuery = [];
    for (var recipe in recipes) {
      if (searchByTitle) {
        if (recipe.title.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(recipe);
        }
      }
      else {
        if(recipe.tags.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(recipe);
        }
      }
    }

    return buildNotes(matchQuery);
  }

}