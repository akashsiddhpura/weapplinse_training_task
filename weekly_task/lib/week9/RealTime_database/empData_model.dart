class Employee {
  final String emp_name;
  final String emp_mobileNo;
  final String emp_designation;
  final String emp_salary;
  final String emp_email;

  const Employee(
      {required this.emp_name,
      required this.emp_designation,
      required this.emp_mobileNo,
      required this.emp_salary,
      required this.emp_email});

  factory Employee.fromMap(Map<dynamic, dynamic> map) {
    return Employee(
      emp_name: map['emp_name'] ?? '',
      emp_mobileNo: map['emp_mobile'] ?? '',
      emp_designation: map['emp_designation'] ?? '',
      emp_salary: map['emp_salary'] ?? '',
      emp_email: map['emp_email'] ?? '',
    );
  }
}
