import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/utils/edge_insets_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/shape_scale.dart';

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

  late final TryThemeCubit _tryThemeCubit;

  void _scrollListener() {
    final offset = _pageController.page ?? 0;
    if ((offset - offset.floor()).abs() < 0.01) {
      if (_tryThemeCubit.state.countdownsTimerAnimationTrigger == 0) {
        _tryThemeCubit.state.copyWith(countdownsTimerAnimationTrigger: 1).emitState();
      }
    } else {
      if (_tryThemeCubit.state.countdownsTimerAnimationTrigger == 1) {
        _tryThemeCubit.state.copyWith(countdownsTimerAnimationTrigger: 0).emitState();
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

    _tryThemeCubit = context.read<TryThemeCubit>();

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
        if (size.height < 812) {
          finalSize = Size(375, size.height - (padding.top + padding.bottom));
        } else {
          finalSize = const Size(375, 812);
        }
      } else {
        finalSize = Size(size.width, size.height - (padding.top + padding.bottom));
      }

      ScreenUtil.set(finalSize);
      FontScale.set(finalSize.width);
      ShapeScale.set(finalSize);
      EdgeInsetsScale.set(finalSize.width);

      _tryThemeCubit.state.copyWith(size: finalSize).emitState();
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
              bottom: indexActive > 0 ? 0 : -60,
              duration: const Duration(milliseconds: 300),
              child: SizedBox(
                width: ScreenUtil.size.width,
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                  color: Colors.grey.shade800.withValues(alpha: .3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
                  clipBehavior: Clip.hardEdge,
                  child: TabBar(
                    controller: _tabController,
                    onTap: (value) {
                      _isTabTaped = true;
                      _tabIndexTaped = value;
                      _pageController.animateToPage(value, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                      _buildTabs(value);
                      _indexActive.value = value;
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    indicatorWeight: 5,
                    dividerHeight: 0,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    indicator: UnderlineTabIndicator(
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(3), bottomRight: Radius.circular(3)),
                      borderSide: BorderSide(width: 4, color: Colors.grey.shade200),
                      insets: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 48.0),
                    ),
                    tabs: _tabs,
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
