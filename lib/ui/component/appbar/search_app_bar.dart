import 'package:flutter/material.dart';
import 'package:linkmark_app/ui/component/appbar/search_app_bar_painter.dart';
import 'package:linkmark_app/ui/component/appbar/search_widget.dart';
import 'package:linkmark_app/ui/component/appbar/tag_filter_widget.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final ValueChanged<String> onTextChanged;

  const SearchAppBar({
    Key key,
    @required this.onTextChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(112.0);
}

class _SearchAppBarState extends State<SearchAppBar>
    with SingleTickerProviderStateMixin<SearchAppBar> {
  bool _isInSearchMode = false;
  double _rippleStartX, _rippleStartY;
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
    _animationController.addStatusListener((status) {
      setState(() {
        _isInSearchMode = status == AnimationStatus.completed;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onSearchTapUp(PointerUpEvent event) {
    _rippleStartX = event.position.dx;
    _rippleStartY = event.position.dy;
    _animationController.forward();
  }

  void cancelSearch() {
    _animationController.reverse();
  }

  Future<bool> _onWillPop() async {
    if (_isInSearchMode) {
      cancelSearch();
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Stack(
        children: [
          _buildAppBar(context),
          _buildAnimation(screenWidth),
          _buildSearchWidget(_isInSearchMode, context),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Linkmark'),
      centerTitle: true,
      bottom: TagFilterWidget(),
      actions: [
        Listener(
          onPointerUp: onSearchTapUp,
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Theme.of(context).primaryIconTheme.color,
            ),
          ),
        ),
      ],
    );
  }

  AnimatedBuilder _buildAnimation(double screenWidth) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: SearchAppBarPainter(
            containerHeight: 56.0,
            center: Offset(_rippleStartX ?? 0, _rippleStartY ?? 0),
            // increase radius in % from 0% to 100% of screenWidth
            radius: _animation.value * screenWidth,
            context: context,
            color: Colors.white,
          ),
        );
      },
    );
  }

  Widget _buildSearchWidget(bool isInSearchMode, BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return SizedBox(
      height: 56.0 + statusBarHeight,
      child: isInSearchMode
          ? SearchWidget(
              onTextChanged: widget.onTextChanged,
              onCancelSearch: cancelSearch,
              iconColor: Theme.of(context).primaryColor,
              hintText: '検索する文字',
            )
          : Container(),
    );
  }
}
