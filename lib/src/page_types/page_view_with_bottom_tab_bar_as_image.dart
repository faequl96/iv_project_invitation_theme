import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/page_types/page_view_with_bottom_tab_bar_config.dart';
import 'package:iv_project_invitation_theme/src/widgets/atlas_particle_sphere.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';

class PageViewWithBottomTabBarAsImage extends StatefulWidget {
  const PageViewWithBottomTabBarAsImage({
    super.key,
    this.initialPage = 0,
    this.wrapper,
    this.backgrounds,
    this.particleSphere,
    required this.tabConfig,
    required this.page,
    required this.tabsBuilder,
  });

  final int initialPage;
  final Widget? wrapper;
  final List<Widget>? backgrounds;
  final ParticleSphereConfig? particleSphere;
  final PageViewWithBottomTabBarConfig tabConfig;
  final Widget page;
  final List<Widget> Function(int tabActive) tabsBuilder;

  @override
  State<PageViewWithBottomTabBarAsImage> createState() => _PageViewWithBottomTabBarAsImageState();
}

class _PageViewWithBottomTabBarAsImageState extends State<PageViewWithBottomTabBarAsImage> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  List<Widget> _tabs = [];
  void _buildTabs() => _tabs = widget.tabsBuilder(_indexActive);

  late final int _indexActive;

  @override
  void initState() {
    super.initState();

    _indexActive = widget.initialPage;
    _buildTabs();
    _tabController = TabController(initialIndex: widget.initialPage, length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Screen.height,
      width: Screen.width,
      child: Stack(
        alignment: .center,
        children: [
          ...(widget.backgrounds ?? []),
          if (widget.particleSphere != null && widget.wrapper == null)
            ClipRect(
              child: CircleParticleSphereAsImage(
                config: widget.particleSphere!,
                child: SizedBox(height: Screen.height, width: Screen.width, child: widget.page),
              ),
            )
          else
            SizedBox(height: Screen.height, width: Screen.width, child: widget.page),

          Positioned(bottom: widget.initialPage == 0 || widget.initialPage == _tabs.length - 1 ? -55 : 0, child: _tab),

          widget.wrapper ?? const SizedBox.shrink(),

          const SizedBox(
            height: .maxFinite,
            width: .maxFinite,
            child: ColoredBox(color: Colors.transparent),
          ),
        ],
      ),
    );
  }

  Widget get _tab => SizedBox(
    width: Screen.width,
    child: Padding(
      padding: .symmetric(vertical: 12, horizontal: widget.tabConfig.widthFull ? 0 : 14),
      child: Stack(
        children: [
          if (widget.tabConfig.useBackdropBlur)
            RepaintBoundary(
              child: ClipRRect(
                borderRadius: .circular(36),
                child: BackdropFilter(filter: .blur(sigmaX: 5, sigmaY: 5), child: _tabBar),
              ),
            )
          else
            _tabBar,
          if (widget.tabConfig.useGlassEffect && _indexActive > 0)
            GlassEffectBox(
              width: Screen.width - 28,
              height: 52,
              borderRadius: 36,
              animationSpeed: const Duration(milliseconds: 600),
              animationInterval: const Duration(seconds: 7),
              delayBeforeStart: const Duration(milliseconds: 1200),
              color: Colors.grey.shade300.withValues(alpha: .5),
              sliderWidth: 90,
              staticValue: .75,
            ),
        ],
      ),
    ),
  );

  Widget get _tabBar => SizedBox(
    height: 52,
    child: DecoratedBox(
      decoration: BoxDecoration(color: widget.tabConfig.backgroundColor, borderRadius: .circular(36)),
      child: TabBar(
        tabs: _tabs,
        controller: _tabController,
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
