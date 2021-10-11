import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
//import 'package:untitled/list_items.dart';
import 'package:untitled/payment.dart';
import 'package:untitled/pie_chart_sections.dart';
import 'package:untitled/user.dart';
//import 'Attendance2.dart';
import 'palette.dart';
import 'package:untitled/attendance.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:untitled/indicators_widget.dart';
import 'user_sheets_api.dart';
import 'pay_sheet_api.dart';
//import 'user.dart';
import 'package:http/http.dart';
//import 'package:gsheets/gsheets.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await expenseManagerSheetApi.init();
  await expenseManagerSheetApi1.init();

  runApp(
       const MaterialApp(home: MyApp()));
}

@override
class MyApp extends StatefulWidget {
  final User?user;
  const MyApp({
        Key? key,
    this.user,
      }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TextEditingController _totalempsController;
  late TextEditingController _totalmpsalaryController;
  late TextEditingController _totalincomeController;
  User?user;
  @override
  void initState(){
    super.initState();

    getusers();
    initusers();
  }
  @override
  void didUpdateWidget(covariant MyApp oldWidget){
    super.didUpdateWidget(oldWidget);
    initusers();
  }
  void initusers(){
    final totalEmployees = widget.user == null ? 0 : widget.user!.totalEmployees;
   // final totalEmployees = widget.user!.totalEmployees ?? 0;
    final totalempsalary = widget.user == null ? 0 : widget.user!.totalempsalary;
    final Emp1RSalary = widget.user == null ? 0 : widget.user!.Emp1RSalary;

    _totalempsController = TextEditingController(text: totalEmployees.toString());
    _totalmpsalaryController = TextEditingController(text: totalempsalary.toString());
  }
  Future getusers() async{
   final user = await expenseManagerSheetApi.getByID(9999999);
   //print(user!.toJson());
   //print(user.totalEmployees);
   //print(user.Emp2RSalary);
   //print(user.Emp1RSalary);

   setState((){
     this.user = user;
   });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    user:user;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MaterialApp(
        title: 'Manage Me',
        theme: ThemeData(
          primarySwatch: Palette.kToDark,
        ),
        home: DefaultTabController(
          length: 2,
          child:  Scaffold(
            primary: true,
            backgroundColor: Colors.black,
            appBar: AppBar(
              elevation: 1,
              bottom: TabBar(
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Creates border
                    //color: Colors.grey.shade900
                ),
                tabs: const [
                  Tab(icon: Icon(Icons.account_balance_wallet_rounded)),
                  //Tab(icon: Icon(Icons.receipt_long_rounded)),
                  Tab(icon: Icon(Icons.account_balance)),
                ],
              ),

              title: Row(
                mainAxisAlignment : MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("images/sh2.png", width: 50, height:30),
                  const Text("Shelubazar", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  const Text(" Urban ", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            body:  TabBarView(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            color: Colors.black,
                            child: Column(
                              children : [
                                InkWell(
                                    child: Column(
                                    children: [
                                      Container(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(20),
                                                child: const Image(
                                                  image: AssetImage("images/growth.png"),
                                              ),),
                                              const Padding(padding: EdgeInsets.fromLTRB(5, 5, 10, 5),),
                                              //ClipRRect(
                                                //borderRadius: BorderRadius.circular(20),
                                                //child: const Image(
                                                  //image: AssetImage("images/account.png"),
                                                  //fit: BoxFit.cover,
                                                //),),
                                              //const Padding(padding: EdgeInsets.fromLTRB(5, 5, 10, 5),),
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(20),
                                                child: const Image(
                                                  image: AssetImage("images/bk1.png"),
                                                  fit: BoxFit.cover,
                                                ),),
                                              const Padding(padding: EdgeInsets.fromLTRB(5, 5, 10, 5),),
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(20),
                                                child: const Image(
                                                  image: AssetImage("images/bk3.png"),
                                                  fit: BoxFit.cover,
                                                ),),
                                              const Padding(padding: EdgeInsets.fromLTRB(5, 5, 10, 5),),
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(20),
                                                child: const Image(
                                                  image: AssetImage("images/bk2.png"),
                                                  fit: BoxFit.cover,
                                                ),),
                                            ],
                                          ),
                                        ),
                                        margin: const EdgeInsets.fromLTRB(10.0,5.0,10.0,5.0),
                                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                        width: width * 0.95,
                                        height : height * 0.21,
                                        decoration: BoxDecoration(
                                          borderRadius : BorderRadius.circular(20),
                                          shape: BoxShape.rectangle,
                                          //color: Colors.grey.shade100,
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[

                                              Container(
                                                child: Column(children: [
                                                  const Text("\nDays/Months \n Elapsed",style:
                                                  TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                    textAlign: TextAlign.center,),
                                                  const Padding(padding: EdgeInsets.all(5),),
                                                  Text("${user?.totaldaysElapsed.toString()}",style:
                                                  const TextStyle(fontWeight: FontWeight.bold,
                                                      fontSize: 22, color: Colors.cyan),
                                                  )],),
                                                margin: const EdgeInsets.fromLTRB(10.0,5.0,10.0,5.0),
                                                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                                width: width * 0.45,
                                                height : height * 0.2,
                                                decoration: BoxDecoration(
                                                  borderRadius : BorderRadius.circular(20),
                                                  shape: BoxShape.rectangle,
                                                  color: Colors.grey.shade100,
                                                ),),
                                              Column(
                                                children: [
                                                Container(
                                                  child: Column(children: [
                                                    const Text("Aditya Absent",style:
                                                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                      textAlign: TextAlign.center,),
                                                    const Padding(padding: EdgeInsets.all(5),),
                                                    Text("${user?.daysemp1Absent.toString()} days",style:
                                                    const TextStyle(fontWeight: FontWeight.bold,
                                                        fontSize: 22, color: Colors.cyan),
                                                    )],),
                                                  margin: const EdgeInsets.fromLTRB(5.0,5.0,10.0,5.0),
                                                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                                  width: width * 0.45,
                                                  height: height * 0.09,
                                                  decoration: BoxDecoration(
                                                    borderRadius : BorderRadius.circular(20),
                                                    shape: BoxShape.rectangle,
                                                    color: Colors.grey.shade100,
                                                  ),),
                                                  Container(
                                                    child: Column(children: [
                                                      const Text("Rama Absent",style:
                                                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                        textAlign: TextAlign.center,),
                                                      const Padding(padding: EdgeInsets.all(5),),
                                                      Text("${user?.daysemp2Absent.toString()} Days",style:
                                                      const TextStyle(fontWeight: FontWeight.bold,
                                                          fontSize: 22, color: Colors.cyan),
                                                      )],),
                                                    margin: const EdgeInsets.fromLTRB(5.0,5.0,10.0,5.0),
                                                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                                    width: width * 0.45,
                                                    height: height * 0.09,
                                                    decoration: BoxDecoration(
                                                      borderRadius : BorderRadius.circular(20),
                                                      shape: BoxShape.rectangle,
                                                      color: Colors.grey.shade100,
                                                    ),
                                                  )
                                                ],
                                                ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Column(children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(10.0,5.0,10.0,5.0),
                                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                              child: Column(children: [
                                                const Text("Total Employees",style:
                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                  textAlign: TextAlign.center,),
                                              const Padding(padding: EdgeInsets.all(5),),
                                              Text("${user?.totalEmployees.toString()}",style:
                                              const TextStyle(fontWeight: FontWeight.bold,
                                                  fontSize: 22, color: Colors.cyan),
                                                )],),
                                              width: width * 0.45,
                                              height : height * 0.09,
                                              decoration: BoxDecoration(
                                                borderRadius : BorderRadius.circular(20),
                                                shape: BoxShape.rectangle,
                                                color: Colors.grey.shade100,
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(10.0,5.0,10.0,5.0),
                                              padding: const EdgeInsets.all(5),
                                              child: Column(children: [
                                                const Text("Total Earnings",style:
                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                  textAlign: TextAlign.center,),
                                                const Padding(padding: EdgeInsets.all(5),),
                                                Text("${user?.MyIncomeTotal}",style:
                                                    const TextStyle(fontWeight: FontWeight.bold,
                                                    fontSize: 22, color: Colors.cyan),),
                                              ],),
                                              width: width * 0.45,
                                              height : height * 0.09,
                                              decoration: BoxDecoration(
                                                borderRadius : BorderRadius.circular(20),
                                                shape: BoxShape.rectangle,
                                                color: Colors.grey.shade100,
                                              ),
                                            ),
                                          ],),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(5.0,5.0,10.0,5.0),
                                            padding: const EdgeInsets.all(5),
                                            child: Column(children: [
                                              const Text("\nTotal \n Employees"
                                                  "\n Salary",style:
                                              TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                textAlign: TextAlign.center,),
                                              const Padding(padding: EdgeInsets.all(5),),
                                              Text("${user?.totalempsalary.toString()}rs.",style:
                                              const TextStyle(fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Colors.cyan
                                              ),
                                            textAlign: TextAlign.center,),
                                            ],),
                                            width: width * 0.45,
                                            height : height * 0.2,
                                            decoration: BoxDecoration(
                                              borderRadius : BorderRadius.circular(20),
                                              shape: BoxShape.rectangle,
                                              color: Colors.grey.shade100,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),


                                  /*child: Container(
                                    width: width * 0.95,
                                    height: height * 0.695,
                                    child : Image.asset("images/sh2.png"),
                                    //const Text("", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.black),),
                                    decoration: BoxDecoration(
                                      borderRadius : BorderRadius.circular(20),
                                      shape: BoxShape.rectangle,
                                      //color: Colors.black,
                                    ),

                                    //alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.fromLTRB(10.0,10.0,10.0,5.0),
                                    padding: const EdgeInsets.all(35.0),),
                                  onTap: (){
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          MyApp2(onTap: () {  },),)
                                    );
                                  },*/
                                ),
                                InkWell(
                                  child: Container(
                                    width: width * 0.95,
                                    height: height * 0.05,
                                    child : const Text("App License",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 22, color: Colors.black,
                                      fontWeight: FontWeight.bold),),
                                    decoration: BoxDecoration(
                                      borderRadius : BorderRadius.circular(20),
                                      shape: BoxShape.rectangle,
                                      gradient:  const LinearGradient(
                                          colors: [
                                            //Colors.grey.shade100,
                                            Colors.white,
                                            //Color(0xff8921aa),
                                            Colors.orange,
                                            //Colors.green,
                                          ]),
                                      //color: Colors.lightBlueAccent.shade400,
                                    ),

                                    //alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.fromLTRB(10.0,10.0,10.0,5.0),
                                    padding: const EdgeInsets.all(5.0),),
                                  onTap: (){
                                    showAboutDialog(context: context,
                                        applicationName: "Manage Me",
                                        applicationVersion: "vs0.1",
                                    children: [const Text("Click on view license to get "
                                        "Application License!", textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 18),)]);
                                  },
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      child: Container(
                                        width: width * 0.449,
                                        height: height * 0.05,
                                        child : const Text("Attendance",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 22, color: Colors.black,
                                          fontWeight: FontWeight.bold),),
                                        decoration: BoxDecoration(
                                          borderRadius : BorderRadius.circular(20),
                                          shape: BoxShape.rectangle,
                                          gradient: const LinearGradient(
                                              colors: [
                                                //Colors.red.shade400,
                                                Colors.white,
                                                //Color(0xff8921aa),
                                                Colors.orange,
                                               // Colors.purple,
                                              ]),
                                          //color: Colors.grey.shade500,
                                        ),
                                        //alignment: Alignment.topLeft,
                                        margin: const EdgeInsets.fromLTRB(10.0,10.0,10.0,5.0),
                                        padding: const EdgeInsets.all(5.0),),
                                      onTap: (){
                                        Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => const MyApp3()),);
                                      },
                                    ),
                                    InkWell(
                                      child: Container(
                                        width: width * 0.449,
                                        height: height * 0.05,
                                        child : const Text("Payment",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 22, color: Colors.black,
                                              fontWeight: FontWeight.bold),),
                                        decoration: BoxDecoration(
                                          borderRadius : BorderRadius.circular(20),
                                          shape: BoxShape.rectangle,
                                          gradient: const LinearGradient(
                                              colors: [
                                                //Colors.lightBlueAccent,
                                                Colors.white,
                                                //Color(0xff8921aa),
                                                Colors.orange,
                                               // Colors.green,
                                              ]),
                                          //color: Colors.lightBlueAccent.shade400,
                                        ),

                                        //alignment: Alignment.topLeft,
                                        margin: const EdgeInsets.fromLTRB(10.0,10.0,10.0,5.0),
                                        padding: const EdgeInsets.all(5.0),),
                                      onTap: ()async{
                                        Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => payment(onTap: () {  },)),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //ImageIcon(AssetImage("images/sh.png"), color: Colors.blue,),

                  Container(
                    margin: const EdgeInsets.fromLTRB(10.0,10.0,10.0,5.0),
                    padding: const EdgeInsets.all(10.0),
                      child: Column(
                      children: [
                        Row(
                          children: [
                            const Padding(padding: EdgeInsets.all(10),),
                            Image.asset("images/sh2.png", width: 100, height:100),
                            const Padding(padding: EdgeInsets.all(10),),
                            const Text("SHELUBAZAR\nURBAN",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 32
                            ),)
                          ],
                        ),
                        Text("\nAddress",style: TextStyle(
                            fontSize: 22,
                            color: Colors.orange.shade300
                        ),
                          textAlign: TextAlign.left,),
                        const Text( "Malegaon Road, Shelubazar, Washim,"
                            " Maharashtra, 444402, INDIA",style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                        ),
                          textAlign: TextAlign.center,),
                        Text("\nContact No:",style: TextStyle(
                            fontSize: 22,
                            color: Colors.orange.shade300,
                        ),
                          textAlign: TextAlign.center,),
                        const Text(" +91 9111777882",style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                        ),
                          textAlign: TextAlign.center,),
                        Text("\nEmail:",style: TextStyle(
                            fontSize: 22,
                            color: Colors.orange.shade300,
                        ),
                          textAlign: TextAlign.center,),
                        const Text("shelunidhi@gmail.com",style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                        ),
                          textAlign: TextAlign.center,),
                        Text("\nCIN: ",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.orange.shade300
                        ),
                        ),
                            const Text("U65990MH2020PLN347682\n",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        ),
                        textAlign: TextAlign.center,),
                        Row(
                          children: [
                            const Padding(padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),),
                            SizedBox(
                              width: width * 0.35,
                              height: height * 0.17 ,
                              child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: const Image(
                                image: AssetImage("images/subdetails.png"),
                                fit: BoxFit.cover,
                              ),),),
                            const Padding(padding: EdgeInsets.all(10),),
                            const Text("Scan to get \nall details",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 24
                              ),)
                          ],
                        ),
                      ],
                  ),
                    decoration: BoxDecoration(
                      borderRadius : BorderRadius.circular(20),
                      shape: BoxShape.rectangle,
                      gradient: const LinearGradient(
                          colors: [
                            //Colors.lightBlueAccent,
                            Colors.black,
                            //Color(0xff8921aa),
                            Colors.black38,
                            // Colors.green,
                          ]),
                      //color: Colors.lightBlueAccent.shade400,
                    ),
                  ),

                ]
            ),

            //home: const MyHomePage(title: 'Flutter Demo Home Page'),
          ),

        )

    );
  }
}

