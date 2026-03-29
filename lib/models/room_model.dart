class Room {
  final String id;
  final String name;
  final int capacity;

  Room({required this.id, required this.name, required this.capacity});

  @override
  String toString() {
    return 'Room{id: $id, name: $name, capacity: $capacity}';
  }
}