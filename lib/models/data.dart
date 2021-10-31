class Data {
  final int candidateNumber;
  final String candidateTitle;
  final String candidateName;
  final int score;

  Data({
    required this.candidateNumber,
    required this.candidateTitle,
    required this.candidateName,
    required this.score,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      candidateNumber: json['candidateNumber'],
      candidateTitle: json['candidateTitle'],
      candidateName: json['candidateName'],
      score: json['score'],
    );
  }
}