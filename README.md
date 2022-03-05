# flutter仿携程

## 一. 首页模块

### 1. 首页框架搭建
- Scaffold
 - PageView
 - BottomNavigationBar

### 2. 首页banner
- flutter_swiper: ^1.1.6

### 3. 首页自定义appbar实现滚动监听
Stack实现不同组件叠加
NotificationListener监听滚动
MediaQuery.removePadding(removeTop:true)适配刘海屏

### 4. 首页数据请求
- 通过http库，请求网络
- 数据解析错误时候，断点调试自动定位到异常代码

### 5. 自定义组件
- 通过继承StatelessWidget或者StatefulWidget实现自定义组件
- 所有的组件都是final类型的，即不可变的
- 默认是可填可不填的，如果参数必填，添加@required，如果必填默认值，可以直接赋值 例如：this.name='xxxx'

### 6.圆角效果 无效问题 彩蛋
- 为什么无效
- 因为是2层,圆角在最下面一层,被上面那个层盖住了

- 解决:
- 使用:
```dart
PhysicalModel(
    color:Colors.white
    borderRadius:BorderRadius.circular(6);
    clipBehavior:Clip.antAlias,
    children:[]
)
```

```dart
Container(
    decoration:BoxDecoration(border:BorderRadius.all(Radius.circular(10))),
    child:Column(
        children:List<Widget>[]
    ),
)
```

### 7.如何获取屏幕宽高度 彩蛋
```dart
MediaQuery.of(context).size.width
MediaQuery.of(context).size.height
```

### 8.动态Icon与富文本

---

## 二. 搜索模块

### 1.自定义搜索栏

### 2.集成AI语音

---

## 三. 旅拍模块

### 1.接口

### 2.Dao层设计

### 3.TabBar + TabBarView 实现旅拍可滑动切换多Tab

- TabBar 空白问题
获取到数据后,再次初始化一次

- TabBarView
直接使用,会丢失高度问题,使用Flexible嵌套即可

### 4.实现旅拍瀑布流布局

- flutter_staggered_grid_view: ^0.2.7 // 这个版本有坑,不能滑动,点击,升级到 0.3.0即可

### 5.旅拍卡片实现
- Card的使用

### 6.如何保持当前页面不会被回收?

- with AutomaticKeepAliveClientMixin
- @override
- bool get wantKeepAlive => true;

注意:会带来性能上的问题,吃内存

### 7.移除多余的padding部分
MediaQuery.removePadding()

---

## 四、启动白屏问题
- flutter_splash_screen: ^0.1.0
- android中添加
```
public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    SplashScreen.show(this,true);// add
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
  }
}
```
- 添加launch_screen.xml 定义启动页内容
- 最后定义状态栏颜色

---

## 五、屏幕适配
**IOS 全面屏适配**

- SafeArea()
- MediaQuery.removePadding()

**Android**

- SafeArea()
- MediaQuery.removePadding()
- android AndroidManifest.xml 添加代码
```
<meta-data
    android:name="android.max_aspect"
    android:value="2.3" />
```

## 六、优化
- 内存优化
防止内存泄漏，dispose需要销毁的listener
- 列表优化
分页加载
使用ListView.build()来复用子控件

## 七、打包发布
- app名字的修改

- android

  ```xml
    <application
          android:name="io.flutter.app.FlutterApplication"
          android:icon="@mipmap/ic_launcher"
          android:label="Flutter旅行"
          tools:ignore="GoogleAppIndexingWarning"/>
  ```

- flutter
```dart
MaterialApp(
    title:'flutter_trip'// snapshot名字,
    theme:'',
    home:'',
)
```

- 打包apk
  - 工具栏打包工具
  - 命令：flutter build apk

## 空安全

sdk支持空安全版本 >= 2.12.0

```
environment:
  sdk: ">=2.12.0 <3.0.0" //sdk >=2.12.0表示开启空安全检查
```

### 空安全解决

```
required
!
?
??
```

升级SDK后，iOS导致的问题及解决

```
The iOS Simulator deployment target 'IPHONEOS_DEPLOYMENT_TARGET' is set to 4.3,
but the range of supported deployment target versions is 9.0 to 15.2.99. (in target 'Toast' from project 'Pods')
```

解决

```
post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
  end
 end
end
```

iOS端报错Flutter/Flutter.h' file not found，Flutter系统的头文件找不到
解决方法：
方法一：
1.直接删除Podfile.lock文件
2.flutter clean
3.运行
（此方法可解决大部分问题）

方法二：
1.从项目中删除ios / Flutter / Flutter.framework
2.进入ios项目目录
3.pod install 应该生成Flutter.framework

运行
方法三：
1.flutter create .
2.flutter pub cache repair
3.cd ios
4.pod init
5.pod install
（如果使用了很多三方插件并且进行了源码修改，此方法慎用～且github极其不稳定，很容易下次出错）

方法四：
1.rm iOS/Flutter/Flutter.podspec
2.flutter clean
3.运行
(解决问题)

如果以上方法都没有效果， 建议更新pod到最新


或者另一种解决方案：
删除 项目根目录/ios/Flutter/Flutter.framework
执行命令

flutter clean
flutter pub get
cd ios
pod install

### webview 找不到
```
Lexical or Preprocessor Issue (Xcode): 'Flutter/Flutter.h' file not found
/Users/laychv/SDK/flutter/.pub-cache/hosted/pub.flutter-io.cn/webview_flutter_wkwebview-2.7.1/ios/Classes/FLTWKProgressionDelegate.h:4:8
```

“Lexical or Preprocessor Issue ‘*.h’ file not found”。