import 'package:flutter/foundation.dart';
import 'package:recipe_app/data/repository/recipe_data_source.dart';
import 'package:recipe_app/presentation/recipe/recipe_state.dart';

class SavedRecipesViewModel with ChangeNotifier {
  final RecipeRepository _repository;

  RecipeState _state = const RecipeState(isLoading: true);
  RecipeState get state => _state;

  SavedRecipesViewModel(this._repository) {
    _loadAllRecipes();
  }

  Future<void> _loadAllRecipes() async {
    try {
      final all = await _repository.getRecipes();
      _updateState(_state.copyWith(
        allRecipes: all,
        filteredRecipes: all,
        isLoading: false,
      ));
    } catch (_) {
      _updateState(_state.copyWith(isLoading: false));
    }
  }

  void updateQuery(String query) {
    final filtered = _state.allRecipes.where((recipe) {
      return recipe.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    _updateState(_state.copyWith(
      searchQuery: query,
      filteredRecipes: filtered,
    ));
  }

  void _updateState(RecipeState newState) {
    _state = newState;
    notifyListeners();
  }
}
