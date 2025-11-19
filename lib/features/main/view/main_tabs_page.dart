import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/router/app_router.dart';
import '../../../common/themes/app_theme.dart';

@RoutePage()
class MainTabsPage extends StatelessWidget {
  const MainTabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        HelpRoute(),
        ProfileRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: _CustomBottomAppBar(
            activeIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
          ),
        );
      },
    );
  }
}

class _CustomBottomAppBar extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int> onTap;

  const _CustomBottomAppBar({
    super.key,
    required this.activeIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final bottomTheme = Theme.of(context).extension<AppBottomBarTheme>();
    final items = const [
      (Icons.home_outlined, Icons.home, '首页'),
      (Icons.inventory_2_outlined, Icons.inventory_2, '空间'),
      (Icons.person_outline, Icons.person, '我的'),
    ];

    final bgColor = bottomTheme?.background ?? Theme.of(context).colorScheme.surface;
    final iconSelected = bottomTheme?.iconSelected ?? Theme.of(context).colorScheme.primary;
    final textSelected = bottomTheme?.textSelected ?? Theme.of(context).colorScheme.primary;
    final textUnselected = bottomTheme?.textUnselected ?? const Color(0x99FFFFFF);
    final iconUnselected = bottomTheme?.iconUnselected ?? textUnselected;
    final shadowColor = bottomTheme?.shadowColor ?? Colors.black.withValues(alpha: 0.06);
    final blurSigma = bottomTheme?.blurSigma ?? 12.0;
    final barHeight = bottomTheme?.height ?? 80.0;

    return BottomAppBar(
      elevation: 0,
      color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: MediaQuery.removeViewPadding(
              context: context,
              removeLeft: true,
              removeRight: true,
              removeTop: true,
              removeBottom: false,
              child: MediaQuery.removePadding(
                context: context,
                removeLeft: true,
                removeRight: true,
                removeTop: true,
                removeBottom: false,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: barHeight + bottomPadding,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor,
                        blurRadius: 20,
                        spreadRadius: 0,
                        offset: const Offset(0, -8),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: _CapsuleBorderPainter(
                        radius: 40,
                        strokeWidth: 0.5,
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.topRight,
                          colors: [
                            Color.fromRGBO(255, 255, 255, 0.2),
                            Color.fromRGBO(255, 255, 255, 0.0),
                          ],
                          stops: [0.0, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Row(
                    children: List.generate(items.length, (i) {
                      final selected = i == activeIndex;
                      final (icon, selectedIcon, label) = items[i];
                      return Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => onTap(i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 220),
                            curve: Curves.easeOut,
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.transparent,
                            ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                              children: [
                            Builder(builder: (_) {
                              final s = selected ? 22.0 : 20.0;
                              if (i == 0) {
                                return SvgPicture.asset(
                                  selected ? 'assets/icons/icon_home_selected.svg' : 'assets/icons/icon_home.svg',
                                  width: s,
                                  height: s,
                                );
                              } else if (i == 1) {
                                return SvgPicture.asset(
                                  selected ? 'assets/icons/icon_space_selected.svg' : 'assets/icons/icon_space.svg',
                                  width: s,
                                  height: s,
                                );
                              } else if (i == 2) {
                                return SvgPicture.asset(
                                  selected ? 'assets/icons/icon_me_selected.svg' : 'assets/icons/icon_me.svg',
                                  width: s,
                                  height: s,
                                );
                              }
                              return Icon(
                                selected ? selectedIcon : icon,
                                color: selected ? iconSelected : iconUnselected,
                                size: s,
                              );
                            }),
                                const SizedBox(height: 4),
                                Text(
                                  label,
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 1.0,
                                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                                    color: selected ? textSelected : textUnselected,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            )),
          ),
          ),
      ),
    );
  }
}

class _CapsuleBorderPainter extends CustomPainter {
  final double radius;
  final double strokeWidth;
  final LinearGradient gradient;

  const _CapsuleBorderPainter({
    required this.radius,
    required this.strokeWidth,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final clipHeight = strokeWidth * 3;
    final rrect = RRect.fromRectAndRadius(
      rect.deflate(strokeWidth / 2),
      Radius.circular(radius),
    );

    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, clipHeight));

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeJoin = StrokeJoin.round
      ..shader = gradient.createShader(rect);

    canvas.drawRRect(rrect, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CapsuleBorderPainter oldDelegate) {
    return oldDelegate.radius != radius ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gradient != gradient;
  }
}