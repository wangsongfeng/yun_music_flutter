import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/found/found_controller.dart';

class FoundPage extends StatefulWidget {
  const FoundPage({super.key});

  @override
  State<FoundPage> createState() => _FoundPageState();
}

class _FoundPageState extends State<FoundPage>
    with AutomaticKeepAliveClientMixin {
  final controller = GetInstance().putOrFind(() => FoundController());

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    print('Found');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Found'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: Image.network('http://p1.music.126.net/oRND1RziUgkrYBuSFgz5yQ==/109951169664471894.jpg?param=718y281'),
        ),
      ),
    );
  }
}
