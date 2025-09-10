import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../recipe/recipe_repository.dart';


class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback? onDelete;

  const RecipeCard({super.key, required this.recipe, this.onDelete});

  @override
  Widget build(BuildContext context) {
  return Card(
      child: Card(
        margin: const EdgeInsets.all(8),
        child: SizedBox(
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              recipe.imageUrl != null && recipe.imageUrl!.isNotEmpty
                  ? Image.network(
                      recipe.imageUrl!,
                      height: 120,
                      width: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 120,
                          width: 180,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.broken_image, size: 40),
                        );
                      },
                    )
                  : Container(
                      height: 120,
                      width: 180,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.fastfood, size: 50),
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(recipe.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(recipe.description,
                    maxLines: 2, overflow: TextOverflow.ellipsis),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Delete Recipe"),
                        content: const Text(
                            "Are you sure you want to delete this recipe?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text("No"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            child: const Text("Yes"),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      await RecipeRepository().deleteRecipe(recipe.id ?? 0);
                      onDelete?.call(); 
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
