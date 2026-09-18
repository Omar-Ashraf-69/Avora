class GroupContact {
  const GroupContact({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String imageUrl;
}

final List<GroupContact> contacts = const [
  GroupContact(
    id: 'de5498fe-388f-437c-a605-55758fdc171e',
    name: 'Mora',
    imageUrl: '',
  ),
  GroupContact(
    id: 'cb9f8f12-5191-41c0-9ae6-b33c9ec91945',
    name: 'O',
    imageUrl: '',
  ),
  GroupContact(
    id: 'e1cf95bb-49c1-47b3-94e4-231a6bac715f',
    name: 'A',
    imageUrl: '',
  ),
  GroupContact(id: '4', name: 'Emma', imageUrl: ''),
  GroupContact(id: '5', name: 'Michael', imageUrl: ''),
  GroupContact(id: '6', name: 'Sophia', imageUrl: ''),
  GroupContact(id: '7', name: 'David', imageUrl: ''),
  GroupContact(id: '8', name: 'Olivia', imageUrl: ''),
];
