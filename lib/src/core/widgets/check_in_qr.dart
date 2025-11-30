import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_web_data/iv_project_web_data.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class CheckInQr {
  const CheckInQr._();

  static void show(BuildContext context) {
    ShowModal.bottomSheet(
      context,
      barrierColor: Colors.grey.shade700.withValues(alpha: .5),
      header: BottomSheetHeader(
        useHandleBar: true,
        handleColor: Colors.grey.shade500,
        action: HeaderAction(
          actionIcon: Icons.close_rounded,
          iconColor: Colors.grey.shade600,
          onTap: () => NavigationService.pop(),
        ),
      ),
      decoration: BottomSheetDecoration(
        color: ColorConverter.lighten(AppColor.primaryColor, 94),
        borderRadius: const .only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      contentBuilder: (_) => const _CheckInQrContent(),
    );
  }
}

class _CheckInQrContent extends StatelessWidget {
  const _CheckInQrContent();

  @override
  Widget build(BuildContext context) {
    final invitedGuestId = context.read<InvitedGuestCubit>().state.invitedGuest?.id ?? '';

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const .symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: .min,
        children: [
          const SizedBox(height: 8),
          Text('Kode QR untuk Check-In', style: AppFonts.nunito(fontSize: 16, fontWeight: .w700)),
          const SizedBox(height: 18),
          QrImageView(data: invitedGuestId, version: QrVersions.auto, size: size.width - 40, gapless: true),
          const SizedBox(height: 20),
          Text(
            'Silahkan tunjukkan Kode QR ini untuk Check-In ke acara pernikahan',
            style: AppFonts.nunito(fontSize: 15, fontWeight: .w500),
            textAlign: .center,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
