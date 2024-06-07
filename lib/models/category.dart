class Category {
  final String name;
  final String imagePath;

  Category({required this.name, required this.imagePath});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      imagePath: json['imagePath'],
    );
  }
}
