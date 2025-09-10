import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../recipe/recipe_form.dart';
import '../recipe/recipe_repository.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import '../auth/sign_in_page.dart';
import 'category_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, List<Recipe>> categorizedRecipes = {};

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    final recipes = await RecipeRepository().getRecipes();
    setState(() {
      categorizedRecipes = {};
      for (var recipe in recipes) {
        categorizedRecipes.putIfAbsent(recipe.category, () => []);
        categorizedRecipes[recipe.category]!.add(recipe);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy Deshi Recipes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SignInPage()),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFF8F5F2),
        child: categorizedRecipes.isEmpty
            ? const Center(child: Text("No recipes yet!"))
            : GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 0.85,
                children: categorizedRecipes.entries.map((entry) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryPage(
                            categoryId: 0,
                            categoryName: entry.key,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      color: Colors.white,
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade200,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                            ),
                            width: double.infinity,
                            child: Text(entry.key,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF7C4700))),
                          ),
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: entry.value
                                  .map((recipe) => RecipeCard(
                                        recipe: recipe,
                                        onDelete: fetchRecipes,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RecipeForm(),
            ),
          ).then((_) => fetchRecipes());
        },
        label: const Text("Add New Recipe"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}