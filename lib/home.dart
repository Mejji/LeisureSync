import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget{
  const MyHomePage({super.key,required
  this.title});

  final String title;

  @override
  State<MyHomePage> createState() =>
      _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  int _counter = 0;

  void _incrementCounter(){
    setState((){
      _counter++;
    });
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:  Color(0xFF00AFDF),
        title:Text(
            widget.title,
            style: TextStyle(color: Colors.black)
        ),
      ),
      body:Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            const Text(
              'You have to pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style:
              Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton:
      FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: Color(0xFF00AFDF),
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
