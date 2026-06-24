import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/core/cubit/invitation_theme_core_cubit.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/particle_sphere.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class GeminiStarCore extends StatefulWidget {
  const GeminiStarCore({
    super.key,
    required this.wrapper,
    this.backgrounds,
    this.particleSphere,
    required this.pages,
    required this.navs,
  });

  final Widget wrapper;
  final List<Widget>? backgrounds;
  final ParticleSphereConfig? particleSphere;
  final List<Widget> pages;
  final List<Widget> navs;

  @override
  State<GeminiStarCore> createState() => _GeminiStarCoreState();
}

class _GeminiStarCoreState extends State<GeminiStarCore> {
  PageController? _pageController;

  late final ValueNotifier<int> _indexActive;

  late final InvitationThemeCoreCubit _coreCubit;

  @override
  void initState() {
    super.initState();

    _indexActive = ValueNotifier(0);
    _pageController = PageController();

    _coreCubit = context.read<InvitationThemeCoreCubit>();

    _pageController?.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _pageController?.removeListener(_scrollListener);

    _pageController?.dispose();

    _indexActive.dispose();

    super.dispose();
  }

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
          child: ColoredBox(
            color: Colors.white,
            child: Stack(
              alignment: .center,
              children: [
                ...?widget.backgrounds,

                if (widget.particleSphere != null) ...[
                  if (widget.particleSphere!.type == .circle)
                    ClipRect(
                      child: CircleParticleSphere(
                        config: widget.particleSphere!,
                        initialPage: 0,
                        viewAsSinglePage: false,
                        useWrapper: true,
                        child: _buildPage,
                      ),
                    )
                  else
                    ClipRect(
                      child: ImageParticleSphere(
                        config: widget.particleSphere!,
                        initialPage: 0,
                        viewAsSinglePage: false,
                        useWrapper: true,
                        child: _buildPage,
                      ),
                    ),
                ] else
                  _buildPage,

                Positioned(
                  top: 10,
                  right: 14,
                  child: QuickPopupButton(
                    buttonStyle: const .lite(elevation: 0),
                    overlayDecoration: .staticWidth(
                      width: Screen.width,
                      color: Colors.transparent,
                      alignment: .right,
                      offsetX: 14,
                      elevation: 0,
                      borderRadius: 0,
                      border: .all(width: .5, color: Colors.transparent),
                      slideTransition: false,
                    ),
                    overlayInstanceOptionBuilder: (targetKey) => const .singleton(),
                    contentBuilder: (context, {closeOverlay}) => Column(
                      mainAxisSize: .min,
                      children: [
                        for (int i = 0; i < widget.navs.length; i++) ...[
                          if (i != 0) const SizedBox(height: 4),
                          _buildNav(
                            index: i,
                            delayBeforeStart: Duration(milliseconds: 50 * (i + 1)),
                            content: widget.navs[i],
                          ),
                        ],
                      ],
                    ),
                    child: const Icon(Icons.drag_handle_rounded, size: 40, color: Colors.grey),
                  ),
                ),

                widget.wrapper,
              ],
            ),
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
        _indexActive.value = index;
      },
    ),
  );

  Widget _buildNav({
    required int index,
    required Duration delayBeforeStart,
    required Widget content,
  }) => SizedBox(
    width: .infinity,
    child: FadeAndSlideTransition(
      slideFromOffset: 1,
      slideFrom: .left,
      animationSpeed: const Duration(milliseconds: 450),
      delayBeforeStart: delayBeforeStart,
      isNoNeedTrigger: true,
      child: Padding(
        padding: const .symmetric(horizontal: 4),
        child: QuickButton(
          onTap: () {
            _pageController?.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
          style: const .lite(
            color: Colors.black54,
            padding: .symmetric(vertical: 12, horizontal: 16),
            elevation: 0,
          ),
          child: content,
        ),
      ),
    ),
  );
}
