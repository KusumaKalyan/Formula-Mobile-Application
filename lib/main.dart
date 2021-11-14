import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'formula_data/data.dart';
import 'formulaCalculationPage.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255,22,22,22),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255,22,22,22)
        )
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2),
            ()=> Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                HomePage(title: 'Formula',)
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(color: Colors.amberAccent, child: Center(child: Image(image: AssetImage('assets/formula.png'),height: 300,width: 300,)),),
      debugShowCheckedModeBanner: false,
    );
  }
}


class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    LinkedHashMap formulaData = json.decode(jsonFormulaData);
    int totalFormulaCount = formulaData.keys.length;
    List<String> formulaNames = formulaData.keys.toList();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(icon: Icon(Icons.search, color: Colors.white,),),
        ],
        title: Text(
            'FORMULA',
            textAlign: TextAlign.center,
            style: TextStyle(
              // color: Color.fromARGB(255,103,155,155),
              color: Colors.amberAccent,
              fontFamily: 'FrontMan',
            ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.black,
            ),

          child: Drawer(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DrawerHeader(
                            child: Image(image: AssetImage('assets/formula.png',),),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      'Feedback',
                      style: TextStyle(
                        color:Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      'About',
                      style: TextStyle(
                        color:Colors.white,
                      ),
                    ),
                  ),
                  Expanded(child: Text(' '),),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      'Version 0.01',
                      style: TextStyle(
                        color:Colors.white,
                      ),
                    ),
                  ),
                ],
          ))
      ),
      backgroundColor: Color.fromARGB(255,33,33,33),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return false;
        },
        child: Center(
          child:ListView.builder(
              padding: const EdgeInsets.only(left: 5, right: 5),
              itemCount: totalFormulaCount,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {Navigator.push(context, CupertinoPageRoute(builder: (context) => FormulaCalculationPage(formulaData[formulaNames[index]], formulaNames[index])));},
                  child: Card(
                    color: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.transparent,
                      child: Text(formulaNames[index],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),
                );
              }
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('feedback pressed');
        },
        child: Icon(Icons.feedback),
      ),
    );
  }
}
