class MyToken {
  final String employeeId;
  final String accessToken;
  final String branchId;

  const MyToken({
    required this.employeeId,
    required this.accessToken,
    required this.branchId
  });

  factory MyToken.fromJson(Map<String, dynamic> json) {
    return MyToken(
      employeeId: json["employeeId"],
      accessToken: json["accessToken"],
      branchId: json["branchId"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "employeeId": this.employeeId,
      "accessToken": this.accessToken,
      "branchId": this.branchId
    };
  }
}
