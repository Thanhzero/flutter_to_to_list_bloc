import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_bloc/bloc/post_bloc.dart';
import 'package:to_do_list_bloc/bloc/post_events.dart';
import 'package:to_do_list_bloc/bloc/post_states.dart';
import 'package:to_do_list_bloc/ui/widgets/bottom_loader_widget.dart';
import 'package:to_do_list_bloc/ui/widgets/post_widgets.dart';

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollThreshold = 200.0;
  PostBloc _postBloc;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<PostBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc,  PostState>(
      builder: (context, state){
        Widget childWidget;
        if (state is PostInitial)
          childWidget = Center(
            child: CircularProgressIndicator(),
          );
        if (state is PostFailure)
          childWidget = Center(
            child: Text("Failure to fetch post"),
          );
        if (state is PostSuccess){
          if  (state.posts.isEmpty)
            childWidget = Center(
              child: Text("No Post"),
            );
          childWidget = ListView.builder(
            itemBuilder: (BuildContext context, int index){
              return index >= state.posts.length ? BottomLoader() : PostWidget(post : state.posts[index]);
            },
            itemCount: state.hasReachedMax ? state.posts.length : state.posts.length + 1,
            controller: _scrollController,
          );
        }
        return childWidget;
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.add(PostFetched());
    }
  }
}