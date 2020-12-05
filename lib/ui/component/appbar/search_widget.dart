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
    return SafeArea(
      top: true,
      child: GestureDetector(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildBackButton(),
                  _buildTextField(),
                  _buildClearButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return IconButton(
      icon: Icon(
        Icons.close,
        color: widget.iconColor,
      ),
      onPressed: _textEditingController.clear,
    );
  }

  Widget _buildBackButton() {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: widget.iconColor,
      ),
      onPressed: widget.onCancelSearch,
    );
  }

  Widget _buildTextField() {
    return Expanded(
      child: TextField(
        controller: _textEditingController,
        autofocus: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 12.0),
          hintText: widget.hintText,
        ),
        textCapitalization: TextCapitalization.none,
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
