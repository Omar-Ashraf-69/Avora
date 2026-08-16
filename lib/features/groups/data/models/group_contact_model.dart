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
    GroupContact(id: '1', name: 'Andrew', imageUrl: ''),
    GroupContact(id: '2', name: 'Sarah', imageUrl: ''),
    GroupContact(id: '3', name: 'John', imageUrl: ''),
    GroupContact(id: '4', name: 'Emma', imageUrl: ''),
    GroupContact(id: '5', name: 'Michael', imageUrl: ''),
    GroupContact(id: '6', name: 'Sophia', imageUrl: ''),
    GroupContact(id: '7', name: 'David', imageUrl: ''),
    GroupContact(id: '8', name: 'Olivia', imageUrl: ''),
  ];