import 'package:flutter/material.dart';
import 'package:linkmark_app/ui/component/appbar/search_pp_bar_painter.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<StatefulWidget> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(56.0);
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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onSearchTapUp(TapUpDetails details) {
    _rippleStartX = details.globalPosition.dx;
    _rippleStartY = details.globalPosition.dy;
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
      actions: [
        GestureDetector(
          child: IconButton(
            onPressed: null,
            icon: Icon(
              Icons.search,
              color: Theme.of(context).primaryIconTheme.color,
            ),
          ),
          onTapUp: onSearchTapUp,
        )
      ],
    );
  }

  AnimatedBuilder _buildAnimation(double screenWidth) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: SearchAppBarPainter(
            containerHeight: widget.preferredSize.height,
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
    return isInSearchMode ? AppBar() : Container();
  }
}
