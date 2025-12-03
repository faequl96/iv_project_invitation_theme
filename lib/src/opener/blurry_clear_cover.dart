import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/core/cubit/invitation_theme_core_cubit.dart';

class BlurryClearCover extends StatelessWidget {
  const BlurryClearCover({super.key, required this.isLeft});

  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => SizedBox(
        height: Screen.height,
        width: Screen.width / 2,
        child: Stack(
          alignment: .center,
          clipBehavior: .none,
          children: [
            ClipRect(
              child: BackdropFilter(
                filter: .blur(sigmaX: 5, sigmaY: 5),
                child: SizedBox(
                  height: Screen.height,
                  width: Screen.width / 2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade500.withValues(alpha: 0.2),
                      border: Border(
                        left: isLeft ? .none : BorderSide(color: Colors.grey.shade500, width: .5),
                        right: isLeft ? BorderSide(color: Colors.grey.shade500, width: .5) : .none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(isLeft ? 1 : -1, .6),
              child: Transform.translate(
                offset: Offset(isLeft ? 1 : -1, 0),
                child: SizedBox(
                  height: H.x10l,
                  width: (Screen.width / 2) - W.lg,
                  child: _RecipientBox(isLeft: isLeft),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecipientBox extends StatelessWidget {
  const _RecipientBox({required this.isLeft});

  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey.shade800.withValues(alpha: .6),
        borderRadius: isLeft
            ? const .only(topLeft: .circular(20), bottomLeft: .circular(20))
            : const .only(topRight: .circular(20), bottomRight: .circular(20)),
        border: Border(
          top: BorderSide(width: .5, color: Colors.grey.shade500),
          left: isLeft ? BorderSide(width: .5, color: Colors.grey.shade500) : .none,
          right: isLeft ? .none : BorderSide(width: .5, color: Colors.grey.shade500),
          bottom: BorderSide(width: .5, color: Colors.grey.shade500),
        ),
      ),
    );
  }
}
