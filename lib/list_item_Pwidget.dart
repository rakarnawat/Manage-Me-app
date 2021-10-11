import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/user.dart';
import 'list_item.dart';
import 'user_sheets_api.dart';
//import 'list_items.dart';
//import 'attendance.dart';

class ListItemWidget extends StatefulWidget {
  final ListItem item;
  final Animation<double> animation;
  final VoidCallback? onClicked;
  final VoidCallback onChanged;

  const ListItemWidget({
    required this.item,
    required this.animation,
    required this.onClicked,
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<ListItemWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  bool checkBoxValue = false;
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

        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 0.0, 8.0, 10.0),
          leading: Icon(Icons.attach_money),
          title: Text(
            widget.item.title,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          trailing: InkWell(
            child: Container(
              child: const Icon(Icons.delete, color: Colors.red, size: 25),
              //margin: const EdgeInsets.fromLTRB(10.0,5.5,5.0,2.0),
              //padding: const EdgeInsets.all(35.0),
              width: 55.0,
              height: 55.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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
