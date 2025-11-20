import 'package:auto_route/auto_route.dart';

import '../../features/login/view/login_page.dart';
import '../../features/home/view/home_page.dart';
import '../../features/main/view/main_tabs_page.dart';
import '../../features/splash/view/splash_page.dart';
import '../../features/profile/view/profile_page.dart';
import '../../features/settings/view/settings_page.dart';
import '../../features/notifications/view/notifications_page.dart';
import '../../features/help/view/help_page.dart';
import '../storage/storage_manager.dart';

part 'app_router.gr.dart';

/// 应用路由配置
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // 启动页
    AutoRoute(
      page: SplashRoute.page,
      initial: true,
    ),

    // 登录页
    AutoRoute(
      page: LoginRoute.page,
    ),

    AutoRoute(
      page: MainTabsRoute.page,
      children: [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: HelpRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ],
    ),
  ];
}

/// 认证守卫
class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final isLoggedIn = await StorageManager.isLoggedIn();

    if (isLoggedIn) {
      // 已登录，允许访问
      resolver.next(true);
    } else {
      // 未登录，重定向到登录页
      resolver.redirect(LoginRoute());
    }
  }
}
