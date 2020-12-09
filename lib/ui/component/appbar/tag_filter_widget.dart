import 'package:flutter/material.dart';

const tags = [
  'Android',
  'iOS',
  'Mobile',
];

class TagFilterWidget extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  State<StatefulWidget> createState() => _TagFilterState();
}

class _TagFilterState extends State<TagFilterWidget> {

  List<bool> _listSelected;

  @override
  void initState() {
    super.initState();

    _listSelected = tags.map((_) => false).toList();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: kToolbarHeight,
      child: ListView.builder(
        itemCount: tags.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tag = tags[index];
          return FilterChip(
            selected: _listSelected[index],
            selectedColor: Theme.of(context).primaryColor,
            showCheckmark: false,
            label: Text(tag),
            onSelected: (bool value) {
              setState(() {
                _listSelected[index] = value;
              });
            },
          );
        },
      ),
    );
  }
}
