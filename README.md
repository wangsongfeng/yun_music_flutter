# yun_music

这个项目主要是在学习了Dart的基础知识后，想以一个完整项目去巩固自己，正好看到网上有人做过网易云的Flutter版本，我就以别人做的基础框架为基础去从0到1 ，去完善这个项目，大框架是以GetX 去学习开发的，UI界面是以网易云的模版去搭建，下载图表等的这些，网友分享的demo，里边的一些mark json 数据和 网络请求数据，我是找到一个感觉有用，就拉到自己的项目中，所以你在整个项目中会看到很割裂的感觉，有些地方是一个域名请求的，一些是另一个域名网络请求的，有的还是用的本地json数据；

整体完善，一边做一边写，前期，是粗糙版本，后期慢慢接触了更好的框架代码，就一点点去优化处理，达到我心中的理想状态；里边有音乐播放，有视频播放（类 抖音 ）还有其他的。

大家一起交流学习，如果您感觉里边的某些东西不合理，可以私信我，我也想更好的学习Flutter。大体就是这些

## Getting Started

2025。1.25日，腊月26了。过年前最后一天上班了，完成了音乐播放列表弹窗功能；还有视频播放细节优化，还有其他需要多测试处理的，过完年后找时间再仔细处理下；
过年了，网易云音乐Flutter整体版本完成百分之90，一些小的功能不再去处理了，就以我标准的剩下百分之10，年后处理完善；
整体项目完成后，在进行模块化总结，把里面用到的一些细节功能罗列出来，有个统筹化学习总结，
好了，过年喽


2025.2.23周末，完成了搜索页面，处理了大部分细节问题，还有键盘弹起，造成rebuild问题；
搜索结果页面大框架搭建完成，接下来完成单曲，歌单，等这些CustomSliveView的

2025.3.9 找到一个类似于抖音我的页面headerView 向下拖拽慢慢变大效果，比较完美；还有歌手详情页面headerView+中间tabbar + 底部，tableView ，目前整体完善达到百分之90。页面效果完美；

2025.3.30 整体完善版以完成，搜索页面，搜索结果页面，歌手详情页面完成；都是隔三差五找时间去完善，暗黑模式适配也已经完成

接下来这个项目不怎么去动，都会是想起来再去补充些想要的东西，接下来集中精力学习vue3


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



app学习总结图
![首页](https://github.com/wangsongfeng/yun_music_flutter/blob/main/assets/screenshot/云音乐Flutter学习总结.jpg)

就不去弄截图了，想看效果图，可以点开学习总结图，然后在项目中可以看到我上传的各个页面截图

心意打赏，感觉对您有用，就支持下，一块一毛都是对我的赞赏
![打赏](https://github.com/wangsongfeng/yun_music_flutter/blob/main/assets/screenshot/IMG_3229.JPG)