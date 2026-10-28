import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/src/core/cubit/invitation_theme_core_cubit.dart';

class const ElysianCore({
  super.key,
  required final Widget wrapper,
  final List<Widget>? backgrounds,
  required final List<Widget> pages,
  required final List<Widget> navs,
}) extends StatefulWidget {
  @override
  State<ElysianCore> createState() => _ElysianCoreState();
}

class _ElysianCoreState() extends State<ElysianCore> {
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
            color: const Color(0xFF0F0E17),
            child: Stack(
              alignment: .center,
              children: [
                ...?widget.backgrounds,

                ValueListenableBuilder<int>(
                  valueListenable: _indexActive,
                  builder: (_, _, _) => PageView.builder(
                    controller: _pageController,
                    scrollDirection: .vertical,
                    itemCount: widget.pages.length,
                    onPageChanged: (index) {
                      _indexActive.value = index;
                    },
                    itemBuilder: (_, index) => widget.pages[index],
                  ),
                ),

                Positioned(
                  right: 12,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: ValueListenableBuilder<int>(
                      valueListenable: _indexActive,
                      builder: (_, current, _) => Column(
                        mainAxisSize: .min,
                        children: List.generate(
                          widget.pages.length,
                          (index) => GestureDetector(
                            onTap: () => _pageController?.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeOutCubic,
                            ),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const .symmetric(vertical: 3),
                              width: index == current ? 4 : 3,
                              height: index == current ? 22 : 6,
                              decoration: BoxDecoration(
                                color: index == current
                                    ? const Color(0xFFE5C88F)
                                    : const Color(0xFFE5C88F).withValues(alpha: .25),
                                borderRadius: .circular(3),
                                boxShadow: index == current
                                    ? [
                                        BoxShadow(
                                          color: const Color(0xFFE5C88F).withValues(alpha: .6),
                                          blurRadius: 8,
                                        ),
                                      ]
                                    : null,
                              ),
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
}
