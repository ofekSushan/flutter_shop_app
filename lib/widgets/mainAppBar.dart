import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget{
  String title;
  List<Widget> actions;

  MainAppBar({required this.title,required this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
      actions: actions,
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}
