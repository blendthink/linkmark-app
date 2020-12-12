import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class EditPage extends StatefulWidget {
  const EditPage({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormFieldState>();
  final _textEditingController = TextEditingController();

  void _cancel({
    @required BuildContext context,
  }) {
    Navigator.of(context).pop();
  }

  void _submit({
    @required BuildContext context,
  }) {
    final isValid = _formKey.currentState.validate();
    if (!isValid) return;

    // TODO(okayama): Link の保存処理を実装する
    final url = _textEditingController.text;
    print('url: $url');
    _cancel(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      leading: IconButton(
        onPressed: () {
          _cancel(context: context);
        },
        icon: Icon(Icons.close),
      ),
      title: Text('Edit Link'),
      actions: [
        IconButton(
          onPressed: () {
            _submit(context: context);
          },
          icon: Icon(Icons.check),
        ),
      ],
    );

    final urlForm = Padding(
      padding: const EdgeInsets.all(16),
      child: TextFormField(
        key: _formKey,
        controller: _textEditingController,
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
        onFieldSubmitted: (_) {
          _submit(context: context);
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
