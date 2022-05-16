import 'package:flutter/material.dart';

class WidgetItem extends StatelessWidget {
  
  final String name;
  final String img;

  const WidgetItem({
    Key? key,
    required this.name,
    required this.img
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.width * 0.1,
      margin: const EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.orange,
        ),
        color: Colors.indigoAccent,
        borderRadius: const BorderRadius.all(
          Radius.circular(20)
        )
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Image(
              image: AssetImage(img),
              width: 50.0,
              height: 50.0
            )
          ),
          const Expanded(
            child: Text("jajajaja")
          )
        ],
      )
    );
  }
}