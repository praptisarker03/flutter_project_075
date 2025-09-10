import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/splash_page.dart';
import 'models/recipe.dart';
import 'auth/sign_in_page.dart';
import 'auth/sign_up_page.dart';
import 'pages/home_page.dart';
import 'recipe/recipe_form.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(RecipeAdapter());
  await Supabase.initialize(
    url: 'https://emqnbvdticsqnoctkzjq.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVtcW5idmR0aWNzcW5vY3RrempxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY5OTg3ODksImV4cCI6MjA3MjU3NDc4OX0.dt1AfjCmf_FnUp1vBvaD5QIbOcQGyKre-O9Mvb4_AEI',
  );
  runApp(const EasyDeshiRecipesApp());
}

class EasyDeshiRecipesApp extends StatelessWidget {
  const EasyDeshiRecipesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Deshi Recipes',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
      routes: {
        '/auth': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
  '/recipe_form': (context) => const RecipeForm(),
      },
    );
  }
}



