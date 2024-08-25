import 'package:example/home/home_bottom.dart';
import 'package:example/viewmodel/home/home_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeList extends ConsumerWidget {
  const HomeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeListState = ref.watch(homeListViewModelProvider);
    return Column(
      verticalDirection: VerticalDirection.down,
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: homeListState.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
              decoration: BoxDecoration(
                color: homeListState[index].isSynced! ? Colors.green : Colors.blue,
                borderRadius: BorderRadius.circular(8)
              ),
              child:  ListTile(
                onTap: () {
                  idController.text = homeListState[index].uuid.toString();
                  contentController.text = homeListState[index].content.toString();
                },
                leading: Text(homeListState[index].uuid.toString().substring(0, 8)),
                title: Text(homeListState[index].content.toString()),
                trailing: Text(homeListState[index].createdAt.toString()),
                subtitle: Text(homeListState[index].updatedAt.toString()),
              ),
            );
          },
        )),
        const HomeBottom()
      ],
    );
  }
}
