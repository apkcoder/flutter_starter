import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/log/app_logger.dart';
import '../../../core/router/app_router.dart';
import '../../../core/storage/storage_manager.dart';
import '../data/login_repository.dart';
import '../data/models/login_models.dart';

/// 登录状态
class LoginState {
  final bool isLoading;
  final String? error;

  const LoginState({
    this.isLoading = false,
    this.error,
  });

  LoginState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// 登录 ViewModel
class LoginViewModel extends StateNotifier<LoginState> {
  LoginViewModel() : super(const LoginState());
  final LoginRepository _repository = LoginRepository();

  /// 登录
  Future<void> login({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      AppLogger.info('开始登录: $username');
      final req = LoginRequest(phone: username, code: password);
      final resp = await _repository.login(req);
      await StorageManager.saveToken(resp.token);
      await StorageManager.saveUserInfo(resp.user);
      AppLogger.info('登录成功: $username');
      Fluttertoast.showToast(msg: '登录成功');
      if (context.mounted) {
        context.router.replace(const MainTabsRoute());
      }

    } catch (e) {
      AppLogger.error('登录失败', error: e);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );

      Fluttertoast.showToast(
        msg: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  /// 保存用户数据
  

  /// 清除错误
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// 登录 ViewModel Provider
final loginViewModelProvider = StateNotifierProvider<LoginViewModel, LoginState>((ref) {
  return LoginViewModel();
});