class CreateProfileModel {
  final String username;
  final String name;
  final String phoneNumber;
  final String email;
  final String? about;
  final String? avatarUrl;

  const CreateProfileModel({
    required this.username,
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.about,
    this.avatarUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
      'phone_number': phoneNumber,
      'email': email,
      'about': about,
      'avatar_url': avatarUrl,
    };
  }
}