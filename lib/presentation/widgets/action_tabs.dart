import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
class ActionTabs extends ConsumerStatefulWidget {
  const ActionTabs({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ActionTabsState();
}

class _ActionTabsState extends ConsumerState<ActionTabs> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Icon(Icons.download),
      ],
    );
  }
}
