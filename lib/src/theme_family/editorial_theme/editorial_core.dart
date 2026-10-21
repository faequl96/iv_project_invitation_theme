import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/src/core/cubit/invitation_theme_core_cubit.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';

class const EditorialCore({
  super.key,
  required final Widget wrapper,
  final List<Widget>? backgrounds,
  required final List<Widget> pages,
  required final List<Widget> navs,
}) extends StatefulWidget {
  @override
  State<EditorialCore> createState() => _EditorialCoreState();
}

class _EditorialCoreState() extends State<EditorialCore> {
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
        await Future.pause(const Duration(milliseconds: 50));
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
            color: const Color(0xFFF9F9F6),
            child: Stack(
              alignment: .center,
              children: [
                ...?widget.backgrounds,

                _buildPage,

                Positioned(
                  left: 10,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: ValueListenableBuilder<int>(
                      valueListenable: _indexActive,
                      builder: (_, current, _) => Column(
                        mainAxisSize: .min,
                        children: List.generate(
                          widget.pages.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const .symmetric(vertical: 3),
                            width: 3,
                            height: index == current ? 20 : 6,
                            decoration: BoxDecoration(
                              color: index == current
                                  ? const Color(0xFF111111)
                                  : const Color(0xFF111111).withValues(alpha: .2),
                              borderRadius: .circular(2),
                            ),
                          ),
                        ),
                      ),
                    ),
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

  Widget get _buildPage => ValueListenableBuilder<int>(
    valueListenable: _indexActive,
    builder: (_, _, _) => PageView.builder(
      controller: _pageController,
      scrollDirection: .vertical,
      // physics: const ClampingScrollPhysics(),
      itemCount: widget.pages.length,
      onPageChanged: (index) {
        _indexActive.value = index;
      },
      itemBuilder: (_, index) => FadeAndSlideTransition(
        slideFromOffset: .1,
        slideFrom: .bottom,
        child: widget.pages[index],
      ),
    ),
  );
}
