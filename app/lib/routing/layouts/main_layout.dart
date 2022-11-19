import 'dart:math';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/features/house/view/design_page.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../constants/colors.dart';
import '../../features/discover/view/discover_page.dart';
import '../../features/friends/view/friends_page.dart';
import '../locations/main_location.dart';

/// Provides the current home page index.
///
/// This provider is overridden in the [MainLocation] to
/// hold the current page index value.
final pageIndexProvider = Provider((ref) => 0);

/// Provides a boolean value indicating if the current page is active.
///
/// This provider is scoped to the pages of [MainLayout] and
/// must only be used under this subtree.
final pageActiveProvider = Provider((ref) => false);

/// The home layout responsible for switching between the four main pages and
/// listening to barcode scans in the background.
class MainLayout extends StatelessWidget {
  static void changePage(BuildContext context, int nextIndex) {
    var index = max(0, min(2, nextIndex));
    if (index == context.read(pageIndexProvider)) return;

    context.beamToNamed('/${MainLocation.pages[index]}');
  }

  final List<PageBuilder> pages = [
    () => const DesignPage(),
    () => const DiscoverPage(),
    () => const FriendsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    var currentPageIndex = context.watch(pageIndexProvider);

    return Scaffold(
      backgroundColor: hcDark[800],
      body: StackSwitcher(
        currentIndex: currentPageIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: hcLight[0],
        unselectedItemColor: hcLight[400],
        backgroundColor: hcDark[800],
        currentIndex: currentPageIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        iconSize: 38,
        items: const [
          BottomNavigationBarItem(
            label: 'Design',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Discover',
            icon: Icon(Icons.explore),
          ),
          BottomNavigationBarItem(
            label: 'Friends',
            icon: Icon(Icons.groups),
          ),
        ],
        onTap: (v) => changePage(context, v),
      ),
    );
  }
}

typedef PageBuilder = Widget Function();

class StackSwitcher extends StatefulWidget {
  final List<PageBuilder> children;
  final int currentIndex;

  const StackSwitcher({super.key, required this.children, required this.currentIndex});

  @override
  _StackSwitcherState createState() => _StackSwitcherState();
}

class _StackSwitcherState extends State<StackSwitcher> with TickerProviderStateMixin {
  final List<AnimationController> _animations = [];
  late List<Widget?> _children;

  @override
  void initState() {
    _buildChildren();
    super.initState();
  }

  @override
  void didUpdateWidget(StackSwitcher old) {
    if (widget.children != old.children) {
      setState(() {
        _buildChildren();
      });
    } else if (widget.currentIndex != old.currentIndex) {
      if (_children[widget.currentIndex] == null) {
        _buildChild(widget.currentIndex);
      }

      var curve = Curves.easeInOutCubic;
      if (widget.currentIndex > old.currentIndex) {
        _animations[widget.currentIndex].value = 1;
        _animations[widget.currentIndex].animateTo(0, curve: curve);
        _animations[old.currentIndex].animateTo(-1, curve: curve);
      } else {
        _animations[widget.currentIndex].value = -1;
        _animations[widget.currentIndex].animateTo(0, curve: curve);
        _animations[old.currentIndex].animateTo(1, curve: curve);
      }
    }

    super.didUpdateWidget(old);
  }

  void _buildChildren() {
    if (_animations.length != widget.children.length) {
      _setAnimations();
    }
    _children = List<Widget?>.filled(widget.children.length, null);
    _buildChild(widget.currentIndex);

    if (mounted) setState(() {});
  }

  void _buildChild(int index) {
    _children[index] = SlideTransition(
      position: _animations[index].drive(Tween(
        begin: Offset.zero,
        end: const Offset(1, 0),
      )),
      child: Builder(builder: (context) {
        var isActive = context.watch(pageIndexProvider.select((i) => i == index));
        return ProviderScope(
          key: GlobalObjectKey('home_page_scope_$index'),
          overrides: [pageActiveProvider.overrideWithValue(isActive)],
          child: widget.children[index](),
        );
      }),
    );
  }

  void _setAnimations() {
    while (_animations.length > widget.children.length) {
      _animations.removeLast();
    }

    for (int i = 0; i < widget.children.length; i++) {
      if (_animations.length <= i) {
        _animations.add(AnimationController(
          vsync: this,
          lowerBound: -1,
          duration: const Duration(milliseconds: 300),
        ));
      }

      _animations[i].value = i < widget.currentIndex
          ? -1
          : i == widget.currentIndex
              ? 0
              : 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _children.whereType<Widget>().toList(),
    );
  }
}
