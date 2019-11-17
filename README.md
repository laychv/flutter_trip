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
    title:'Flutter旅行'// snapshot名字,
    theme:'',
    home:'',
)
```

- 打包apk
  - 工具栏打包工具
  - 命令：flutter build apk 