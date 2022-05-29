import 'package:apiboobs/widget/widget_item.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyCanvasApp());
}

class MyCanvasApp extends StatelessWidget {
  const MyCanvasApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api Boobs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Canvas3(),
    );
  }
}

class Canvas3 extends StatefulWidget {
  const Canvas3({Key? key}) : super(key: key);

  @override
  _Canvas3State createState() => _Canvas3State();
}

class _Canvas3State extends State<Canvas3> {
  var start_offset = ValueNotifier(Offset.zero);
  var end_offset = ValueNotifier(Offset.zero);

  var key1 = GlobalKey();
  var key2 = GlobalKey();
  var key3 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.red.shade100,
        //Create canvas
        child: CustomPaint(
          child: Column(
            children: [
              _buildItems(),
            ],
          ),
          foregroundPainter: Painter3(start_offset, end_offset),
        ),
      ),
    );
  }

  //Create content
  Row _buildItems() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Draggable is the left column
        Draggable(
          child: Container(
            key: key1,
            width: 100,
            height: 100,
            child: Image.asset('images/json.png'),
            decoration: BoxDecoration(color: Colors.pink),
          ),
          data: 1,
          //Drag feedback
          feedback: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(color: Colors.lightGreen),
          ),
          //Calculates the coordinate center point of the current box when you start dragging
          onDragStarted: () {
            var box = key1.currentContext!.findRenderObject() as RenderBox;
            var x = box.localToGlobal(Offset.zero).dx + box.size.width / 2;
            var y = box.localToGlobal(Offset.zero).dy - box.size.height / 2;
            start_offset.value = Offset(x, y);
          },
        ),

        //Dragtarget is the right column
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DragTarget(
              builder: (context, c, r) => Container(
                key: key2,
                width: 100,
                height: 100,
                child: Image.asset('images/database.png'),
                decoration: BoxDecoration(color: Colors.green),
              ),
              //Get the coordinate center point of the current box after receiving the data
              onAccept: (_) {
                print("on acccepptttt database");
                var box = key2.currentContext!.findRenderObject() as RenderBox;
                var x = box.localToGlobal(Offset.zero).dx + box.size.width / 2;
                var y = box.localToGlobal(Offset.zero).dy - box.size.height / 2;
                end_offset.value = Offset(x, y);
              },
            ),
            SizedBox(
              height: 50,
            ),
            DragTarget(
              builder: (context, c, r) => Container(
                key: key3,
                width: 100,
                height: 100,
                child: Image.asset('images/api.png'),
                decoration: BoxDecoration(color: Colors.green),
              ),
              onAccept: (_) {
                print("on acccepptttt apiiii");
                var box = key3.currentContext!.findRenderObject() as RenderBox;
                var x = box.localToGlobal(Offset.zero).dx + box.size.width / 2;
                var y = box.localToGlobal(Offset.zero).dy - box.size.height / 2;
                end_offset.value = Offset(x, y);
              },
            ),
          ],
        )
      ],
    );
  }
}

class Painter3 extends CustomPainter {
  //Draw start point
  var _start;
  //Draw end point
  var _end;

  Painter3(this._start, this._end);

  @override
  void paint(Canvas canvas, Size size) {
    //Brush properties
    var _paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    //Draw line
    canvas.clipRect(Offset.zero & size);
    canvas.drawLine(_start.value, _end.value, _paint);
  }

  @override
  bool shouldRepaint(Painter3 oldDelegate) {
    return true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api Boobs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Api Boobs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Widget> _listOfWidgets = [];
  double _x = 0;
  double _y = 0;

  @override
  Widget build(BuildContext context) {
    double _width  = MediaQuery.of(context).size.width;
    double _height  = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.blue,
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.indigo,
                width: double.infinity,
                height: double.infinity,
                /*decoration: const BoxDecoration(
                    color: Colors.amber,
                    image: DecorationImage(
                        image: AssetImage("images/map.png"), fit: BoxFit.cover
                    )
                ),*/
                child: DragTarget<String>(
                  builder: (context, candidateItems, rejectedItems) {
                    print("printing target ${_listOfWidgets.length}");
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.limeAccent,
                      child: Stack(
                        children: _listOfWidgets,
                      ),
                    );
                  },
                  onAccept: (item) {
                    print("on accept");
                    setState(() {
                      print("in on accept: " + item);
                      print("last x: ${_x.abs() / 2} , y: ${_y.abs() / 2}");
                      _listOfWidgets.add(
                        Positioned(
                          child: SizedBox(
                            width:  _width * 0.07,
                            height: _width * 0.07,
                            child: WidgetItem(name: "Api", img: "images/$item.png")
                          ),
                          top: _y.roundToDouble() - (_height * 0.058),
                          left: _x.roundToDouble() - (_width * 0.091),
                        )
                      );
                      print("in on accept: " + _listOfWidgets.length.toString());
                    });
                  },
                  onLeave: (c) {
                    print("when leave" + c.toString());
                  },
                  onMove: (DragTargetDetails move) {
                    setState(() {
                      _x = move.offset.dx;
                      _y = move.offset.dy;
                    });
                  },
                )
              ),
              flex: 8,
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(10),
                crossAxisCount: 2,
                children: <Widget>[
                  Draggable<String>(
                    data: 'map',
                    child: const WidgetItem(name: "Map", img: "images/map.png"),
                    feedback: Material(
                      child: SizedBox(
                          width:  _width * 0.07,
                          height: _width * 0.07,
                          child: const WidgetItem(name: "Map", img: "images/map.png")
                      ),
                    ),
                  ),
                  const Draggable<String>(
                    data: 'api',
                    child: WidgetItem(name: "Api", img: "images/api.png"),
                    feedback: WidgetItem(name: "Api", img: "images/api.png"),
                  ),
                  const Draggable<String>(
                    data: 'database',
                    child: WidgetItem(name: "Database", img: "images/database.png"),
                    feedback: WidgetItem(name: "Database", img: "images/database.png")
                  ),
                  const Draggable<String>(
                    data: 'files',
                    child: WidgetItem(name: "files", img: "images/files.png"),
                    feedback: WidgetItem(name: "files", img: "images/files.png"),
                  )
                ]
              ),
              flex: 2
            ),
          ],
        )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
