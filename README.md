# yun_music

A new Flutter project.

## Getting Started

2025。1.25日，腊月26了。过年前最后一天上班了，完成了音乐播放列表弹窗功能；还有视频播放细节优化，还有其他需要多测试处理的，过完年后找时间再仔细处理下；
过年了，网易云音乐Flutter整体版本完成百分之90，一些小的功能不再去处理了，就以我标准的剩下百分之10，年后处理完善；
整体项目完成后，在进行模块化总结，把里面用到的一些细节功能罗列出来，有个统筹化学习总结，
好了，过年喽


2025.2.23周末，完成了搜索页面，处理了大部分细节问题，还有键盘弹起，造成rebuild问题；
搜索结果页面大框架搭建完成，接下来完成单曲，歌单，等这些CustomSliveView的

//rm -rf android 删除某一个终端支持 

/// 安卓打包相关的

Flutter打包安卓 apk 
  keytool -genkey -v -keystore wang.jks -keyalg RSA -keysize 2048 -validity 10000 -alias wang

wang : 自定义名字
输入密钥口令密码：六位数就行
其他的组织单位，城市地区这些，自己取名

把生成的 jks文件放入 /android/app/下， 自定义文件 key.properties 放入 /android/下，跟local.properties同级

flutter build apk --release 开始打包
具体问题具体分析解决




///关于gradle 有时候总是报错的问题 
1: 终端 输入 gradle -version 报错，not found 。没有把Mac下配置环境

vi ~/.zshrc 打开配置文件 i 开始修改添加 
export GRADLE_HOME="/Users/hu/.gradle/wrapper/dists/gradle-8.9-bin/90cnw93cvbtalezasaz0blq0a/gradle-8.9"
export PATH=$PATH:$GRADLE_HOME/bin 

/Users/wangsongfeng/.gradle 找到想要的gradle 版本路径

source ~/.zshrc 保存配置

gradle -v 查看版本




https://blog.csdn.net/qq_40745143/article/details/144826018