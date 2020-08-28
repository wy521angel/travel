import 'package:flutter/material.dart';
import 'package:travel/model/grid_nav_model.dart';

class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;
  final String name;

  const GridNav({Key key, @required this.gridNavModel, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(name);
  }
}
