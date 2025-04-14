import 'package:flutter/material.dart';
import 'package:recipe_app/data/data_source/recipe_data_source_impl.dart';
import 'package:recipe_app/data/repository/recipe_repository_impl.dart';
import 'package:recipe_app/presentation/component/pages/recipe/saved_recipes_view_model.dart';
import 'package:recipe_app/presentation/component/pages/search/search_recipes_screen.dart';
import 'package:recipe_app/ui/color_style.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // viewModel을 한 번 생성
    final viewModel = SavedRecipesViewModel(
      RecipeRepositoryImpl(RecipeDataSourceImpl()),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorStyle.mainGreen,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SearchRecipesScreen(viewModel: viewModel),
              ),
            );
          },
          child: const Text(
            '레시피 검색하기',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
