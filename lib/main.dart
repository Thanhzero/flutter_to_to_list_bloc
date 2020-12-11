import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_bloc/app.dart';
import 'package:to_do_list_bloc/simple_bloc_server.dart';

void main (){
  Bloc.observer = SimpleBlocObserver();
  runApp(App());
}