import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/core/cubit/core_cubit.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/elegant_black_and_white_glass_background.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';

class PageViewWithBottomTabBar extends StatefulWidget {
  const PageViewWithBottomTabBar({super.key, required this.pages, required this.tabsBuilder});

  final List<Widget> pages;
  final List<Widget> Function(int tabActive) tabsBuilder;

  @override
  State<PageViewWithBottomTabBar> createState() => _PageViewWithBottomTabBarState();
}

class _PageViewWithBottomTabBarState extends State<PageViewWithBottomTabBar>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  List<Widget> _tabs = [];
  void _buildTabs(int tabActive) => _tabs = widget.tabsBuilder(tabActive);

  final ValueNotifier<int> _indexActive = ValueNotifier(0);
  bool _isTabTaped = false;
  int _tabIndexTaped = 0;

  late final CoreCubit _coreCubit;

  void _scrollListener() {
    final offset = _pageController.page ?? 0;
    if ((offset - offset.floor()).abs() < 0.01) {
      if (_coreCubit.state.animationTrigger == 0) {
        _coreCubit.state.copyWith(animationTrigger: 1).emitState();
      }
    } else {
      if (_coreCubit.state.animationTrigger == 1) {
        _coreCubit.state.copyWith(animationTrigger: 0).emitState();
      }
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _buildTabs(0);
    _tabController = TabController(length: _tabs.length, vsync: this);
    _pageController = PageController();

    _coreCubit = context.read<CoreCubit>();

    _pageController.addListener(_scrollListener);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    setState(() {
      final size = MediaQuery.of(GlobalContextService.value).size;
      final padding = MediaQuery.of(GlobalContextService.value).padding;

      late final Size finalSize;
      if (size.width > 440) {
        if (size.height < 915) {
          finalSize = Size(412, size.height - (padding.top + padding.bottom));
        } else {
          finalSize = const Size(412, 915);
        }
      } else {
        if (size.height < 915) {
          finalSize = Size(size.width, size.height - (padding.top + padding.bottom));
        } else {
          finalSize = Size(size.width, 915);
        }
      }

      ScreenUtil.set(finalSize);
      FontScale.set(finalSize.width);
      SizeScale.set(finalSize);

      _coreCubit.state.copyWith(size: finalSize).emitState();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _pageController.removeListener(_scrollListener);

    _tabController.dispose();
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ElegantBlackAndWhiteGlassBackground(),
        SizedBox(
          height: ScreenUtil.size.height,
          width: ScreenUtil.size.width,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.pages.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => widget.pages[index],
            onPageChanged: (index) {
              if (_isTabTaped) {
                if (index == _tabIndexTaped) {
                  _tabController.animateTo(index);
                  _buildTabs(index);
                  _indexActive.value = index;
                  _isTabTaped = false;
                }
              } else {
                _tabController.animateTo(index);
                _buildTabs(index);
                _indexActive.value = index;
              }
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: _indexActive,
          builder: (_, indexActive, _) {
            return AnimatedPositioned(
              bottom: indexActive > 0 ? 0 : -55,
              duration: const Duration(milliseconds: 300),
              child: SizedBox(
                width: ScreenUtil.size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(36),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: .5),
                              borderRadius: BorderRadius.circular(36),
                            ),
                            height: 52,
                            child: TabBar(
                              tabs: _tabs,
                              controller: _tabController,
                              onTap: (value) {
                                _isTabTaped = true;
                                _tabIndexTaped = value;
                                _pageController.animateToPage(
                                  value,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                                _buildTabs(value);
                                _indexActive.value = value;
                              },
                              isScrollable: true,
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              dividerHeight: 0,
                              tabAlignment: TabAlignment.start,
                              indicatorWeight: 5,
                              indicator: UnderlineTabIndicator(
                                borderRadius: BorderRadius.circular(2),
                                borderSide: BorderSide(width: 4, color: Colors.grey.shade50),
                                insets: const EdgeInsets.fromLTRB(0, 0, 0, 45),
                              ),
                              splashBorderRadius: BorderRadius.circular(36),
                            ),
                          ),
                        ),
                      ),
                      if (indexActive > 0)
                        GlassEffectBox(
                          width: ScreenUtil.size.width - 28,
                          height: 52,
                          borderRadius: 36,
                          animationSpeed: const Duration(milliseconds: 600),
                          animationInterval: const Duration(seconds: 3),
                          delayBeforeStart: const Duration(milliseconds: 1200),
                          color: Colors.grey.shade300.withValues(alpha: .5),
                          sliderWidth: 90,
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
