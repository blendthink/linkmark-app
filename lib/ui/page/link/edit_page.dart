import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class EditPage extends StatelessWidget {
  void _close({
    @required BuildContext context,
  }) {
    Navigator.of(context).pop();
  }

  void _submit({
    @required BuildContext context,
    @required String url,
  }) {
    // TODO(okayama): Link の保存処理を実装する
    _close(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      leading: IconButton(
        onPressed: () {
          _close(context: context);
        },
        icon: Icon(Icons.close),
      ),
      title: Text('Edit Link'),
      actions: [
        IconButton(
          onPressed: () {
            // _submit(context: context, url: value);
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
        onSaved: (value) {
          _submit(context: context, url: value);
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
