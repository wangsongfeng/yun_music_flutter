import 'package:get/get.dart';
import 'comment_controller.dart';

class CommentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MCommentController>(() => MCommentController());
  }
}
