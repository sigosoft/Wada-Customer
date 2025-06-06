import 'package:flutter/material.dart';

import '../../Resource/Colors.dart' show colorPrimary;

class CustomTabBarWidget extends StatefulWidget {
  final List<Tab> tabs;
  final List<Widget> tabViews;

  const CustomTabBarWidget({
    Key? key,
    required this.tabs,
    required this.tabViews,
  }) : super(key: key);

  @override
  _CustomTabBarWidgetState createState() => _CustomTabBarWidgetState();
}

class _CustomTabBarWidgetState extends State<CustomTabBarWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          labelPadding: EdgeInsets.only(right: 3),
          labelColor: colorPrimary,
          indicatorColor: colorPrimary,
          dividerColor: Colors.transparent,
          controller: _tabController,
          tabs: widget.tabs,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.tabViews,
          ),
        ),
      ],
    );
  }
}
