import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/recipe.dart';

class RecipeRepository {
  final supabase = Supabase.instance.client;

  Future<List<Recipe>> getRecipes() async {
    final response = await supabase.from('recipes').select();

    return (response as List)
  .map((data) => Recipe.fromMap(data as Map<String, dynamic>))
        .toList();
  }

  Future<void> addRecipe(Recipe recipe) async {
    await supabase.from('recipes').insert({
      'title': recipe.title,
      'description': recipe.description,
      'category': recipe.category,
      'image_url': recipe.imageUrl,
    });
  }

  Future<void> deleteRecipe(int id) async {
    await supabase.from('recipes').delete().eq('id', id);
  }
}
