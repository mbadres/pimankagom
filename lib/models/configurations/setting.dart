class Setting {
  final String id;
  final String name;
  final String description;
  final String category;
  final String currentValue;
  final String defaultValue;
  final List<String> availableValues;

  Setting({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.currentValue,
    required this.defaultValue,
    required this.availableValues,
  });

  Setting copyWith({String? value}) {
    return Setting(
      id: id,
      name: name,
      description: description,
      category: category,
      currentValue: value ?? currentValue,
      defaultValue: defaultValue,
      availableValues: availableValues,
    );
  }
}
