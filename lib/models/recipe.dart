import 'package:hive/hive.dart';
part 'recipe.g.dart';

@HiveType(typeId: 0)
class Recipe {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final String? imageUrl; 

  Recipe({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    this.imageUrl,
    
  });

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] as int?,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      imageUrl: map['image_url'] as String?,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id, 
      'title': title,
      'description': description,
      'category': category,
      'image_url': imageUrl,
    };
  }
}
