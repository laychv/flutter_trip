# flutter仿携程app

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

## 5. 自定义组件
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

## 二.搜索模块

### 1.自定义搜索栏

### 2.集成AI语音

---

## 三.旅拍模块

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

## 启动白屏问题

