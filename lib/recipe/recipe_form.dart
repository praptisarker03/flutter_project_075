import 'package:flutter/material.dart';
import '../models/recipe.dart';
import 'recipe_repository.dart';

class RecipeForm extends StatefulWidget {
  const RecipeForm({super.key});

  @override
  State<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final imageController = TextEditingController();

  Future<void> saveRecipe() async {
    final recipe = Recipe(
      id: 0,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      category: categoryController.text.trim(),
      imageUrl: imageController.text.trim(),
    );

    await RecipeRepository().addRecipe(recipe);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Recipe")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: "Category"),
            ),
            TextField(
              controller: imageController,
              decoration:
                  const InputDecoration(labelText: "Image URL (optional)"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveRecipe,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
