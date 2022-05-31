class User {
  final int id;
  final String name;
  final String imageUrl;

  User({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  @override
  String toString(){
    return 'User: {name: ${name}, imageUrl: ${imageUrl}, id: ${id}}';
  }
}