/// Model representing theme information
class ThemeInfo {
  final String id;
  final String name;
  final String localizationKey;
  final String description;

  const ThemeInfo({
    required this.id,
    required this.name,
    required this.localizationKey,
    this.description = '',
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ThemeInfo && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'ThemeInfo(id: $id, name: $name)';
}
