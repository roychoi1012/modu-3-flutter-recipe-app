import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipe_app/data/model/recipe_model.dart';

part 'recipe_state.freezed.dart';
part 'recipe_state.g.dart';

@freezed
class RecipeState with _$RecipeState {
  const factory RecipeState({
    @Default([]) List<Recipe> allRecipes,
    @Default([]) List<Recipe> filteredRecipes,
    @Default('') String searchQuery,
    @Default(false) bool isLoading,
  }) = _RecipeState;

  factory RecipeState.fromJson(Map<String, dynamic> json) =>
      _$RecipeStateFromJson(json);
}
