import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/core/cubit/invitation_theme_core_cubit.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_invitation_theme/src/widgets/particle_sphere.dart';

class TabConfig {
  const TabConfig({
    required this.useGlassEffect,
    this.useBackdropBlur = true,
    this.widthFull = false,
    required this.indicatorColor,
    required this.backgroundColor,
    required this.titleActiveColor,
    required this.titleInactiveColor,
    required this.iconActiveColor,
    required this.iconInactiveColor,
  });

  final bool useGlassEffect;
  final bool useBackdropBlur;
  final bool widthFull;
  final Color indicatorColor;
  final Color backgroundColor;
  final Color titleActiveColor;
  final Color titleInactiveColor;
  final Color iconActiveColor;
  final Color iconInactiveColor;
}

class PageViewWithBottomTabBar extends StatefulWidget {
  const PageViewWithBottomTabBar({
    super.key,
    this.heightAdjustment = 0,
    this.initialPage = 0,
    this.viewAsImage = false,
    required this.wrapper,
    this.backgrounds,
    this.particleSphere,
    required this.tabConfig,
    required this.pages,
    required this.tabsBuilder,
  });

  final double heightAdjustment;
  final int initialPage;
  final bool viewAsImage;
  final Widget wrapper;
  final List<Widget>? backgrounds;
  final ParticleSphereConfig? particleSphere;
  final TabConfig tabConfig;
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
              if (widget.particleSphere != null)
                ClipRect(
                  child: ParticleSphere(config: widget.particleSphere!, child: _page),
                )
              else
                _page,
              ValueListenableBuilder(
                valueListenable: _isLowerTab,
                builder: (_, isLowerTab, _) => AnimatedPositioned(
                  bottom: isLowerTab ? -55 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: SizedBox(
                    width: Screen.width,
                    child: Padding(
                      padding: .symmetric(vertical: 12, horizontal: widget.tabConfig.widthFull ? 0 : 14),
                      child: Stack(
                        children: [
                          if (widget.tabConfig.useBackdropBlur)
                            RepaintBoundary(
                              child: ClipRRect(
                                borderRadius: .circular(36),
                                child: BackdropFilter(filter: .blur(sigmaX: 5, sigmaY: 5), child: _tab),
                              ),
                            )
                          else
                            _tab,
                          if (widget.tabConfig.useGlassEffect && _indexActive.value > 0)
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
              if (!widget.viewAsImage) widget.wrapper,
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

  Widget get _page => SizedBox(
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
  );

  Widget get _tab => SizedBox(
    height: 52,
    child: DecoratedBox(
      decoration: BoxDecoration(color: widget.tabConfig.backgroundColor, borderRadius: .circular(36)),
      child: TabBar(
        tabs: _tabs,
        controller: _tabController,
        onTap: (value) {
          _isTabTaped = true;
          _pageController.animateToPage(value, duration: const Duration(milliseconds: 300), curve: Curves.ease);
          _indexActive.value = value;
        },
        isScrollable: true,
        padding: const .symmetric(horizontal: 14),
        dividerHeight: 0,
        tabAlignment: .start,
        indicatorWeight: 5,
        indicator: UnderlineTabIndicator(
          borderRadius: .circular(2),
          borderSide: BorderSide(width: 4, color: widget.tabConfig.indicatorColor),
          insets: const .fromLTRB(0, 0, 0, 45),
        ),
        splashBorderRadius: .circular(36),
      ),
    ),
  );
}
