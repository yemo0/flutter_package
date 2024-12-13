import 'package:flutter/material.dart';

class LazyListview extends StatefulWidget {
  final Function? loadMore;
  final Widget? Function(BuildContext, int) itemBuilder;
  final int? itemCount;
  const LazyListview({super.key, required this.loadMore, required this.itemBuilder, this.itemCount});

  @override
  State<StatefulWidget> createState() => _LazyListviewState();
}

class _LazyListviewState extends State<LazyListview> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() async {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
      _isLoading = true;
      await widget.loadMore!();
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemBuilder: (_, index) => widget.itemBuilder(context, index),
      itemCount: widget.itemCount,
    );
  }
}
