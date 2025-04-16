import 'package:flutter/foundation.dart';
import 'package:recipe_app/domain/entity/recipe_model.dart';
import 'package:recipe_app/domain/usecase/get_saved_recipes_usecase.dart';
import 'package:recipe_app/domain/usecase/unbookmark_recipe_usecase.dart';
import 'package:recipe_app/domain/repository/bookmark_repository.dart';
import 'package:recipe_app/presentation/screen/recipe/recipes_state.dart';
import 'package:recipe_app/presentation/screen/recipe/recipes_ui_model.dart';

class SavedRecipesViewModel with ChangeNotifier {
  final GetSavedRecipesUseCase _getSavedRecipesUseCase;
  final UnbookmarkRecipeUseCase _unbookmarkRecipeUseCase;
  final BookmarkRepository _bookmarkRepository;

  RecipesState _state = const RecipesState(isLoading: true);
  RecipesState get state => _state;

  SavedRecipesViewModel(
    this._getSavedRecipesUseCase,
    this._unbookmarkRecipeUseCase,
    this._bookmarkRepository,
  ) {
    _loadAllRecipes();
  }

  Future<void> _loadAllRecipes() async {
    try {
      final all = await _getSavedRecipesUseCase.execute();
      final bookmarkedIds = await _bookmarkRepository.getSavedRecipes();

      final uiModels = all.map((recipe) {
        final isBookmarked = bookmarkedIds.contains(recipe.id);
        return RecipeUiModel(recipe: recipe, isBookmarked: isBookmarked);
      }).toList();

      _updateState(_state.copyWith(
        allRecipes: uiModels,
        filteredRecipes: uiModels,
        isLoading: false,
      ));
    } catch (_) {
      _updateState(_state.copyWith(isLoading: false));
    }
  }

  Future<void> toggleBookmark(Recipe recipe) async {
    final isSaved = await _bookmarkRepository.isSaved(recipe.id);

    if (isSaved) {
      await _unbookmarkRecipeUseCase.execute(recipe.id);
    } else {
      await _bookmarkRepository.saveRecipe(recipe.id);
    }

    await _loadAllRecipes(); // 상태 다시 로드
  }

  void updateQuery(String query) {
    final filtered = _state.allRecipes.where((uiModel) {
      return uiModel.recipe.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    _updateState(_state.copyWith(
      searchQuery: query,
      filteredRecipes: filtered,
    ));
  }

  void _updateState(RecipesState newState) {
    _state = newState;
    notifyListeners();
  }
}
