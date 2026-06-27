class Text {
  final String value;
  final List<int> strongWordsIndices;
  final List<int> emphasizedWordsIndices;
  final String status;

  const Text({
    required this.value,
    required this.strongWordsIndices,
    required this.emphasizedWordsIndices,
    required this.status,
  });

  factory Text.fromJson(Map<String, dynamic> json) {
    return Text(
      value: json['value'] as String,
      strongWordsIndices: (json['strongWordsIndices'] as List).cast<int>(),
      emphasizedWordsIndices: (json['emphasizedWordsIndices'] as List).cast<int>(),
      status: json['status'] as String,
    );
  }
}
