import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model/link.dart';
import '../../../util/logger.dart';
import 'edit_view_model.dart';

class EditPage extends StatefulWidget {
  EditPage({
    this.link,
    Key? key,
  }) : super(key: key);

  final Link? link;

  @override
  State<StatefulWidget> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormFieldState>();
  final _textEditingController = TextEditingController();

  bool get _isUpdate => widget.link != null;

  @override
  void initState() {
    super.initState();

    if (_isUpdate) {
      _textEditingController.text = widget.link?.url ?? '';
    }
  }

  void _onPop({
    required BuildContext context,
    required bool existsUpdate,
  }) {
    Navigator.of(context).pop(existsUpdate);
  }

  void _submit({
    required BuildContext context,
    required EditViewModel editViewModel,
  }) async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final url = _textEditingController.text;
    logger.info('Edit Link: $url');

    if (_isUpdate) {
      // TODO: update link
      _onPop(context: context, existsUpdate: true);
    } else {
      final result = await editViewModel.createLink(url: url);

      SnackBar snackBar;
      if (result.isSuccess) {
        _onPop(context: context, existsUpdate: true);
        snackBar = const SnackBar(
          content: Text('New Link has been created.'),
          duration: Duration(seconds: 3),
        );
      } else {
        snackBar = SnackBar(
          content: const Text('Can‘t create new link. Retry in 5 seconds.'),
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: () {
              _submit(
                context: context,
                editViewModel: editViewModel,
              );
            },
          ),
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final editViewModel = context.read(editViewModelProvider);

    final appBar = AppBar(
      leading: IconButton(
        onPressed: () {
          _onPop(context: context, existsUpdate: false);
        },
        icon: const Icon(Icons.close),
      ),
      title: const Text('Edit Link'),
      actions: [
        IconButton(
          onPressed: () {
            _submit(
              context: context,
              editViewModel: editViewModel,
            );
          },
          icon: const Icon(Icons.done),
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
          // TODO: isURL
          return null;
          // return !isURL(value, allowUnderscore: true)
          //     ? 'Please enter URL'
          //     : null;
        },
        onFieldSubmitted: (_) {
          _submit(
            context: context,
            editViewModel: editViewModel,
          );
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
