import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/theme_family/ethnic_theme/ethnic_configs.dart';

class EthnicCoreAsImage extends StatefulWidget {
  const EthnicCoreAsImage({
    super.key,
    this.initialPage = 0,
    this.wrapper,
    this.backgrounds,
    required this.tabConfig,
    required this.page,
    required this.tabsBuilder,
  });

  final int initialPage;
  final Widget? wrapper;
  final List<Widget>? backgrounds;
  final EthnicTabConfig tabConfig;
  final Widget page;
  final List<Widget> Function(int tabActive) tabsBuilder;

  @override
  State<EthnicCoreAsImage> createState() => _EthnicCoreAsImageState();
}

class _EthnicCoreAsImageState extends State<EthnicCoreAsImage> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  List<Widget> _tabs = [];

  late final int _indexActive;

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
  }

  @override
  void dispose() {
    _tabController?.dispose();

    super.dispose();
  }

  void _buildTabs() => _tabs = widget.tabsBuilder(_indexActive);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Screen.height,
      width: Screen.width,
      child: Stack(
        alignment: .center,
        children: [
          ...?widget.backgrounds,

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
    );
  }

  Widget get _tab => SizedBox(
    width: Screen.width,
    child: Padding(padding: const .symmetric(vertical: 12, horizontal: 14), child: _tabBar),
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
