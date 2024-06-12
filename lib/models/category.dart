/// A class representing a Category with a name and an optional image path.
class Category {
  /// The name of the category.
  final String name;

  /// The optional image path of the category.
  final String? imagePath;

  /// Constructs a Category instance.
  ///
  /// The [name] parameter is required and represents the name of the category.
  /// The [imagePath] parameter is optional and represents the path to the category's image.
  Category({required this.name, this.imagePath});

  /// Creates a Category instance from a JSON object.
  ///
  /// The [json] parameter should be a Map<String, dynamic> containing the category data.
  /// Returns a Category instance with the data from the JSON object.
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] ?? 'Unnamed Category',
      imagePath: json['imagePath'],
    );
  }

  /// Converts the Category instance to a JSON object.
  ///
  /// Returns a Map<String, dynamic> representing the category data.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imagePath': imagePath,
    };
  }
}
