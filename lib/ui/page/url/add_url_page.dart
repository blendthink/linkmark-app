import 'package:flutter/material.dart';

class AddUrlPage extends StatelessWidget {
  final VoidCallback closeContainer;

  const AddUrlPage({Key key, this.closeContainer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: closeContainer,
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Add URL'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
