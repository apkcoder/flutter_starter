# LuSun TeleprompterFlutter 

基于Flutter Rapid Framework 快速开发框架搭建

## 🏗️ 项目结构

```
lib/
├── app.dart                    # 应用根组件
├── main.dart                   # 应用入口
├── bootstrap.dart              # 框架启动入口
│
├── core/                       # 核心能力模块
│   ├── config/                 # 环境配置、多端变量
│   ├── router/                 # 路由系统（AutoRoute 注解式路由 + 类型安全）
│   ├── network/                # 网络请求封装（Dio + 拦截器 + 错误处理）
│   ├── storage/                # 本地缓存（Hive/SharedPrefs 封装）
│   └── log/                    # 日志系统（debugLog、crashLog、打点等）
│
├── common/                     # 通用模块
│   ├── widgets/                # 通用组件库（统一按钮、加载框、空状态）
│   ├── utils/                  # 工具类（时间、字符串、Toast、Debounce）
│   └── themes/                 # 主题（暗色、字号、全局 padding）
│
├── features/                   # 业务模块按"页面为单位"分包
│   ├── splash/                 # 启动页
│   ├── login/                  # 登录模块
│   └── home/                   # 主页模块
│
└── l10n/                       # 国际化资源
```

## 🚀 快速开始

### 1. 安装依赖

```bash
flutter pub get
```

### 2. 运行项目

```bash
flutter run
```

### 3. 登录测试

- 用户名：`admin`
- 密码：`123456`

## 🧩 核心模块介绍

### 网络请求模块

基于 Dio 封装，提供统一的网络请求接口：

```dart
// GET 请求
final response = await NetworkManager.get('/api/users');

// POST 请求
final response = await NetworkManager.post('/api/login', data: {
  'username': 'admin',
  'password': '123456',
});
```

### 本地存储模块

统一的本地存储接口，支持 SharedPreferences 和 Hive：

```dart
// 保存用户 Token
await StorageManager.saveToken('your_token');

// 获取用户 Token
final token = await StorageManager.getToken();

// 保存用户信息
await StorageManager.saveUserInfo(userInfo);
```

### 路由管理模块

基于 AutoRoute 的类型安全路由，支持注解式声明：

```dart
// 1. 在页面类上添加 @RoutePage() 注解
@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  // ...
}

// 2. 使用类型安全的导航
context.router.push(const HomeRoute());
context.router.replace(const LoginRoute());

// 3. 带参数的路由导航
context.router.push(UserProfileRoute(userId: '123'));

// 4. 退出登录
await StorageManager.clearToken();
await StorageManager.clearUserInfo();
context.router.replace(const LoginRoute());
```

### 日志系统

统一的日志管理：

```dart
AppLogger.debug('调试信息');
AppLogger.info('普通信息');
AppLogger.warning('警告信息');
AppLogger.error('错误信息');
```

### 通用组件

提供常用的 UI 组件：

```dart
// 通用按钮
AppButton.primary(
  text: '登录',
  onPressed: () => _handleLogin(),
)

// 次要按钮
AppButton.secondary(
  text: '取消',
  onPressed: () => Navigator.pop(context),
)
```

## 📱 功能特性

- ✅ 统一的网络请求处理
- ✅ 本地数据持久化
- ✅ 路由管理和导航
- ✅ 主题切换支持
- ✅ 国际化支持
- ✅ 日志记录和错误处理
- ✅ 响应式设计适配
- ✅ 通用组件库

## 🛠️ 开发指南

### 添加新页面

1. 在 `lib/features/` 下创建新的模块文件夹
2. 按照现有结构创建 `view/` 和 `view_model/` 文件夹
3. 在页面类上添加 `@RoutePage()` 注解
4. 在 `lib/core/router/app_router.dart` 的 `routes` 列表中添加路由：
   ```dart
   AutoRoute(page: YourPageRoute.page)
   ```
5. 运行代码生成：
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

### 添加新的网络接口

简要流程（以 `features/login/` 为例）：

1. 在模块下创建 `data/` 与 `data/models/` 目录
2. 在 `data/models/` 中定义请求/响应模型
3. 在 `data/` 中封装 `Repository` 类，统一使用 `NetworkManager` 调用接口
4. 在 `view_model/` 中调用仓库方法，更新状态并处理错误

### 自定义主题

在 `lib/common/themes/app_theme.dart` 中修改主题配置。

## 📦 主要依赖

- `flutter_riverpod`: 状态管理
- `auto_route`: 类型安全的路由管理
- `dio`: 网络请求
- `hive`: 本地数据库
- `shared_preferences`: 轻量级存储
- `flutter_screenutil`: 屏幕适配
- `logger`: 日志记录

## 🔧 代码生成

本项目使用代码生成来简化开发，需要运行以下命令：

```bash
# 生成路由代码（首次或修改路由后）
dart run build_runner build --delete-conflicting-outputs

# 监听模式（开发时推荐）
dart run build_runner watch

# 清理并重新生成
dart run build_runner clean && dart run build_runner build --delete-conflicting-outputs
```