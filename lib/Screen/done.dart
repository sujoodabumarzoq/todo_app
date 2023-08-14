import 'package:flutter/material.dart';

class Done extends StatefulWidget {
  const Done({Key? key}) : super(key: key);

  @override
  _DoneState createState() => _DoneState();
}
 int Number = 0;
class _DoneState extends State<Done> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(onTap: (){
            setState(() {
              Number ++ ;

            });
          },child: Text("+",style: TextStyle(fontSize: 50),)),
          SizedBox(
            width: 20,
          ),
          Text("$Number",style: TextStyle(fontSize: 50),),
          SizedBox(
            width: 20,
          ),
    GestureDetector(onTap: (){
      setState(() {
        Number--;

      });    },child: Text("-",style: TextStyle(fontSize: 50),),)
        ],
      ),
    );
  }
}
