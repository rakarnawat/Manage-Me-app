
//-------------------------------
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
//import 'package:untitled/user.dart';
import 'package:untitled/user_sheets_api.dart';
//import 'main.dart';
import 'main.dart';
import 'palette.dart';
import 'package:intl/intl.dart';
import 'list_item.dart';
import 'list_items.dart';
import 'user.dart';
//import 'user.dart';
//import 'list_item_widget.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await expenseManagerSheetApi.init();
  //runApp(
  //   const MaterialApp(home: MyApp3()));
}

class MyApp3 extends StatefulWidget {
  const MyApp3({Key? key}) : super(key: key);

  @override
  _MyApp3State createState() => _MyApp3State();
}

class _MyApp3State extends State<MyApp3> {

  final List<ListItem> items = List.from(listItems);
  final listKey = GlobalKey<AnimatedListState>();
  final TextEditingController _nameController = TextEditingController();
  var now = DateTime.now();
  var now1 = DateFormat("dd-MM-yyyy").format(DateTime.now());
  final TextEditingController _numberController = TextEditingController();
  bool _validate = false;
  var i = 0;
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Colors.red, Color(0xff8921aa)],).createShader(const Rect.fromLTWH(0.0, 0.0, 250.0, 70.0));

  late bool checkBoxValue;
  late bool checkBoxValue1 = false;

  @override
  void initState(){
    super.initState();
    initUser();
  }
  void initUser(){
    this.checkBoxValue = false;
    this.checkBoxValue1 = false;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;


    // print(DateFormat.yMMMd().format(DateTime.now()));

    return MaterialApp(
      title: 'Manage Me',
      theme: ThemeData(
        primarySwatch: Palette.kToDark,
      ),
      home: Scaffold(
        backgroundColor : Colors.black,
        appBar: AppBar(
          elevation: 0,
          title : Row(
            mainAxisAlignment : MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("images/sh2.png", width: width * 0.1 , height:height * 0.05),
              const Text(" Shelubazar", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              const Text(" Urban ", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment : MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Column(children: <Widget>[
                  Text(DateFormat("dd-MM-yyyy").format(DateTime.now()),
                    style: TextStyle(fontSize : 26, fontFamily: 'Nosifer-Regular',
                        foreground: Paint()..shader = linearGradient ),
                  ),
                  Row(children: const <Widget>[
                    Padding(padding: EdgeInsets.all(10),),
                    Text("Daily Attendance", style: TextStyle(fontSize : 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),),
                  ],
                  ),
                  SingleChildScrollView(
                    child: Container(
                      width: width * 0.95,
                      height: height * 0.7,
                      child: Column(
                        children: [
                          InkWell(
                            child: Container(
                              width: width * 0.95,
                              height: height * 0.07,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: getcolor(),//Colors.grey.shade400,
                              ),
                              child: ListTile(
                                leading: Checkbox(
                                  value: checkBoxValue,
                                  onChanged: (value) async {
                                    setState(() {
                                      checkBoxValue = value!;
                                      print(checkBoxValue);
                                      final bool empAttendance= checkBoxValue;
                                    }
                                    );
                                  },
                                  activeColor: getcolor(),//Colors.grey.shade400,
                                  checkColor: Colors.black,
                                ),
                                title: Text(listItems.elementAt(0).title,
                                  style: TextStyle(fontSize: 20),textAlign: TextAlign.start,),
                                trailing: Icon(Icons.person_rounded),
                              ),
                            ),
                            //onTap: ,
                          ),
                          InkWell(
                            child: Container(
                              width: width * 0.95,
                              height: height * 0.07,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: getcolor1(),//Colors.grey.shade400,
                              ),
                              child: ListTile(
                                leading: Checkbox(
                                  value: checkBoxValue1,
                                  onChanged: (value) async {
                                    setState(() {
                                      checkBoxValue1 = value!;
                                      print(checkBoxValue1);
                                      final bool empAttendance= checkBoxValue1;
                                    }
                                    );
                                  },
                                  activeColor: getcolor1(),//Colors.grey.shade400,
                                  checkColor: Colors.black,
                                ),
                                title: Text(listItems.elementAt(1).title,
                                  style: TextStyle(fontSize: 20),textAlign: TextAlign.start,),
                                trailing: Icon(Icons.person_rounded),
                              ),
                            ),
                            //onTap: ,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //* Second Container

                  SizedBox(
                    child: Row(
                      children: [
                        InkWell(
                          child : Column(
                            children: [
                              Container(
                                child: const Center(child:Icon(Icons.home_filled)),
                                margin: const EdgeInsets.fromLTRB(10.0,5.5,5.0,2.0),
                                //padding: const EdgeInsets.all(35.0),
                                width: width * 0.25,
                                height: height * 0.05,
                                decoration: BoxDecoration(
                                  borderRadius : BorderRadius.circular(20),
                                  shape: BoxShape.rectangle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white,
                                      Colors.orange.shade400
                                    ],),
                                  //color: Colors.redAccent.shade100,
                                ),
                              ),
                            ],
                          ),onTap: (){
                          Navigator.pop(context,
                            MaterialPageRoute(builder: (context) => const MyApp()),
                          );
                        },),
                        InkWell(
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  child: const Center(child:Text("Submit",
                                    style: TextStyle(fontSize : 18,
                                        fontWeight: FontWeight.bold),),),
                                  margin: const EdgeInsets.fromLTRB(2.0,5.0,2.0,2.0),
                                  //padding: const EdgeInsets.all(35.0),
                                  width: width * 0.41,
                                  height: height * 0.05,
                                  decoration: BoxDecoration(
                                    borderRadius : BorderRadius.circular(20),
                                    shape: BoxShape.rectangle,
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Colors.orange.shade400
                                      ],),
                                    //color: Colors.blueAccent.shade100,
                                  ),),
                              ),
                            ],
                          ),onTap: () async{
                          insertUsers();


                          //Navigator.push(context,
                          //MaterialPageRoute(builder: (context) => const MyApp()),
                          //);
                        },),
                        InkWell(
                          child: Column(
                            children: [
                              Container(
                                child: const Center(child:Icon(Icons.add),),
                                margin: const EdgeInsets.fromLTRB(5.5,5.0,10.0,2.0),
                                //padding: const EdgeInsets.all(35.0),
                                width: width * 0.25,
                                height: height * 0.05,
                                decoration: BoxDecoration(
                                  borderRadius : BorderRadius.circular(20),
                                  shape: BoxShape.rectangle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white,
                                      Colors.orange.shade400
                                    ],),
                                  //color: Colors.green.shade200,
                                ),),
                            ],
                          ),
                          onTap: (){//showAlertDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getcolor() {
    if(checkBoxValue == true){
      return Colors.green;
    }
    else{
      return Colors.grey.shade400;
    }
  }
  getcolor1() {
    if(checkBoxValue1 == true){
      return Colors.green;
    }
    else{
      return Colors.grey.shade400;
    }
  }

  Future insertUsers() async{
    final users = [
      User(id: 1, name: listItems.elementAt(0).title, payment: 7000,empAttendance: checkBoxValue, attendanceDate: now1,),
      User(id: 2, name: listItems.elementAt(1).title, payment: 10000, empAttendance: checkBoxValue1,attendanceDate: now1, ),
    ];
    final jsonUsers = users.map((user) => user.toJson()).toList();
    await expenseManagerSheetApi.insert(jsonUsers);
  }

}
