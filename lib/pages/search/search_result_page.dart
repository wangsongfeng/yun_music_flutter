import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/pages/search/search_result_controller.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late SearchResultController controller = Get.put(SearchResultController());

  @override
  void initState() {
    super.initState();
    print(controller.searchKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.search_page_bg,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Container(),
    );
  }
}
