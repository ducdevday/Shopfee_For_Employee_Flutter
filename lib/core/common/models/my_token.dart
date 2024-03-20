class MyToken {
  final String employeeId;
  final String accessToken;

  const MyToken({
    required this.employeeId,
    required this.accessToken,
  });

  factory MyToken.fromJson(Map<String, dynamic> json) {
    return MyToken(
      employeeId: json["employeeId"],
      accessToken: json["accessToken"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "employeeId": this.employeeId,
      "accessToken": this.accessToken,
    };
  }
}
