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
}
