import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 应用主题配置
class AppTheme {
  // 主色调
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color primaryColorDark = Color(0xFF1976D2);
  static const Color primaryColorLight = Color(0xFFBBDEFB);
  
  // 辅助色
  static const Color accentColor = Color(0xFFFF4081);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color surfaceColor = Colors.white;
  
  // 文字颜色
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFF9E9E9E);
  
  // 分割线颜色
  static const Color dividerColor = Color(0xFFE0E0E0);
  
  /// 浅色主题
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.black,
      
      // 颜色方案
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        surface: surfaceColor,
        error: Colors.red,
      ),
      
      // AppBar 主题
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceColor,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      
      // 文字主题
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
          color: textPrimary,
        ),
        bodySmall: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.normal,
          color: textSecondary,
        ),
        labelLarge: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        labelMedium: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: textSecondary,
        ),
        labelSmall: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          color: textHint,
        ),
      ),
      
      // 按钮主题
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          minimumSize: Size(double.infinity, 48.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      
      // 输入框主题
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        hintStyle: TextStyle(
          color: textHint,
          fontSize: 14.sp,
        ),
      ),
      
      // 卡片主题
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      ),
      
      // 分割线主题
      dividerTheme: const DividerThemeData(
        color: dividerColor,
        thickness: 0.5,
      ),

      // 底部导航主题（对齐 Figma 视觉）
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceColor,
        indicatorColor: primaryColor.withValues(alpha: 0.12),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? primaryColor : textSecondary,
            size: 24.sp,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 12.sp,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected ? primaryColor : textSecondary,
          );
        }),
      ),

      extensions: const [
        AppBottomBarTheme(
          background: Color(0xD9000000),
          pill: Color(0xFF35F29C),
          pillAlpha: 0.0,
          iconSelected: Color(0xFF35F29C),
          iconUnselected: Color(0x99FFFFFF),
          textSelected: Color(0xFF35F29C),
          textUnselected: Color(0x99FFFFFF),
          shadowColor: Color(0x1A000000),
          blurSigma: 12,
          height: 80,
        ),
      ],
    );
  }
  
  /// 深色主题
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      
      // 颜色方案
      colorScheme: const ColorScheme.dark(
        primary: primaryColorLight,
        secondary: accentColor,
        surface: Color(0xFF1E1E1E),
        error: Colors.redAccent,
      ),
      
      // 其他主题配置与浅色主题类似，但使用深色配色
      // 这里简化处理，实际项目中可以详细配置
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF1E1E1E),
        indicatorColor: primaryColorLight.withValues(alpha: 0.16),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? primaryColorLight : Colors.grey[400],
            size: 24.sp,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 12.sp,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected ? primaryColorLight : Colors.grey[400],
          );
        }),
      ),

      extensions: const [
        AppBottomBarTheme(
          background: Color(0xD9000000),
          pill: Color(0xFF35F29C),
          pillAlpha: 0.0,
          iconSelected: Color(0xFF35F29C),
          iconUnselected: Color(0x99FFFFFF),
          textSelected: Color(0xFF35F29C),
          textUnselected: Color(0x99FFFFFF),
          shadowColor: Color(0x33000000),
          blurSigma: 12,
          height: 80,
        ),
      ],
    );
  }
}

@immutable
class AppBottomBarTheme extends ThemeExtension<AppBottomBarTheme> {
  final Color background;
  final Color pill;
  final double pillAlpha;
  final Color iconSelected;
  final Color iconUnselected;
  final Color textSelected;
  final Color textUnselected;
  final Color shadowColor;
  final double blurSigma;
  final double height;

  const AppBottomBarTheme({
    required this.background,
    required this.pill,
    required this.pillAlpha,
    required this.iconSelected,
    required this.iconUnselected,
    required this.textSelected,
    required this.textUnselected,
    required this.shadowColor,
    required this.blurSigma,
    required this.height,
  });

  @override
  AppBottomBarTheme copyWith({
    Color? background,
    Color? pill,
    double? pillAlpha,
    Color? iconSelected,
    Color? iconUnselected,
    Color? textSelected,
    Color? textUnselected,
    Color? shadowColor,
    double? blurSigma,
    double? height,
  }) {
    return AppBottomBarTheme(
      background: background ?? this.background,
      pill: pill ?? this.pill,
      pillAlpha: pillAlpha ?? this.pillAlpha,
      iconSelected: iconSelected ?? this.iconSelected,
      iconUnselected: iconUnselected ?? this.iconUnselected,
      textSelected: textSelected ?? this.textSelected,
      textUnselected: textUnselected ?? this.textUnselected,
      shadowColor: shadowColor ?? this.shadowColor,
      blurSigma: blurSigma ?? this.blurSigma,
      height: height ?? this.height,
    );
  }

  @override
  AppBottomBarTheme lerp(ThemeExtension<AppBottomBarTheme>? other, double t) {
    if (other is! AppBottomBarTheme) return this;
    return AppBottomBarTheme(
      background: Color.lerp(background, other.background, t) ?? background,
      pill: Color.lerp(pill, other.pill, t) ?? pill,
      pillAlpha: pillAlpha + (other.pillAlpha - pillAlpha) * t,
      iconSelected: Color.lerp(iconSelected, other.iconSelected, t) ?? iconSelected,
      iconUnselected: Color.lerp(iconUnselected, other.iconUnselected, t) ?? iconUnselected,
      textSelected: Color.lerp(textSelected, other.textSelected, t) ?? textSelected,
      textUnselected: Color.lerp(textUnselected, other.textUnselected, t) ?? textUnselected,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t) ?? shadowColor,
      blurSigma: blurSigma + (other.blurSigma - blurSigma) * t,
      height: height + (other.height - height) * t,
    );
  }
}