import 'dart:convert';

class UserFields{
  static final String id = 'Employee Id';
  static final String name = 'Employee Name';
  static final String salaryDate = 'Salary Date';
  static final String payment = 'Salary of Employees';
  static final String empAttendance = 'Attendance';
  static final String attendanceDate = 'Attendance Date';
  static final String EmpPresentPercent = "Emp Present Percent";
  static final String EmpAbsentPercent = "Emp Absent Percent";
  static final String totalEmployees = "Total Employees";
  static final String totalempsalary = "Total Emp Salary";
  static final String totaldaysElapsed = "Days Elapsed";
  static final String Emp1RSalary = "Emp1RSalary";
  static final String Emp2RSalary = "Emp2RSalary";
  static final String MyIncomeTotal = "My Income Total";
  static final String daysemp1Absent = "Total Days AD Absent";
  static final String daysemp2Absent = "Total Days RM Absent";
  //static final String sTotal = "STotal";

  static List<String> getFields() => [
    id, name, salaryDate, payment,empAttendance, attendanceDate,
  EmpPresentPercent,EmpAbsentPercent,totalEmployees,totalempsalary,
    totaldaysElapsed, Emp1RSalary,Emp2RSalary, MyIncomeTotal,
    daysemp1Absent,daysemp2Absent,
    //sTotal
 ];
}
class User{
  final int? id;
  final String name;
  final int? payment;
  final bool empAttendance;
  final String attendanceDate;
  final int? EmpPresentPercent;
  final int? EmpAbsentPercent;
  final int? totalEmployees;
  final int? totalempsalary;
  final int? totaldaysElapsed;
  final int? Emp1RSalary;
  final int? Emp2RSalary;
  final int? MyIncomeTotal;
  final int? daysemp1Absent;
  final int? daysemp2Absent;
  //final int? stotal;

  const User({
    this.id,
    required this.name,
    this.payment,
    required this.empAttendance,
    required this.attendanceDate,
    this.EmpPresentPercent,
    this.EmpAbsentPercent,
    this.totalEmployees,
    this.totalempsalary,
    this.totaldaysElapsed,
    this.Emp1RSalary,
    this.Emp2RSalary,
    this.MyIncomeTotal,
    this.daysemp1Absent,
    this.daysemp2Absent,
    //this.stotal,
});

  static User fromJson(Map<String, dynamic> json) => User(
    id: jsonDecode(json[UserFields.id]),
    name: json[UserFields.name],
    payment: jsonDecode(json[UserFields.payment]),
    attendanceDate: json[UserFields.attendanceDate],
    empAttendance: jsonDecode(json[UserFields.empAttendance]),
    EmpPresentPercent: jsonDecode(json[UserFields.EmpPresentPercent]),
    EmpAbsentPercent: jsonDecode(json[UserFields.EmpAbsentPercent]),
    totalEmployees: jsonDecode(json[UserFields.totalEmployees]),
    totalempsalary: jsonDecode(json[UserFields.totalempsalary]),
    totaldaysElapsed: jsonDecode(json[UserFields.totaldaysElapsed]),
    Emp1RSalary: jsonDecode(json[UserFields.Emp1RSalary]),
    Emp2RSalary: jsonDecode(json[UserFields.Emp2RSalary]),
    MyIncomeTotal: jsonDecode(json[UserFields.MyIncomeTotal]),
    daysemp1Absent: jsonDecode(json[UserFields.daysemp1Absent]),
    daysemp2Absent: jsonDecode(json[UserFields.daysemp2Absent]),
    //stotal: jsonDecode(json[UserFields.sTotal]),
  );

  Map<String, dynamic> toJson()=>{
    UserFields.id : id,
    UserFields.name: name,
    UserFields.payment: payment,
    //UserFields.empAttendance: empAttendance,
    //UserFields.attendanceDate: attendanceDate,
    UserFields.EmpPresentPercent: EmpPresentPercent,
    UserFields.EmpAbsentPercent: EmpAbsentPercent,
    UserFields.totalEmployees: totalEmployees,
    UserFields.totalempsalary: totalempsalary,
    UserFields.totaldaysElapsed: totaldaysElapsed,
    UserFields.Emp1RSalary : Emp1RSalary,
    UserFields.Emp2RSalary: Emp2RSalary,
    UserFields.MyIncomeTotal: MyIncomeTotal,
    UserFields.daysemp1Absent: daysemp1Absent,
    UserFields.daysemp2Absent: daysemp2Absent,
  };
}
