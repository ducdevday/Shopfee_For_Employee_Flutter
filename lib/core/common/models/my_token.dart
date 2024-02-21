class MyToken {
  final String employeeId;
  final String accessToken;
  final String refreshToken;

  const MyToken({
    required this.employeeId,
    required this.accessToken,
    required this.refreshToken,
  });

  factory MyToken.fromJson(Map<String, dynamic> json) {
    return MyToken(
      employeeId: json["employeeId"],
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "employeeId": this.employeeId,
      "accessToken": this.accessToken,
      "refreshToken": this.refreshToken,
    };
  }
}
