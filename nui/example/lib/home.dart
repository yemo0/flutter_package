import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const NTabBar(tabs: [Text('Tab 1'), Text('Tab 2'), Text('Tab 3')]),
    );
  }
}

class NTabBar extends StatefulWidget {
  final List<Widget> tabs;
  const NTabBar({super.key, required this.tabs});

  @override
  State<StatefulWidget> createState() => NTabBarState();
}

class NTabBarState extends State<NTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(controller: _tabController, tabs: widget.tabs);
  }
}
