import 'dart:async';
import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'main.dart';
import 'palette.dart';
import 'list_items.dart';
import 'list_item.dart';
//import 'list_item_Pwidget.dart';
import 'list_item_widget.dart';
import 'pay_sheet_api.dart';
import 'Payusers.dart';
//import 'package:untitled/pie_chart_sections.dart';
//import 'attendance.dart';
//import 'package:fl_chart/fl_chart.dart';
//import 'package:untitled/indicators_widget.dart';


Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await expenseManagerSheetApi1.init();
 //runApp( MaterialApp(home: payment()));
}
class payment extends StatefulWidget {
  //const payment({Key? key}) : super(key: key);
  final User?user;
  final VoidCallback onTap;
  const payment({
    Key? key,
    this.user,
    required this.onTap,
  }) : super(key: key);

  @override
  State<payment> createState() => _paymentState();

}

class _paymentState extends State<payment> {
  User?user;
  final List<ListItem> items = List.from(listItems);
  final listKey = GlobalKey<AnimatedListState>();
  late TextEditingController _myincometotal;
//<Color>[Colors.red, Color(0xff8921aa)]
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Colors.white, Color(0xff8921aa)],).createShader(const Rect.fromLTWH(0.0, 0.0, 250.0, 70.0));
  final Shader linearGradient1 = const LinearGradient(
    colors: <Color>[Colors.black, Color(0xff8921aa)],).createShader(const Rect.fromLTWH(0.0, 0.0, 250.0, 70.0));
  bool _validate = false;
  var now1 = DateFormat("dd-MM-yyyy").format(DateTime.now());
  final TextEditingController _myincomeController = TextEditingController();
  //final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _myincomeSourceController = TextEditingController();
  final TextEditingController _payreasonController = TextEditingController();
  final TextEditingController _payController = TextEditingController();
  @override
  void initState(){
    super.initState();
    getpayUsers();
    initUser();
  }
  Future getpayUsers() async{
    final user = await expenseManagerSheetApi1.getByID(999999);
    print(user!.toJson());
    print(user.myincome);
    setState((){
      this.user = user;
    }
    );
  }
  @override
  void didUpdateWidget(covariant payment oldWidget){
    super.didUpdateWidget(oldWidget);
  initUser();
  }
  void initUser() async{
    final myincometotal = await widget.user == null ? 0 : widget.user!.myincome;
    setState((){
      _myincometotal = TextEditingController(text: myincometotal.toString());
    }
    );

  }
  @override
  Widget build(BuildContext context) {
    print("this is items.lenth : ${items.length}");
    print("this is listitems.lenth : ${listItems.length}");
    var i = 0;
    final double barWidth = 45;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final double? em1r = user?.Emp1RSalary?.toDouble();
    final double? em2r = user?.Emp2RSalary?.toDouble();
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
            ],),),
        body: SingleChildScrollView(
          child: Column(
                //mainAxisAlignment : MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  //margin: const EdgeInsets.fromLTRB(10.0,0.0,0.0,0.0),
                  padding: const EdgeInsets.fromLTRB(0.0,2.0,0.0,10.0),
                  child: Text("PAYMENT",textAlign: TextAlign.left,
                    style: TextStyle(fontSize : 35, fontWeight: FontWeight.bold,
                        fontFamily: 'StickNoBills-Bold',
                        foreground: Paint()..shader = linearGradient ),),
                ),],
            ),
            FutureBuilder(
              builder: (context, snapshot){
                if(em1r !=null){
                  return Container(
                    width: width * 0.90,
                    height: height * 0.2,
                    margin: const EdgeInsets.fromLTRB(5.0, 10.0, 2.0, 5.0),
                    padding: const EdgeInsets.fromLTRB(10.0,15.0,10.0,15.0),
                    child:
                    BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceEvenly,
                        maxY: 10000,
                        minY:0,
                        groupsSpace: 12,
                        barTouchData: BarTouchData(enabled: true),
                        barGroups: BarData.barData.map((data) =>
                            BarChartGroupData(
                                x: data.id,
                                barsSpace: 50,
                                barRods: [BarChartRodData(
                                  y: em1r!.toDouble(),
                                  width: barWidth,
                                  colors: [Colors.blue.shade400],
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                  ),
                                ),
                                  BarChartRodData(
                                    y: em2r!.toDouble(),
                                    width: barWidth,
                                    colors: [Colors.redAccent.shade400],
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6),
                                    ),
                                  ),]
                            )).toList(),
                      ),
                    ),

                    decoration : BoxDecoration(
                        borderRadius : BorderRadius.circular(14),
                        shape: BoxShape.rectangle,
                        gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade100,
                              Colors.white70,
                            ]
                        )
                      //color: Colors.grey.shade400,
                    ),
                  );
                }
                return const CircularProgressIndicator(color: Colors.white70);
                },
            ),
            Container(
              width: width * 0.90,
              height: height * 0.05,
              margin: const EdgeInsets.fromLTRB(5.0, 10.0, 2.0, 5.0),
              padding: const EdgeInsets.fromLTRB(10.0,5.0,10.0,5.0),
              child: Text("My Total Income : ${user?.myincome}rs",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              decoration : BoxDecoration(
                  borderRadius : BorderRadius.circular(14),
                  shape: BoxShape.rectangle,
                  gradient: LinearGradient(
                      colors: [
                        Colors.orange.shade400,
                        Colors.white,
                      ]
                  )
                //color: Colors.grey.shade400,
              ),
              //),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10.0,5.5,2.5,2.0),
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              width: width * 0.90,
              height: height * 0.15,
              alignment: Alignment.topLeft,
                child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  const Padding(padding: EdgeInsets.fromLTRB(20.0,5.0,5.0,5.0),),
                  const Text("Remaining Payment", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),textAlign: TextAlign.left,
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(20.0,5.0,5.0,5.0),),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text("1. ${listItems.elementAt(0).title} : ${user?.Emp1RSalary}rs",
                    style:  const TextStyle(
                        fontSize: 18,
                        //fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.left,
                  ),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const Padding(padding: EdgeInsets.fromLTRB(20.0,5.0,5.0,5.0),),
                      Text("2. ${listItems.elementAt(1).title} : ${user?.Emp2RSalary}rs",
                        style:  const TextStyle(
                            fontSize: 18,
                            //fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],),
                  ],),
                ]),
                decoration: BoxDecoration(
                    borderRadius : BorderRadius.circular(20),
                    shape: BoxShape.rectangle,
                    gradient: LinearGradient(
                        colors: [
                          Colors.grey.shade100,
                          Colors.white70,
                        ]
                    )
                  //color: Colors.grey.shade300,
                ),
              ),
            /*Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Card(
                       elevation: 10,
                       color: Colors.black,
                       shadowColor: Colors.grey.shade800,
                       child: Container(
                         child:Column(children: [
                         Text("${listItems.elementAt(0).title} "
                             , style:  const TextStyle(
                           fontSize: 18,
                         fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                          const Text("Remaining Payment", style: TextStyle(
                           fontSize: 16,
                         ),textAlign: TextAlign.center,),
                           const Padding(padding: EdgeInsets.all(2),),
                           Text("${user?.Emp1RSalary}rs", style: const TextStyle(
                             fontSize: 20, fontWeight: FontWeight.bold,
                           ),),
                         ]),
                           margin: const EdgeInsets.fromLTRB(10.0,5.5,2.5,2.0),
                         padding: const EdgeInsets.fromLTRB(5, 15, 15, 5),
                         width: width * 0.435,
                         height: height * 0.15,
                         decoration: BoxDecoration(
                           borderRadius : BorderRadius.circular(20),
                           shape: BoxShape.rectangle,
                           gradient: LinearGradient(
                             colors: [
                               Colors.grey.shade100,
                               Colors.white70,

                             ]
                           )
                           //color: Colors.grey.shade300,
                         ),
                       ),
                     ),

                     Card(
                       elevation: 10,
                       color: Colors.black,
                       shadowColor: Colors.grey.shade800,
                       child: Container(
                         child:Column(children: [
                           Text("${listItems.elementAt(1).title} "
                             , style:  const TextStyle(
                                 fontSize: 18,
                                 fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                           const Text("Remaining Payment", style: TextStyle(
                             fontSize: 16,
                           ),textAlign: TextAlign.center),
                           const Padding(padding: EdgeInsets.all(2),),
                           Text("${user?.Emp2RSalary}rs", style: const TextStyle(
                             fontSize: 20, fontWeight: FontWeight.bold,
                           ),),
                         ]),
                         margin: const EdgeInsets.fromLTRB(2.5,5.5,5.0,2.0),
                         padding: const EdgeInsets.fromLTRB(5, 15, 15, 5),
                         width: width * 0.435,
                         height: height * 0.15,
                         decoration: BoxDecoration(
                             borderRadius : BorderRadius.circular(20),
                             shape: BoxShape.rectangle,
                             gradient: LinearGradient(
                                 colors: [
                                   Colors.grey.shade100,
                                   Colors.white70,
                                 ]
                             )
                           //color: Colors.grey.shade300,
                         ),
                       ),
                     ),
                   ],
                 ),*/
                 SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                   child:
                      Column(children: <Widget>[
                        const Padding(padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),),
                        SizedBox(
                          width : width * 0.95,
                          height: height * 0.25,
                          child:
                              /*GridView.count(crossAxisCount: 2,
                                  children:[
                                    for (i=0; i < listItems.length;  i++)
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(10.0,5.5,5.0,2.0),
                                        width: width * 0.15,
                                        height: height * 0.15,
                                        child: Center(child: Text(listItems.elementAt(i).title,)),
                                        decoration: BoxDecoration(
                                          borderRadius : BorderRadius.circular(20),
                                          shape: BoxShape.rectangle,
                                          color: Colors.grey.shade400,
                                          /*gradient: const LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            stops: [0.1, 0.5, 0.7, 0.9],
                                            colors: [
                                              Colors.grey,
                                              Colors.grey,
                                              Colors.white60,
                                              Colors.grey,
                                            ],
                                          ),*/
                                        ),
                                      ),],
                              ),*/

                            GridView.builder(
                              itemCount: listItems.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                                itemBuilder: (ctx, index){
                                return InkWell(
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(10.0,5.5,5.0,2.0),
                                    width: width * 0.15,
                                    height: height * 0.15,
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                      //const Icon(Icons.account_circle_outlined, size: 20,),
                                      const Padding(padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),),
                                      Text(listItems.elementAt(index).title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                        fontSize: 22, //fontFamily: 'StickNoBills-Bold',
                                        foreground: Paint()..shader = linearGradient1,
                                    ),),]
                                    ),
                                    decoration: BoxDecoration(
                                    borderRadius : BorderRadius.circular(20),
                                    shape: BoxShape.rectangle,
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Colors.grey.shade400
                                      ]
                                    ),
                                    //color: Colors.grey.shade100,
                                  ),),
                                  onTap: (){
                                    showAlertDialog(context, index);
                                  },
                                );
                            },),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                              InkWell(
                                  child: Container(
                                    child: const Center(child:Icon(Icons.home_filled)),
                                        margin: const EdgeInsets.fromLTRB(10.0,5.5,5.0,2.0),
                                        //padding: const EdgeInsets.all(35.0),
                                        width: width * 0.25,
                                        height: height * 0.05,
                                        decoration: BoxDecoration(
                                          borderRadius : BorderRadius.circular(20),
                                          shape: BoxShape.rectangle,
                                          //color: Colors.redAccent.shade100,
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.white,
                                                Colors.orange.shade400
                                              ],),
                                        ),
                                      ), onTap: () async {
                                    Navigator.pop(context,
                                      MaterialPageRoute(builder: (context) => const MyApp()),
                                    );
                                  },
                                  ),
                            InkWell(
                              child: Container(
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.values[2],
                                    children: const [
                                      Icon(Icons.attach_money_rounded),
                                      Text("Income",style: TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.bold, ),),],),
                                margin: const EdgeInsets.fromLTRB(10.0,5.5,5.0,2.0),
                                //padding: const EdgeInsets.all(35.0),
                                width: width * 0.25,
                                height: height * 0.05,
                                decoration: BoxDecoration(
                                  borderRadius : BorderRadius.circular(20),
                                  shape: BoxShape.rectangle,
                                  //color: Colors.orange,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white,
                                      Colors.orange.shade400
                                    ]
                                  )
                                ),
                              ), onTap: () async{
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    )
                                  ),
                                  context: context, builder: (context) =>  buildSheet()
                              );
                            },
                            ),
                          ]
                        )
                      ],
          ),
                 ),
          ],
          ),

        ),
      ),
    );
  }
  void removeItem(int index) {
    final removedItem = items[index];
    items.removeAt(index);
    listKey.currentState!.removeItem(
        index,
            (content, animation) => ListItemWidget(
          item: removedItem,
          animation: animation,
          onClicked: (){}, onChanged: () { },)
    );}
  void showAlertDialog(BuildContext context, index) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var salary = 7000;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        //return SingleChildScrollView(child:
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            elevation: 0.5,
            title: Column( children: <Widget>[
              Text("Pay To Employee", style: TextStyle(
                  fontSize : 40, fontWeight: FontWeight.bold,
                  fontFamily: 'StickNoBills-Bold',
                  foreground: Paint()..shader = linearGradient
              ),),
              const Padding(padding: EdgeInsets.all(2),),
              Text(listItems.elementAt(index).title,
                style: const TextStyle(
                fontSize: 32,
              ),)
            ],

            ),

            content: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 4.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:  <Widget>[
                               const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),),
                              const Text("Enter Amount",textAlign: TextAlign.left,),
                              TextField(
                                controller: _payController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.left,
                                decoration: const InputDecoration(
                                  //border: OutlineInputBorder(),
                                    hintText: 'Enter amount',
                                    suffixIcon: Icon(Icons.attach_money)
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),),
                              const Text("Enter Purpose",textAlign: TextAlign.left,),
                              TextField(
                                controller: _payreasonController,
                                //keyboardType: TextInputType.text,
                                textAlign: TextAlign.left,
                                decoration: const InputDecoration(
                                  //border: OutlineInputBorder(),
                                    hintText: 'Enter Valid Reason',
                                    suffixIcon: Icon(Icons.article_outlined)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              InkWell(
                child: Container(
                  width: width * 0.35,
                  height: height * 0.06,
                  //padding: const EdgeInsets.all(2),
                    margin: const EdgeInsets.fromLTRB(18.0, 2.0, 18.0, 18.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.archive_rounded, color: Colors.white,),
                        Text(" Pay",
                            style: TextStyle(fontSize: 24,
                            color: Colors.white),),
                      ],
                    ),
                  decoration : BoxDecoration(
                    borderRadius : BorderRadius.circular(14),
                    shape: BoxShape.rectangle,
                      gradient: LinearGradient(
                          colors: [
                            Colors.grey.shade200,
                            Colors.orange.shade400
                          ]
                      )
                    //color: Colors.lightBlueAccent,
                  )
                ),
                onTap: () async{
                  int remainingPayment = salary;
                  final user = {
                    PayFields.id: index,
                    PayFields.name: listItems.elementAt(index).title.toString(),
                    PayFields.attendanceDate: now1,
                    PayFields.payment: _payController.text,
                    PayFields.payReason: _payreasonController.text,
                    PayFields.remainingPayment: remainingPayment -= int.parse(_payController.text),
                  };
                  await expenseManagerSheetApi1.insert([user]);
                  _payController.clear();
                  _payreasonController.clear();
                },
              ),
            ],
          );
        //);
      },
    );
  }
 Widget buildSheet()  => Container(
   child: Column(children:  <Widget>[
     const Padding(padding: EdgeInsets.all(5)),
      Text("SALARY", style: TextStyle(fontSize : 40, fontWeight: FontWeight.bold,
         fontFamily: 'StickNoBills-Bold',
         foreground: Paint()..shader = linearGradient ),),
     Expanded(
         child: SizedBox(
           width: 300,
         child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.start,
         children:  <Widget>[
           const Padding(padding: EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 5.0)),
           const Text("Enter Your Income ",textAlign: TextAlign.start,style: TextStyle( fontSize: 20)),
           const Padding(padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0)),
          TextField(
            controller: _myincomeController,
            keyboardType: TextInputType.number,
           textAlign: TextAlign.start,
           decoration: InputDecoration(
             //border: OutlineInputBorder(),
               hintText: 'Enter Your Salary',
               errorText: _validate ? 'Salary Can\'t Be Empty' : null,

               suffixIcon: const Icon(Icons.attach_money_rounded)
           ),
         ),
           const Padding(padding: EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 5.0)),
           const Text("Enter Income Source",textAlign: TextAlign.start,style:
           TextStyle( fontSize: 20)),
           const Padding(padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0)),
           TextField(
             controller: _myincomeSourceController,
             //keyboardType: TextInputType.number,
             textAlign: TextAlign.start,
             decoration: InputDecoration(
               //border: OutlineInputBorder(),
                 hintText: 'Enter Source Name',
                 errorText: _validate ? ' Sourcce Name\'t Be Empty' : null,

                 suffixIcon: const Icon(Icons.person_rounded)
             ),
           ),
           Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               //Card(
               //  elevation: 10,
                 //child:
                 Container(
                 margin: const EdgeInsets.fromLTRB(5.0, 20.0, 2.0, 5.0),
                 padding: const EdgeInsets.all(10.0),
                 child: Text("Total Income \n${user?.myincome}rs",
                   textAlign: TextAlign.center,
                   style: const TextStyle(
                   fontSize: 22,
                 ),),
                 decoration : BoxDecoration(
                   borderRadius : BorderRadius.circular(14),
                   shape: BoxShape.rectangle,
                     gradient: LinearGradient(
                         colors: [
                           Colors.grey.shade100,
                           Colors.orange.shade400
                         ]
                     )
                   //color: Colors.grey.shade400,
                 ),
             //),
               ),
               InkWell(
                 child: //Card(
                   //child:
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       InkWell(
                         child: Container(
                           width: 100,
                           height: 40,
                           transformAlignment: Alignment.centerLeft,
                           margin: const EdgeInsets.fromLTRB(5.0, 20.0, 2.0, 5.0),
                           padding: const EdgeInsets.all(10.0),
                           child:
                            const Text("Submit",
                             textAlign: TextAlign.center,
                             style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 20,
                             ),),
                           decoration : BoxDecoration(
                             borderRadius : BorderRadius.circular(14),
                             shape: BoxShape.rectangle,
                               gradient: LinearGradient(
                                   colors: [
                                     Colors.grey.shade100,
                                     Colors.orange.shade400
                                   ]
                               )
                             //color: Colors.lightBlueAccent,
                           ),
                         ),
                         onTap: () async{
                           final user = {
                             PayFields.attendanceDate: now1,
                             PayFields.myincomeSource: _myincomeSourceController.text,
                             PayFields.myincome: _myincomeController.text,
                           };

                         await expenseManagerSheetApi1.insert([user]);
                         _myincomeController.clear();
                         _myincomeSourceController.clear();
                           Navigator.pop(context,
                               MaterialPageRoute(builder: (context) => const MyApp()));
                         }
                       ),
                     ],
                   ),
                 //),
               ),
             ],
           ),
          //Center(child:
         //),
         ],
         ),
         ),
     ),
   ],
   ),
 );
}

class BarData {
  static int interval = 5;
  static List<Data> barData = [
    Data(
      id : 0,
      name : listItems.elementAt(0).title,
      //y:5,
      color: Colors.blue.shade400,
    ),
  ];
}

class Data {
  final int id;
  final String name;
  //final double y;
  final Color color;

  const Data({
    required this.id,
    required this.name,
    //required this.y,
    required this.color,
  });
}

