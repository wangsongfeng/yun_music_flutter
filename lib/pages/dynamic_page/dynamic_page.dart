import 'package:flutter/material.dart';

import 'widgets/dynamic_appbar.dart';

class DynamicPage extends StatefulWidget {
  const DynamicPage({super.key});

  @override
  State<DynamicPage> createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DynamicAppbar(),
      extendBodyBehindAppBar: true,
      body: Container(),
    );
  }
}
