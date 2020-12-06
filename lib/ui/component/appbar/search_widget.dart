import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final ValueChanged<String> onTextChanged;
  final VoidCallback onCancelSearch;
  final Color iconColor;
  final String hintText;

  const SearchWidget({
    Key key,
    @required this.onTextChanged,
    @required this.onCancelSearch,
    @required this.iconColor,
    @required this.hintText,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      widget.onTextChanged(_textEditingController.text);
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: TextField(
        controller: _textEditingController,
        autofocus: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
        ),
        textCapitalization: TextCapitalization.none,
        style: Theme.of(context)
            .primaryTextTheme
            .headline6
            .copyWith(color: Colors.black),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: widget.iconColor,
        ),
        onPressed: widget.onCancelSearch,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.close,
            color: widget.iconColor,
          ),
          onPressed: _textEditingController.clear,
        ),
      ],
    );
  }
}
