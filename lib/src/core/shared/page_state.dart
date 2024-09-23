import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class PageState<T extends StatefulWidget, C extends Object> extends State<T> {
  final C _controller = Modular.get<C>();

  C get controller => _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
