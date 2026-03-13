import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/core/cubit/invitation_theme_core_cubit.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';

class PageViewWithBottomTabBar extends StatefulWidget {
  const PageViewWithBottomTabBar({
    super.key,
    this.heightAdjustment = 0,
    this.initialPage = 0,
    this.viewAsImage = false,
    required this.wrapper,
    this.backgrounds,
    this.tabIndicatorColor,
    required this.tabBackgroundColor,
    this.useGlassEffectOnTab = false,
    required this.pages,
    required this.tabsBuilder,
  });

  final double heightAdjustment;
  final int initialPage;
  final bool viewAsImage;
  final Widget wrapper;
  final List<Widget>? backgrounds;
  final Color? tabIndicatorColor;
  final Color tabBackgroundColor;
  final bool useGlassEffectOnTab;
  final List<Widget> pages;
  final List<Widget> Function(ValueNotifier<int> tabActive) tabsBuilder;

  @override
  State<PageViewWithBottomTabBar> createState() => _PageViewWithBottomTabBarState();
}

class _PageViewWithBottomTabBarState extends State<PageViewWithBottomTabBar> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final PageController _pageController;

  List<Widget> _tabs = [];
  void _buildTabs() => _tabs = widget.tabsBuilder(_indexActive);

  late final ValueNotifier<int> _indexActive;
  bool _isTabTaped = false;

  final _isLowerTab = ValueNotifier(true);

  late final InvitationThemeCoreCubit _coreCubit;

  void _scrollListener() async {
    final offset = _pageController.page ?? 0;
    final offsetPage = (offset - offset.floor()).abs();
    if (offsetPage < 0.01) {
      if (_coreCubit.state.animationTrigger == 0) {
        await Future<void>.delayed(const Duration(milliseconds: 50));
        _coreCubit.state.copyWith(animationTrigger: 1).emitState();
      }
    } else {
      if (offsetPage < 0.96) {
        if (_coreCubit.state.animationTrigger == 1) {
          _coreCubit.state.copyWith(animationTrigger: 0).emitState();
        }
      } else {
        if (_coreCubit.state.animationTrigger == 0) {
          _coreCubit.state.copyWith(animationTrigger: 1).emitState();
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _indexActive = ValueNotifier(widget.initialPage);
    _buildTabs();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _pageController = PageController();

    _coreCubit = context.read<InvitationThemeCoreCubit>();

    _pageController.addListener(_scrollListener);

    if (widget.viewAsImage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.initialPage == 0) {
          _coreCubit.state.copyWith(animationTrigger: 1).emitState();
        } else {
          _pageController.jumpToPage(_indexActive.value);
        }
      });
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_scrollListener);

    _tabController.dispose();
    _pageController.dispose();

    _indexActive.dispose();
    _isLowerTab.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, size) => Center(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            alignment: .center,
            children: [
              ...(widget.backgrounds ?? []),
              SizedBox(
                height: Screen.height,
                width: Screen.width,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.pages.length,
                  scrollDirection: .vertical,
                  itemBuilder: (_, i) => (i == 0 && widget.initialPage != 0) ? const SizedBox.shrink() : widget.pages[i],
                  onPageChanged: (index) {
                    if (_isTabTaped) {
                      _isTabTaped = false;
                    } else {
                      _tabController.animateTo(index);
                      _indexActive.value = index;
                    }

                    _isLowerTab.value = index == 0 || index == _tabs.length - 1 ? true : false;
                  },
                ),
              ),
              ValueListenableBuilder(
                valueListenable: _isLowerTab,
                builder: (_, isLowerTab, _) => AnimatedPositioned(
                  bottom: isLowerTab ? -55 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: SizedBox(
                    width: Screen.width,
                    child: Padding(
                      padding: const .symmetric(vertical: 12, horizontal: 14),
                      child: Stack(
                        children: [
                          RepaintBoundary(
                            child: ClipRRect(
                              borderRadius: .circular(36),
                              child: BackdropFilter(
                                filter: .blur(sigmaX: 5, sigmaY: 5),
                                child: SizedBox(
                                  height: 52,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(color: widget.tabBackgroundColor, borderRadius: .circular(36)),
                                    child: TabBar(
                                      tabs: _tabs,
                                      controller: _tabController,
                                      onTap: (value) {
                                        _isTabTaped = true;
                                        _pageController.animateToPage(
                                          value,
                                          duration: const Duration(milliseconds: 300),
                                          curve: Curves.ease,
                                        );
                                        _indexActive.value = value;
                                      },
                                      isScrollable: true,
                                      padding: const .symmetric(horizontal: 14),
                                      dividerHeight: 0,
                                      tabAlignment: .start,
                                      indicatorWeight: 5,
                                      indicator: UnderlineTabIndicator(
                                        borderRadius: .circular(2),
                                        borderSide: BorderSide(width: 4, color: widget.tabIndicatorColor ?? Colors.grey.shade50),
                                        insets: const .fromLTRB(0, 0, 0, 45),
                                      ),
                                      splashBorderRadius: .circular(36),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (widget.useGlassEffectOnTab && _indexActive.value > 0)
                            GlassEffectBox(
                              width: Screen.width - 28,
                              height: 52,
                              borderRadius: 36,
                              animationSpeed: const Duration(milliseconds: 600),
                              animationInterval: const Duration(seconds: 7),
                              delayBeforeStart: const Duration(milliseconds: 1200),
                              color: Colors.grey.shade300.withValues(alpha: .5),
                              sliderWidth: 90,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              widget.wrapper,
              if (widget.viewAsImage)
                const SizedBox(
                  height: .maxFinite,
                  width: .maxFinite,
                  child: ColoredBox(color: Colors.transparent),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
