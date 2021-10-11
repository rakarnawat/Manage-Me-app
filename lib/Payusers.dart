import 'dart:convert';

class PayFields{
  static final String id = 'Employee Id';
  static final String name = 'Employee Name';
  static final String payment = 'Amount Paid';
  static final String attendanceDate = 'Date';
  static final String salary = 'Salary';
  static final String remainingPayment = 'Remaining Salary';
  static final String payReason = 'Pay Reason';
  static final String myincomeSource = 'My Income Source';
  static final String myincome = 'My Income';
  static final String Emp1RSalary = "Emp1RSalary";
  static final String Emp2RSalary = "Emp2RSalary";
  static final String MyIncomeTotal = "My Income Total";

  static List<String> getFields() => [
    id, name, payment, attendanceDate, salary, remainingPayment, payReason,myincomeSource, myincome];
}

class User{
  final int? id;
  final String name;
  final int? payment;
  final String attendanceDate;
  final int? salary;
  final int? remainingPayment;
  final String payReason;
  final String myincomeSource;
  final int? myincome;
  final int? Emp1RSalary;
  final int? Emp2RSalary;
  final int? MyIncomeTotal;

  const User({
    this.id,
    required this.name,
    this.payment,
    required this.attendanceDate,
    this.salary,
    this.remainingPayment,
    required this.payReason,
    required this.myincomeSource,
    this.myincome,
    this.Emp1RSalary,
    this.Emp2RSalary,
    this.MyIncomeTotal,
  });

static User fromJson(Map<String, dynamic> json) => User(
    id: jsonDecode(json[PayFields.id]),
    name: json[PayFields.name],
    attendanceDate: json[PayFields.attendanceDate],
    payReason: json[PayFields.payReason],
    myincomeSource: json[PayFields.myincomeSource],
    myincome: jsonDecode(json[PayFields.myincome]),
  Emp1RSalary: jsonDecode(json[PayFields.Emp1RSalary]),
  Emp2RSalary: jsonDecode(json[PayFields.Emp2RSalary]),
  MyIncomeTotal: jsonDecode(json[PayFields.MyIncomeTotal]),
);
  Map<String, dynamic> toJson() =>
      {
        PayFields.id: id,
        PayFields.name: name,
        PayFields.payment: payment,
        PayFields.attendanceDate: attendanceDate,
        PayFields.salary:7000,
        PayFields.remainingPayment: remainingPayment,
        PayFields.payReason: payReason,
        PayFields.myincomeSource: myincomeSource,
        PayFields.myincome: myincome,
        PayFields.Emp1RSalary : Emp1RSalary,
        PayFields.Emp2RSalary: Emp2RSalary,
        PayFields.MyIncomeTotal: MyIncomeTotal,
      };
}