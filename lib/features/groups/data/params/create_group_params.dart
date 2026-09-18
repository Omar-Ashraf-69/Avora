class CreateGroupParams {
  const CreateGroupParams({
    required this.name,
    required this.memberIds,
    this.description,
    this.avatarUrl,
  });

  final String name;
  final String? description;
  final String? avatarUrl;
  final List<String> memberIds;
}