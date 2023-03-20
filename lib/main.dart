import 'package:calculator/widgets/myButton.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userQuestion = '';
  String userAnswer = '';

  List<String> myButtons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '='
  ];



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(child: Text(userQuestion,style: TextStyle(fontSize: 30),), alignment: Alignment.centerLeft),
                  Align(child: Text(userAnswer, style: TextStyle(fontSize: 30),), alignment: Alignment.centerRight,),
                ],
              ),
            )),
            Expanded(
                flex: 2,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return MyButton(
                          buttonText: myButtons[index], color: Colors.black45,
                        onTap: (){
                            setState(() {
                              userQuestion = '';
                              userAnswer = '';
                            });
                        }
                        ,);
                    }
                    if (index == 1) {
                      return MyButton(
                          buttonText: myButtons[index], color: Colors.red, onTap: (){
                            setState(() {
                              userQuestion = userQuestion.substring(0, userQuestion.length - 1);
                            });
                      },);
                    }
                    if (index == myButtons.length - 1) {
                      return MyButton(
                          buttonText: myButtons[index], color: Colors.green, onTap: (){
                              onEqualPressed(userQuestion);
                      },);
                    }
                    return MyButton(
                      onTap: (){

                        setState(() {
                          userQuestion = userQuestion + myButtons[index];

                        });

                      },
                      buttonText: myButtons[index],
                      color: isOperator(myButtons[index])
                          ? Colors.orange[600]
                          : Colors.deepPurple[400],
                    );
                  },
                  itemCount: myButtons.length,
                )),
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' ) {

      return true;
    } else {
      return false;
    }
  }

  void onEqualPressed(String userQuestion){
    final question = userQuestion.replaceAll('x', '*');
     Parser p = Parser();
     Expression exp = p.parse(question);
     ContextModel cm = ContextModel();
     double eval = exp.evaluate(EvaluationType.REAL, cm);
     setState(() {
       userAnswer =  eval.toString();

     });
  }

}
