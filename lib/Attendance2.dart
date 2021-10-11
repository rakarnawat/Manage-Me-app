import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/user.dart';
import 'package:untitled/user_sheets_api.dart';
import 'main.dart';
import 'palette.dart';
import 'package:intl/intl.dart';
import 'list_item.dart';
import 'list_items.dart';
import 'user.dart';
//import 'list_item_widget.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await expenseManagerSheetApi.init();
  //runApp(
  //   const MaterialApp(home: MyApp2()));
}
class MyApp2 extends StatefulWidget {
  final VoidCallback onTap;
  const MyApp2({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<MyApp2> createState() => _MyApp2State();

}
class ListItemWidget extends StatefulWidget {
  final ListItem item;
  final Animation<double> animation;
  final VoidCallback? onClicked;
  final VoidCallback onChanged;

  const ListItemWidget({
    required this.item,
    required this.animation,
    required this.onClicked,
    Key? key, required this.onChanged,
  }) : super(key: key);

  @override
  State<ListItemWidget> createState() => _ListItemWidgetState();
}
class _ListItemWidgetState extends State<ListItemWidget> {
  final bool empAttendance = false;
  late bool checkBoxValue;
  @override
  void initState(){
    super.initState();
    initUser();
  }
  void initUser(){
    this.checkBoxValue = false;
  }
  @override
  Widget build(BuildContext context) => SizeTransition(

    key: ValueKey(widget.item.title),
    sizeFactor: widget.animation,
    child: buildItem(),
  );

  Widget buildItem() => Container(

    //width: 50,
    //height: 60,
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
    ),
    child:  ListTile(
      contentPadding: const EdgeInsets.fromLTRB(20.0, 0.0, 8.0, 10.0),
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
        activeColor: Colors.white,
        checkColor: Colors.black,
      ),

      //const CircleAvatar(
      //radius: 15,
      //backgroundImage: AssetImage('images/sh2.png'),
      // ),
      title: Text(
        widget.item.title,
        textAlign: TextAlign.start,
        style: const TextStyle(fontSize: 20, color: Colors.black,),
      ),
      trailing: InkWell(
        child: Container(
          child: const Icon(Icons.delete, color: Colors.red, size: 25),
          //margin: const EdgeInsets.fromLTRB(10.0,5.5,5.0,2.0),
          //padding: const EdgeInsets.all(35.0),
          width:  55.0,
          height: 55.0,
          decoration: BoxDecoration(
            borderRadius : BorderRadius.circular(20),
            shape: BoxShape.rectangle,
            //color: Colors.redAccent.shade100,
          ),
        ),
        onTap: widget.onClicked,
      ),
      //onTap: widget.onClicked,
    ),
  );

}

class _MyApp2State extends State<MyApp2> {
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

