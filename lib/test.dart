import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Page1(),
    Page2(),
    Page3(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.black,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.home,
                      size: 24,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _onItemTapped(0);
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.business,
                      size: 24,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _onItemTapped(1);
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.school,
                      size: 24,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _onItemTapped(2);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Page 1'),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Page 2'),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Page 3'),
    );
  }
}





// import 'package:flutter/material.dart';
//
// class Test extends StatefulWidget {
//   const Test({super.key});
//
//   @override
//   State<Test> createState() => _TestState();
// }
//
// class _TestState extends State<Test> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 50,vertical: 30),
//             width: 300,
//             height: 250,
//             color: Colors.brown,
//             child: Stack(
//               children: [
//
//                 Container(
//                   margin: EdgeInsets.only(top: 90),
//                   width: 300,
//                   height: 200,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//
//                   ),
//                 ),
//
//                 Container(
//                   margin: EdgeInsets.only(left: 80),
//                   width: 150,
//                   height: 150,
//                   decoration: BoxDecoration(
//                     color: Colors.amber,
//                     borderRadius: BorderRadius.circular(100),
//
//                   ),
//                 ),
//               ],),
//           )
//
//         ],),
//     );
//   }
// }
