import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class EditPage extends StatelessWidget {
  void _close(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

    final appBar = AppBar(
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
    );

    final urlForm = Padding(
      padding: const EdgeInsets.all(16),
      child: TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.link),
          border: OutlineInputBorder(),
          filled: true,
          labelText: "Enter URL",
          hintText: 'https://',
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return !isURL(value, allowUnderscore: true)
              ? 'Please enter URL'
              : null;
        },
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        child: Column(
          children: [
            urlForm,
          ],
        ),
      ),
    );
  }
}
