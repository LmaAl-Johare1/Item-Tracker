class Category {
  final String name;
  final String? imagePath;

  Category({required this.name, this.imagePath});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] ?? 'Unnamed Category',
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imagePath': imagePath,
    };
  }
}


