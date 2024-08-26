// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MusicAppBar extends AppBar {
  MusicAppBar(
      {Key? key,
      Widget? leading, //返回键
      Color? leadingColors,
      void Function()? leadingAction, //返回键事件
      bool automaticallyImplyLeading = true,
      Widget? title,
      List<Widget>? actions,
      Widget? flexibleSpace,
      PreferredSizeWidget? bottom,
      double? elevation,
      ShapeBorder? shape,
      Color? backgroundColor,
      IconThemeData? iconTheme,
      IconThemeData? actionsIconTheme,
      bool primary = true,
      bool centerTitle = true,
      double titleSpacing = NavigationToolbar.kMiddleSpacing,
      double toolbarOpacity = 1.0,
      double bottomOpacity = 1.0,
      SystemUiOverlayStyle?
          systemUiOverlayStyle //设置状态栏字的颜色,light表示字是白色,dark表示字是黑色
      })
      : super(
            key: key,
            automaticallyImplyLeading: automaticallyImplyLeading,
            title: title,
            actions: actions,
            flexibleSpace: flexibleSpace,
            bottom: bottom,
            elevation: elevation,
            shape: shape,
            backgroundColor: backgroundColor,
            iconTheme: iconTheme,
            actionsIconTheme: actionsIconTheme,
            primary: primary,
            centerTitle: centerTitle,
            titleSpacing: titleSpacing,
            toolbarOpacity: toolbarOpacity,
            bottomOpacity: bottomOpacity,
            systemOverlayStyle: systemUiOverlayStyle);
}
