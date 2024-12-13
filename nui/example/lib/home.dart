import 'package:flutter/material.dart';
import 'package:nui/nui.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return LazyListview(
      loadMore: () async {
        print('load more');
        await Future.delayed(const Duration(seconds: 2));
      },
      itemBuilder: (context, index) => Container(
        height: 100,
        color: Colors.red,
        child: Text(index.toString()),
      ),
      itemCount: 5,
    );
  }
}
