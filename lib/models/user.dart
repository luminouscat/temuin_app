class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.userType,
    required this.accessToken,
  });

  // Parse from api
  final int id;
  final String name;
  final String email;
  final String userType;
  final String accessToken;
  factory User.fromJson(Map<String, dynamic> json) {
    final userData = json['user'] ?? json;
    return User(
      id: userData['id'] ?? 0,
      name: userData['name'] ?? 'Unknown',
      email: userData['email'] ?? '',
      userType: userData['user_type'] ?? 'Unknown',
      accessToken: json['access_token'] ?? '',
    );
  }

  // convert to JSON
  Map<String, dynamic> toJson() => {
    'user': {'id': id, 'name': name, 'email': email, 'user_type': userType},
    'access_token': accessToken,
  };

  // getters
  bool get isInfluencer => userType == "influencer";
  bool get isCompany => userType == "company";
  String get token => accessToken;
}
