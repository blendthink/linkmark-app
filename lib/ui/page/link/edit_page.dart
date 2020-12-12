import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
  void _close(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _close(context);
          },
          icon: Icon(Icons.close),
        ),
        title: Text('Edit Link'),
        actions: [
          IconButton(
            onPressed: () {
              _close(context);
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
