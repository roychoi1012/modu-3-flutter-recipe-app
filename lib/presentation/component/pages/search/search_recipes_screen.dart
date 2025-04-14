import 'package:flutter/material.dart';
import 'package:recipe_app/presentation/component/pages/recipe/saved_recipes_view_model.dart';
import 'package:recipe_app/presentation/component/widgets/recipe_card.dart';
import 'package:recipe_app/presentation/component/widgets/text_field_widget.dart';
import 'package:recipe_app/ui/app_text_styles.dart';
import 'package:recipe_app/ui/color_style.dart';

class SearchRecipesScreen extends StatefulWidget {
  final SavedRecipesViewModel viewModel;

  const SearchRecipesScreen({super.key, required this.viewModel});

  @override
  State<SearchRecipesScreen> createState() => _SearchRecipesScreenState();
}

class _SearchRecipesScreenState extends State<SearchRecipesScreen> {
  late final SavedRecipesViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search recipe',
          style: AppTextStyles.mediumBold(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final state = viewModel.state;

          return Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                // 검색 입력 + 필터 버튼
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        hintText: 'Search recipe',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: ColorStyle.gray4,
                        ),
                        onChanged: viewModel.updateQuery,
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: GestureDetector(
                        onTap: () {
                          print('필터 버튼 클릭됨');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorStyle.mainGreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.tune, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // 로딩 / 결과 / 레시피 카드
                if (state.isLoading)
                  const Expanded(child: Center(child: CircularProgressIndicator()))
                else if (state.filteredRecipes.isEmpty)
                  const Expanded(child: Center(child: Text("레시피가 없습니다.")))
                else
                  Expanded(
                    child: GridView.builder(
                      itemCount: state.filteredRecipes.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        final recipe = state.filteredRecipes[index];
                        return RecipeCard(
                          recipeName: recipe.name,
                          chefName: recipe.chef,
                          recipeImgUrl: recipe.image,
                          recipeRating: recipe.rating ?? 4.0,
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
