class Item {
  final int candidateNumber;
  final String candidateTitle;
  final String candidateName;

  Item({
    required this.candidateNumber,
    required this.candidateTitle,
    required this.candidateName,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      candidateNumber: json['candidateNumber'],
      candidateTitle: json['candidateTitle'],
      candidateName: json['candidateName'],
    );
  }
}
