class Category {
  final String name;
  final String imageUrl;

  Category({required this.name, required this.imageUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] as String? ?? 'No Category',  // Fallback to 'No Category' if 'name' is null
      imageUrl: json['imageUrl'] as String? ?? 'assets/img/defualt.png',  // Ensure the path is spelled correctly
    );
  }
}


