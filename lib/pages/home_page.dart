import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver{
  late Timer timer;
  int count = 0;
  bool active = true;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(active){
        setState(() {
          count+=1;
        });
      }


    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if(state == AppLifecycleState.resumed){
      active = true;
      print("Resumed");
    }else if(state == AppLifecycleState.inactive){
      active = false;
      print("Inactive");
    }else if(state == AppLifecycleState.paused){
      active = false;
      print("Paused");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('${count}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
      ),

    );
  }
}