  final checkBoxValue = false;


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
            ],), ),
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment : MainAxisAlignment.start,
            children: <Widget>[
              Column(children: <Widget>[
                Text(DateFormat("dd-MM-yyyy").format(DateTime.now()),
                  style: TextStyle(fontSize : 26, fontFamily: 'Nosifer-Regular',
                      foreground: Paint()..shader = linearGradient ),

                ),
              ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    //margin: const EdgeInsets.fromLTRB(10.0,0.0,0.0,0.0),
                    padding: const EdgeInsets.fromLTRB(30.0,30.0,0.0,0.0),
                    child: const Text("   Daily Attendance",textAlign: TextAlign.left,
                      style: TextStyle(fontSize : 16, fontWeight: FontWeight.bold,color: Colors.white),),
                  ),],
              ),
              //Text(DateFormat.yMMMd().format(DateTime.now())),
              Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.fromLTRB(10.0,10.0,10.0,10.0),
                    padding: const EdgeInsets.fromLTRB(5.0,0.0,0.0,5.0),
                    width: width * 0.95,
                    height: height * 0.64,
                    decoration: BoxDecoration(
                      borderRadius : BorderRadius.circular(20),
                      shape: BoxShape.rectangle,
                      color: Colors.black,
                    ),
                    child:
                    AnimatedList(
                      key:  listKey,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      initialItemCount : items.length,
                      itemBuilder: ( context, index, animation) => ListItemWidget(
                        item : items[index],
                        animation : animation,
                        onClicked: () => removeItem(index), onChanged: () {  },
                      ),
                    ),

                  ),
                ],
              ),
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
                              color: Colors.redAccent.shade100,
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
                              child: const Center(child:Text("Submit",style: TextStyle(fontSize : 14, fontWeight: FontWeight.bold),),),
                              margin: const EdgeInsets.fromLTRB(2.0,5.0,2.0,2.0),
                              //padding: const EdgeInsets.all(35.0),
                              width: width * 0.41,
                              height: height * 0.05,
                              decoration: BoxDecoration(
                                borderRadius : BorderRadius.circular(20),
                                shape: BoxShape.rectangle,
                                color: Colors.blueAccent.shade100,
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
                              color: Colors.green.shade200,
                            ),),
                        ],
                      ),
                      onTap: (){showAlertDialog(context);
                      },
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
  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          elevation: 0.5,
          title: const Text("Add New Employee"),
          content: SizedBox(
            width: MediaQuery.of(context).size.width / 1.2,
            height: MediaQuery.of(context).size.height / 4.0,
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:  <Widget>[
                        const Text("Enter Employee Name ",textAlign: TextAlign.left,),
                        TextField(
                          controller: _nameController,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            //border: OutlineInputBorder(),
                              hintText: 'Enter Name',
                              errorText: _validate ? 'Username Can\'t Be Empty' : null,

                              suffixIcon: const Icon(Icons.person_rounded)
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),),
                        const Text("Enter Salary",textAlign: TextAlign.left,),
                        TextField(
                          controller: _numberController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.left,
                          decoration: const InputDecoration(
                            //border: OutlineInputBorder(),
                              hintText: 'Enter salary',
                              suffixIcon: Icon(Icons.attach_money)
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            FlatButton(onPressed: (){
              setState(() {
                _nameController.text.isEmpty ? _validate = true : _validate = false;
                if(_nameController.text == '' ){
                  Navigator.of(context, rootNavigator: true).pop();
                  showAlertDialog(context);
                  //print("Name field is empty");
                }else{
                  insertItem();
                  _nameController.clear();
                  _numberController.clear();
                  Navigator.of(context, rootNavigator: true).pop(MyApp2);
                  //createAlertDialog(context).then((_nameController){
                  // Scaffold.of(context).showSnackBar(
                  // SnackBar(content: Row(
                  //   children: const [
                  //     Icon(Icons.thumb_up),
                  //     SizedBox(width : 20),
                  //     Expanded(child: Text("New Employee Added")),
                  //    ],
                  // )
                  // ));

                }
              });
              //});
            },
              child: const Text("Submit",
                style:TextStyle(fontSize : 14, fontWeight: FontWeight.bold),
              ),),
          ],
        );
      },
    );
  }
  void insertItem() {
    const newIndex = 0;
    final newItem =  ListItem(
      title: _nameController.text,
      // empAttendance: false,
    );
    items.insert(newIndex, newItem);
    listKey.currentState!.insertItem(newIndex,);
    //print(_numberController.text);
  }
  void removeItem(int index) {
    final removedItem = items[index];
    items.removeAt(index);
    listKey.currentState!.removeItem(
        index,
            (content, animation) => ListItemWidget(
          item: removedItem,
          animation: animation,
          onClicked: (){}, onChanged: () {  },)
    );}

  Future insertUsers() async{
    final users = [
      User(id: 1, name: listItems.elementAt(1).title, payment: 121,empAttendance: checkBoxValue, attendanceDate: now1,),
      User(id: 2, name: listItems.elementAt(2).title, payment: 121, empAttendance: true,attendanceDate: now1, ),
      User(id: 3, name: listItems.elementAt(3).title, payment: 121, empAttendance: true,attendanceDate: now1, )
    ];
    final jsonUsers = users.map((user) => user.toJson()).toList();
    await expenseManagerSheetApi.insert(jsonUsers);
  }
}
