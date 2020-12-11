import 'package:flutter/material.dart';
import 'package:to_do_list_bloc/model/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${post.id}'),
      title: Text("${post.title}"),
      isThreeLine: true,
      subtitle: Text("${post.body}"),
      dense: true,
    );
  }
}
