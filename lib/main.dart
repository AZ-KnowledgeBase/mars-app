import 'package:flutter/material.dart';
import 'screens/start_screen.dart';
import 'utility/theme.dart';

void main(){
  runApp(const MarsApp());
}

class MarsApp extends StatelessWidget{
  const MarsApp({super.key});

  @override
  Widget build(buildContext){
    return MaterialApp(
      title: 'Mars App',
      theme: AppTheme.marsDarkTheme,
      home: StartScreen(),
    );
  }
}