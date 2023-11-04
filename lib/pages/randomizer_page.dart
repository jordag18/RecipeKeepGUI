import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:recipe_keep_project/pages/recipe_detail_page.dart';
import '../model/Utility.dart';
import '../model/recipe.dart';

class RandomizerPage extends StatefulWidget {
  final List<Recipe> recipes;


  const RandomizerPage({
    Key? key,
    required this.recipes,
  }) : super(key: key);
  @override
  _RandomizerPageState createState() => _RandomizerPageState();
}

class _RandomizerPageState extends State<RandomizerPage> {
  StreamController<int> selected = StreamController<int>();
  late List itemList;
  bool rolled = false;
  late Recipe chosenRecipe;


  buildList(List<Recipe> recipes){
    var tempList = [];
    for(var recipe in recipes){
      tempList.add(recipe.title);
    }
    return tempList;
  }

  @override
  void initState() {
    super.initState();
    itemList = buildList(widget.recipes);
  }
  

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  ChosenRecipeDetails() {
    return
    Column(
      children: [
        SizedBox(
          height: 250,
          width: 250,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(child: Utility.imageFromBase64String(chosenRecipe.photo_name)),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
              fixedSize: const Size.fromHeight(40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 5,
              shadowColor: Colors.black),
          onPressed: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RecipeDetailPage(recipeId: chosenRecipe.id!),
            ));
          },
          child: Text(
            "Go to ${chosenRecipe.title}",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Randomizer'),
      ),
      body: GestureDetector(
        onTap: () {
          int value = Fortune.randomInt(0, widget.recipes.length);
          setState(
                () => selected.add(value),
          );
          chosenRecipe = widget.recipes[value];
          rolled = true;
        },
        child: Column(
          children: [
            Expanded(
              child: FortuneWheel(
                indicators: const [FortuneIndicator(
                    alignment: Alignment.topCenter,
                    child: TriangleIndicator(color: Colors.purpleAccent,)
                )
                ],
                animateFirst: false,
                duration: const Duration(milliseconds: 500),
                selected: selected.stream,
                items: [
                  for (var recipe in widget.recipes)
                    FortuneItem(child: Text(recipe.title),
                        style: FortuneItemStyle(
                          color: Colors.purple,
                          borderColor: Colors.purpleAccent.shade100,
                          borderWidth: 3,
                        )
                    ),
                ],
              ),
            ),
            if (rolled)
              ChosenRecipeDetails(),
          ],
        ),
      ),
    );
  }
}
