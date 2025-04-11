import 'package:flutter/material.dart';
import 'package:recipe_app/presentation/home/saved_recipes_view_model.dart';

class RecipeScreen extends StatelessWidget {
  final SavedRecipesViewModel viewModel;

  const RecipeScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Recipes')),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          final recipes = viewModel.recipes;

          if (recipes.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return ListTile(
                leading: Image.network(
                  recipe.image,
                  width: 50,
                  height: 50,
                  errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                ),
                title: Text(recipe.name),
                subtitle: Text('${recipe.chef} • ${recipe.time}'),
              );
            },
          );
        },
      ),
    );
  }
}