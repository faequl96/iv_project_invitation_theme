import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/ethnic_theme/ethnic_configs.dart';

class EthnicCore extends StatefulWidget {
  const EthnicCore({
    super.key,
    required this.wrapper,
    this.backgrounds,
    required this.tabConfig,
    required this.pages,
    required this.tabsBuilder,
  });

  final Widget wrapper;
  final List<Widget>? backgrounds;
  final EthnicTabConfig tabConfig;
  final List<Widget> pages;
  final List<Widget> Function(ValueNotifier<int> tabActive) tabsBuilder;

  @override
  State<EthnicCore> createState() => _EthnicCoreState();
}

class _EthnicCoreState extends State<EthnicCore> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  PageController? _pageController;

  List<Widget> _tabs = [];

  late final ValueNotifier<int> _indexActive;
  bool _isTabTaped = false;

  final _isLowerTab = ValueNotifier(true);

  late final InvitationThemeCoreCubit _coreCubit;

  @override
  void initState() {
    super.initState();

    _indexActive = ValueNotifier(0);
    _buildTabs();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _pageController = PageController();

    _coreCubit = context.read<InvitationThemeCoreCubit>();

    _pageController?.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _pageController?.removeListener(_scrollListener);

    _tabController?.dispose();
    _pageController?.dispose();

    _indexActive.dispose();
    _isLowerTab.dispose();

    super.dispose();
  }

  void _buildTabs() => _tabs = widget.tabsBuilder(_indexActive);

  void _scrollListener() async {
    final offset = _pageController?.page ?? 0;
    final offsetPage = (offset - offset.floor()).abs();
    if (offsetPage < .01) {
      if (_coreCubit.state.animationTrigger == 0) {
        await Future<void>.delayed(const Duration(milliseconds: 50));
        _coreCubit.state.copyWith(animationTrigger: 1, pageActive: _indexActive.value).emitState();
      }
    } else {
      if (offsetPage < .96) {
        if (_coreCubit.state.animationTrigger == 1) {
          _coreCubit.state
              .copyWith(animationTrigger: 0, pageActive: _indexActive.value)
              .emitState();
        }
      } else {
        if (_coreCubit.state.animationTrigger == 0) {
          _coreCubit.state
              .copyWith(animationTrigger: 1, pageActive: _indexActive.value)
              .emitState();
        }
      }
    }
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

              _buildPage,

              ValueListenableBuilder(
                valueListenable: _isLowerTab,
                builder: (_, isLowerTab, _) => AnimatedPositioned(
                  bottom: isLowerTab ? -55 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: _buildTab,
                ),
              ),

              widget.wrapper,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _buildPage => SizedBox(
    height: Screen.height,
    width: Screen.width,
    child: PageView.builder(
      controller: _pageController,
      itemCount: widget.pages.length,
      scrollDirection: .vertical,
      itemBuilder: (_, i) => widget.pages[i],
      onPageChanged: (index) {
        if (_isTabTaped) {
          _isTabTaped = false;
        } else {
          _tabController?.animateTo(index);
          _indexActive.value = index;
        }

        _isLowerTab.value = index == 0 || index == _tabs.length - 1 ? true : false;
      },
    ),
  );

  Widget get _buildTab => SizedBox(
    width: Screen.width,
    child: Padding(padding: const .symmetric(vertical: 12, horizontal: 14), child: _buildTabBar),
  );

  Widget get _buildTabBar => SizedBox(
    height: 52,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: widget.tabConfig.backgroundColor,
        borderRadius: .circular(36),
      ),
      child: TabBar(
        tabs: _tabs,
        controller: _tabController,
        onTap: (value) {
          _isTabTaped = true;
          _pageController?.animateToPage(
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
          borderSide: BorderSide(width: 4, color: widget.tabConfig.indicatorColor),
          insets: const .fromLTRB(0, 0, 0, 45),
        ),
        splashBorderRadius: .circular(36),
      ),
    ),
  );
}
