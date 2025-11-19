import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

import '../../../common/widgets/app_button.dart';
import '../../../common/utils/app_utils.dart';
import '../view_model/login_view_model.dart';

/// 登录页面
@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  int _countdown = 0;
  Timer? _timer;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginViewModelProvider);
    final loginNotifier = ref.read(loginViewModelProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                SizedBox(height: 60.h),
                
                // Logo 和标题
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 80.w,
                        height: 80.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Icon(
                          Icons.flash_on,
                          size: 40.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        '欢迎回来',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '请登录您的账户',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 48.h),
                
                // 手机号输入框
                TextFormField(
                  controller: _usernameController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: '手机号',
                    hintText: '请输入手机号',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入手机号';
                    }
                    if (!AppUtils.isValidPhone(value)) {
                      return '请输入有效的手机号';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 16.h),
                
                // 验证码输入框
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: '验证码',
                    hintText: '请输入验证码',
                    prefixIcon: const Icon(Icons.sms_outlined),
                    suffixIcon: TextButton(
                      onPressed: (_countdown > 0 || loginState.isLoading)
                          ? null
                          : _handleSendCode,
                      child: Text(
                        _countdown > 0 ? '重新发送(${_countdown}s)' : '获取验证码',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入验证码';
                    }
                    if (!RegExp(r'^\d{4,6}$').hasMatch(value)) {
                      return '请输入4-6位数字验证码';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 24.h),
                
                // 登录按钮
                AppButton.primary(
                  text: '登录',
                  isLoading: loginState.isLoading,
                  onPressed: () => _handleLogin(loginNotifier),
                ),
                
                SizedBox(height: 16.h),
                
                // 忘记密码
                Center(
                  child: TextButton(
                    onPressed: () {
                      // TODO: 实现忘记密码功能
                    },
                    child: Text(
                      '忘记密码？',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 24.h),
                
                // 注册提示
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '还没有账户？',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14.sp,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: 跳转到注册页面
                      },
                      child: Text(
                        '立即注册',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 处理登录
  void _handleLogin(LoginViewModel loginNotifier) {
    if (_formKey.currentState?.validate() ?? false) {
      loginNotifier.login(
        context: context,
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }

  void _handleSendCode() {
    final phone = _usernameController.text.trim();
    if (!AppUtils.isValidPhone(phone)) {
      AppUtils.showError('请输入有效的手机号');
      return;
    }
    AppUtils.showSuccess('验证码已发送');
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() {
      _countdown = 60;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_countdown <= 1) {
        t.cancel();
        setState(() {
          _countdown = 0;
        });
      } else {
        setState(() {
          _countdown -= 1;
        });
      }
    });
  }
}