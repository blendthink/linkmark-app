import 'package:flutter/material.dart';

const tags = [
  'Android',
  'iOS',
  'Mobile',
  'Mobile',
  'Mobile',
  'Mobile',
  'Mobile',
  'Mobile',
  'Mobile',
  'Mobile',
  'Mobile',
  'Mobile',
  'Mobile',
  'Mobile',
  'Mobile',
  'Mobile',
  'Mobile',
  'Mobile',
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
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: ListView.separated(
          itemCount: tags.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final tag = tags[index];
            return FilterChip(
              selected: _listSelected[index],
              label: Text(tag),
              onSelected: (bool value) {
                setState(() {
                  _listSelected[index] = value;
                });
              },
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(width: 4,);
          },
        ),
      ),
    );
  }
}
