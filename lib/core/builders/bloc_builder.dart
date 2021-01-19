import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlocBuilder<T> extends StatelessWidget {
  final Widget Function(T, BuildContext) builder;
  BlocBuilder({@required this.builder});
  @override
  Widget build(BuildContext context) {
    return Consumer<T>(builder: (_, bloc, child) => builder(bloc, _));
  }
}
