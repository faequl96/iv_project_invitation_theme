import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/app_fonts.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';
import 'package:iv_project_invitation_theme/src/enums/enums.dart';
import 'package:iv_project_invitation_theme/src/widgets/enhanced_general_text_field.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class ElegantBlackAndWhiteGlassSeventhPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassSeventhPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CoreCubit, CoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          Positioned(
            top: 0,
            child: SizedBox(
              height: ScreenUtil.size.height / 1.4,
              width: ScreenUtil.size.width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey.shade900, Colors.transparent],
                    stops: const [.2, .8],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: FadeAndSlideTransition(
              slideFromOffset: .5,
              slideFrom: SlideFrom.top,
              animationSpeed: const Duration(milliseconds: 300),
              child: SizedBox(
                height: SizeScale.heightX6l,
                width: ScreenUtil.size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_available, size: SizeScale.widthXs, color: Colors.grey.shade200),
                    const SizedBox(width: 10),
                    Text(
                      'RSVP Dan Ucapan',
                      style: AppFonts.inter(color: Colors.grey.shade200, fontSize: FontScale.x3l, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: ScreenUtil.size.height,
              width: ScreenUtil.size.width,
              child: Padding(
                padding: EdgeInsets.only(
                  top: SizeScale.heightX6l,
                  left: SizeScale.widthX6s,
                  right: SizeScale.widthX6s,
                  bottom: 76,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        // color: Colors.white.withValues(alpha: .1),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black.withValues(alpha: .6), Colors.black.withValues(alpha: .6)],
                          stops: const [0, 1],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: ScreenUtil.size.height,
              width: ScreenUtil.size.width,
              child: Padding(
                padding: EdgeInsets.only(
                  top: SizeScale.heightX6l,
                  left: SizeScale.widthX6s,
                  right: SizeScale.widthX6s,
                  bottom: 76,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: .5, color: Colors.grey.shade500),
                  ),
                  child: const ClipRect(child: Column(children: [Spacer(), RSVPForm(), Spacer()])),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: ScreenUtil.size.height,
              width: ScreenUtil.size.width,
              child: Padding(
                padding: EdgeInsets.only(
                  top: SizeScale.heightX6l,
                  left: SizeScale.widthX6s,
                  right: SizeScale.widthX6s,
                  bottom: 76,
                ),
                child: BlocSelector<CoreCubit, CoreState, int>(
                  selector: (state) => state.animationTrigger,
                  builder: (_, animationTrigger) {
                    if (animationTrigger == 0) return const SizedBox.shrink();
                    return GlassEffectBox(
                      width: ScreenUtil.size.width - 32,
                      height: ScreenUtil.size.height - (76 + SizeScale.heightX6l),
                      borderRadius: 20,
                      sliderWidth: 90,
                      color: Colors.grey.shade300.withValues(alpha: .3),
                      animationEnd: 1.14,
                      animationSpeed: const Duration(milliseconds: 600),
                      animationInterval: const Duration(seconds: 3),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RSVPForm extends StatefulWidget {
  const RSVPForm({super.key});

  @override
  State<RSVPForm> createState() => _RSVPFormState();
}

class _RSVPFormState extends State<RSVPForm> {
  final _nameController = TextEditingController();
  final _greetingController = TextEditingController();

  final _attendance = ValueNotifier<String?>(null);

  @override
  void dispose() {
    _nameController.dispose();
    _greetingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: EnhancedGeneralTextField(textEditingController: _nameController, labelTextBuilder: () => 'Nama'),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ValueListenableBuilder(
            valueListenable: _attendance,
            builder: (_, _, _) {
              return OverlayDropdownField(
                height: 52,
                style: AppFonts.inter(color: Colors.grey.shade100, fontSize: 16),
                decoration: FieldDecoration(
                  labelText: 'Kehadiran',
                  labelStyle: AppFonts.inter(color: Colors.grey.shade300),
                  filled: true,
                  fillColor: Colors.grey.shade500.withValues(alpha: .3),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  suffixIcon: () {
                    return PreSufFixIcon(
                      onTap: () {},
                      child: Icon(Icons.arrow_drop_down, color: Colors.grey.shade100),
                    );
                  },
                ),
                overlayYOffset: 6,
                overlaydecoration: OverlayDecoration(
                  color: Colors.grey.shade700.withValues(alpha: .8),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  border: Border.all(color: Colors.grey.shade500),
                ),
                dropdownItemDecoration: DropdownItemDecoration(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                  selectedColor: Colors.grey.shade500,
                  hoveredColor: Colors.grey.shade400,
                  splashColor: Colors.grey.shade400,
                ),
                value: _attendance.value,
                dropdownItems: Attendance.values.map((item) => item.description).toList(),
                dropdownItemBuilder: (value) {
                  return Text(value, style: AppFonts.inter(color: Colors.grey.shade100, fontSize: 16));
                },
                onSelected: (value) => _attendance.value = value,
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: EnhancedGeneralTextField(
            textEditingController: _greetingController,
            labelTextBuilder: () => 'Ucapan',
            maxLines: 3,
            isMandatory: false,
          ),
        ),
      ],
    );
  }
}
