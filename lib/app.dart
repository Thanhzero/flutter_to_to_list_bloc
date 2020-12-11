import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_bloc/bloc/post_bloc.dart';
import 'package:to_do_list_bloc/bloc/post_events.dart';
import 'package:to_do_list_bloc/ui/home_screen.dart';
import 'package:http/http.dart' as http;

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (context) => PostBloc(httpClient: http.Client())..add(PostFetched()),
          child: HomeScreen(),
        ),
      ),
    );
  }


}