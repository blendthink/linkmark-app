import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TagIndexPage extends HookWidget {
  const TagIndexPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tag List'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
