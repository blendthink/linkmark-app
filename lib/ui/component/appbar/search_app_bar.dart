import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../page/link/index_view_model.dart';
import 'search_app_bar_painter.dart';
import 'tagfilter/tag_filter_widget.dart';

const double _kLeadingWidth = kMinInteractiveDimension;

class SearchAppBar extends StatefulHookWidget implements PreferredSizeWidget {
  const SearchAppBar({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);
}

class _SearchAppBarState extends State<SearchAppBar>
    with SingleTickerProviderStateMixin<SearchAppBar> {
  void _handleDrawerButton() {
    Scaffold.of(context).openDrawer();
  }

  final _keySearchIcon = GlobalKey();
  final _textEditingController = TextEditingController();
  final _animationDuration = const Duration(milliseconds: 300);

  bool _isInSearchMode = false;
  double _rippleStartX, _rippleStartY;
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
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

    final indexViewModel = context.read(indexViewModelProvider);
    _textEditingController.addListener(() {
      indexViewModel.updateFilterText(_textEditingController.text);
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _startSearch() {
    final RenderBox renderBox =
        _keySearchIcon.currentContext.findRenderObject();

    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);

    _rippleStartX = position.dx + size.width / 2;
    _rippleStartY = position.dy + size.height / 2;

    _animationController.forward();
  }

  void _cancelSearch() {
    _textEditingController.clear();
    _animationController.reverse();
  }

  Future<bool> _onWillPop() async {
    if (_isInSearchMode) {
      _cancelSearch();
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Widget appBar = SafeArea(
      bottom: true,
      top: true,
      child: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight * 2),
        child: Container(
          width: screenWidth,
          height: kToolbarHeight * 2,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints.tightFor(width: _kLeadingWidth),
                    child: _buildLeading(context),
                  ),
                  Expanded(
                    child: _buildTitle(context),
                  ),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints.tightFor(width: _kLeadingWidth),
                    child: _buildAction(context),
                  ),
                ],
              ),
              const TagFilterWidget(),
            ],
          ),
        ),
      ),
    );

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Stack(
        children: [
          _buildAnimation(screenWidth),
          Material(
            type: MaterialType.transparency,
            child: appBar,
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final textField = TextField(
      controller: _textEditingController,
      autofocus: false,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Filter by character',
      ),
      textCapitalization: TextCapitalization.none,
      style: Theme.of(context)
          .primaryTextTheme
          .subtitle1
          .copyWith(color: Colors.black),
    );

    final text = Center(
      child: Text(
        'Linkmark',
        textAlign: TextAlign.center,
        style: Theme.of(context).primaryTextTheme.headline6,
      ),
    );

    return AnimatedCrossFade(
      firstChild: textField,
      secondChild: text,
      duration: _animationDuration,
      crossFadeState: _isInSearchMode
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
    );
  }

  Widget _buildLeading(BuildContext context) {
    final themeData = Theme.of(context);
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        color: _isInSearchMode
            ? themeData.primaryColor
            : themeData.primaryIconTheme.color,
        progress: _animationController,
      ),
      onPressed: _isInSearchMode ? _cancelSearch : _handleDrawerButton,
    );
  }

  Widget _buildAction(BuildContext context) {
    final themeData = Theme.of(context);
    return AnimatedCrossFade(
      firstChild: IconButton(
        onPressed: _textEditingController.clear,
        icon: Icon(
          Icons.clear,
          color: themeData.primaryColor,
        ),
      ),
      secondChild: IconButton(
        key: _keySearchIcon,
        onPressed: _startSearch,
        icon: Icon(
          Icons.search,
          color: themeData.primaryIconTheme.color,
        ),
      ),
      duration: _animationDuration,
      crossFadeState: _isInSearchMode
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
    );
  }

  AnimatedBuilder _buildAnimation(double screenWidth) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          color: Theme.of(context).primaryColor,
          height: kToolbarHeight * 2 + statusBarHeight,
          width: screenWidth,
          child: CustomPaint(
            painter: SearchAppBarPainter(
              containerHeight: kToolbarHeight * 2,
              center: Offset(_rippleStartX ?? 0, _rippleStartY ?? 0),
              // increase radius in % from 0% to 100% of screenWidth
              radius: _animation.value * screenWidth,
              context: context,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
