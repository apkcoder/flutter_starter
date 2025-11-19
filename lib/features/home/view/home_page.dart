import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/storage/storage_manager.dart';

/// 主页
@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Map<String, dynamic>? userInfo;

  @override
  void initState() {
    super.initState();
    userInfo = StorageManager.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            floating: false,
            expandedHeight: 260.h,
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: _BannerHeader(),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: _PrimaryActions(),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: _ShortcutRow(),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 16.h)),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: _ScriptsSection(),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _pill({required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white70, fontSize: 12.sp),
      ),
    );
  }
  
  /// 格式化登录时间
  String _formatLoginTime() {
    final loginTimeStr = userInfo?['loginTime'];
    if (loginTimeStr == null) return '未知';
    
    try {
      final loginTime = DateTime.parse(loginTimeStr);
      final now = DateTime.now();
      final difference = now.difference(loginTime);
      
      if (difference.inMinutes < 1) {
        return '刚刚';
      } else if (difference.inHours < 1) {
        return '${difference.inMinutes}分钟前';
      } else if (difference.inDays < 1) {
        return '${difference.inHours}小时前';
      } else {
        return '${loginTime.month}月${loginTime.day}日 ${loginTime.hour.toString().padLeft(2, '0')}:${loginTime.minute.toString().padLeft(2, '0')}';
      }
    } catch (e) {
      return '未知';
    }
  }
  
}

class _BannerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0C0F10),
            const Color(0xFF0C0F10),
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h),
          child: SizedBox(
            height: 160.h,
            width: double.infinity,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final tipsWidth = 185.w;
                final tipsHeight = 80.h;
                final personWidth = 200.w;
                final personHeight = 152.h;
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                      top: 16.h,
                      width: tipsWidth,
                      height: tipsHeight,
                      child: Image.asset(
                        'assets/images/img_home_tips.png',
                        fit: BoxFit.contain,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    Positioned(
                      right: 8.w,
                      top: 16.h,
                      width: personWidth,
                      height: personHeight,
                      child: Image.asset(
                        'assets/images/img_home_people.png',
                        fit: BoxFit.contain,
                        alignment: Alignment.topRight,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderTag extends StatelessWidget {
  final String text;
  const _HeaderTag({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white70, fontSize: 12.sp),
      ),
    );
  }
}

class _PrimaryActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF31D790);
    return Row(
      children: [
        Expanded(
          child: _ActionTile(
            height: 150.h,
            color: primaryColor,
            title: '开始拍摄',
            subtitle: '即刻开启高效提词',
            icon: Icons.photo_camera,
            titleColor: Colors.black,
            onTap: () {},
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            children: [
              _ActionTile(
                height: 72.h,
                color: const Color(0xFF22312A),
                title: '新建脚本',
                subtitle: '创建自己的脚本',
                icon: Icons.create,
                onTap: () {},
              ),
              SizedBox(height: 6.h),
              _ActionTile(
                height: 72.h,
                color: const Color(0xFF22312A),
                title: '文件导入',
                subtitle: '可导入文稿/视频素材',
                icon: Icons.upload_file,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  final double height;
  final Color color;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color? titleColor;
  final VoidCallback onTap;
  const _ActionTile({
    required this.height,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.titleColor,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: Colors.white, size: 26.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: titleColor ?? Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShortcutRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = const [
      _ShortcutItem(icon: Icons.report_gmailerrorred, label: '敏感词检测'),
      _ShortcutItem(icon: Icons.article_outlined, label: '文案提取'),
      _ShortcutItem(icon: Icons.auto_fix_high, label: 'AI 删除'),
      _ShortcutItem(icon: Icons.smart_toy_outlined, label: '数字人'),
      _ShortcutItem(icon: Icons.more_horiz, label: '更多'),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items
          .map((e) => Expanded(child: Center(child: e)))
          .toList(growable: false),
    );
  }
}

class _ShortcutItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ShortcutItem({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(
            color: const Color(0xFF22312A),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: Colors.white, size: 24.sp),
        ),
        SizedBox(height: 6.h),
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 12.sp),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _ScriptsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white54,
                  indicatorColor: const Color(0xFF31D790),
                  tabs: const [
                    Tab(text: '我的脚本'),
                    Tab(text: '热门脚本库'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 320.h,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _ScriptList(items: _dummyScripts()),
                _ScriptList(items: _dummyScripts(popular: true)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<_ScriptData> _dummyScripts({bool popular = false}) {
    return List.generate(3, (i) {
      return _ScriptData(
        title: popular ? '热门脚本示例 ${i + 1}' : '普通人如何拍出10W+4步口播流程',
        desc:
            '声智提词器是一款智能提词工具，适用于多场景，如直播、会议、在线录播、视频拍摄、演讲等等。',
        time: '今天 12:32',
        stats: '498字 建议录制 1 分 23秒',
      );
    });
  }
}

class _ScriptList extends StatelessWidget {
  final List<_ScriptData> items;
  const _ScriptList({required this.items});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final item = items[index];
        return _ScriptCard(data: item);
      },
    );
  }
}

class _ScriptCard extends StatelessWidget {
  final _ScriptData data;
  const _ScriptCard({required this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF121416),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  data.title,
                  style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              ),
              Icon(Icons.more_horiz, color: Colors.white54),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            data.desc,
            style: TextStyle(color: Colors.white70, fontSize: 12.sp),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(data.time, style: TextStyle(color: Colors.white54, fontSize: 12.sp)),
              SizedBox(width: 12.w),
              Text(data.stats, style: TextStyle(color: Colors.white54, fontSize: 12.sp)),
              const Spacer(),
              SizedBox(
                height: 28.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF31D790),
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999.r)),
                  ),
                  child: Text('去提词', style: TextStyle(color: Colors.black87, fontSize: 12.sp)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScriptData {
  final String title;
  final String desc;
  final String time;
  final String stats;
  _ScriptData({required this.title, required this.desc, required this.time, required this.stats});
}