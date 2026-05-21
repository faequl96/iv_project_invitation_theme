import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/core/cubit/invitation_theme_core_cubit.dart';
import 'package:iv_project_invitation_theme/src/page_types/page_view_with_bottom_tab_bar_config.dart';
import 'package:iv_project_invitation_theme/src/widgets/particle_sphere.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';

class PageViewWithBottomTabBarAsSinglePage extends StatefulWidget {
  const PageViewWithBottomTabBarAsSinglePage({
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
  State<PageViewWithBottomTabBarAsSinglePage> createState() =>
      _PageViewWithBottomTabBarAsSinglePageState();
}

class _PageViewWithBottomTabBarAsSinglePageState extends State<PageViewWithBottomTabBarAsSinglePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  List<Widget> _tabs = [];
  void _buildTabs() => _tabs = widget.tabsBuilder(_indexActive);

  late final int _indexActive;

  late final InvitationThemeCoreCubit _coreCubit;

  @override
  void initState() {
    super.initState();

    _indexActive = widget.initialPage;
    _buildTabs();
    _tabController = TabController(
      initialIndex: widget.initialPage,
      length: _tabs.length,
      vsync: this,
    );

    _coreCubit = context.read<InvitationThemeCoreCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      if (widget.initialPage == 0) {
        if (widget.wrapper == null) _coreCubit.state.copyWith(animationTrigger: 1).emitState();
      } else {
        _coreCubit.state.copyWith(animationTrigger: 1).emitState();
      }
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();

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
              ...?widget.backgrounds,
              if (widget.particleSphere != null) ...[
                if (widget.particleSphere!.type == .circle)
                  ClipRect(
                    child: CircleParticleSphere(
                      config: widget.particleSphere!,
                      initialPage: widget.initialPage,
                      viewAsSinglePage: true,
                      useWrapper: widget.wrapper != null,
                      child: SizedBox(
                        height: Screen.height,
                        width: Screen.width,
                        child: widget.page,
                      ),
                    ),
                  )
                else
                  ClipRect(
                    child: ImageParticleSphere(
                      config: widget.particleSphere!,
                      initialPage: widget.initialPage,
                      viewAsSinglePage: true,
                      useWrapper: widget.wrapper != null,
                      child: SizedBox(
                        height: Screen.height,
                        width: Screen.width,
                        child: widget.page,
                      ),
                    ),
                  ),
              ] else
                SizedBox(height: Screen.height, width: Screen.width, child: widget.page),

              Positioned(
                bottom: widget.initialPage == 0 || widget.initialPage == _tabs.length - 1 ? -55 : 0,
                child: _tab,
              ),

              ?widget.wrapper,

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
            ),
        ],
      ),
    ),
  );

  Widget get _tabBar => SizedBox(
    height: 52,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: widget.tabConfig.backgroundColor,
        borderRadius: .circular(36),
      ),
      child: TabBar(
        tabs: _tabs,
        controller: _tabController,
        onTap: (value) {},
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
