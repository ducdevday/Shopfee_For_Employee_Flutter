enum EmployeeStatus {
  ACTIVE,
  INACTIVE;

  String toJson() => name;

  static EmployeeStatus fromJson(String json) => values.byName(json);
}
