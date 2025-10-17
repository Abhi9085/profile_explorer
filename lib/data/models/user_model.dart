class UserModel {
  final String name;
  final String imageUrl;
  final int age;
  final String city;
  final String country;
  bool isLiked;

  UserModel({
    required this.name,
    required this.imageUrl,
    required this.age,
    required this.city,
    required this.country,
    this.isLiked = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name']['first'],
      imageUrl: json['picture']['large'],
      age: json['dob']['age'],
      city: json['location']['city'],
      country: json['location']['country'],
    );
  }
}
