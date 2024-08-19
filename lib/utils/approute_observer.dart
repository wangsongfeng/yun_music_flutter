import 'package:flutter/material.dart';

class AppRouteObserver {
  //这是实际上的路由监听器
  static final RouteObserver<ModalRoute<void>> _routeObserver =
      RouteObserver<ModalRoute<void>>();
  //这是个单例
  static final AppRouteObserver _appRouteObserver =
      AppRouteObserver._internal();

  AppRouteObserver._internal();
  //通过单例的get方法轻松获取路由监听器
  RouteObserver<ModalRoute<void>> get routeObserver {
    return _routeObserver;
  }

  factory AppRouteObserver() {
    return _appRouteObserver;
  }
}