import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/src/enums/enums.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/elegant_black_and_white_glass.dart';
import 'package:iv_project_model/iv_project_model.dart';

class InvitationThemeLauncher extends StatefulWidget {
  const InvitationThemeLauncher({super.key, required this.sectionType});

  final InvitationSectionType sectionType;

  @override
  State<InvitationThemeLauncher> createState() => _InvitationThemeLauncherState();
}

class _InvitationThemeLauncherState extends State<InvitationThemeLauncher> {
  InvitationResponse? _invitation;

  @override
  void initState() {
    super.initState();

    _invitation = InvitationResponse(
      id: 1,
      status: InvitationStatusType.active,
      invitationThemeId: 1,
      invitationThemeName: 'Elegant Black And White Glass',
      invitationData: InvitationDataResponse(
        id: 1,
        coverImageUrl: 'assets/dummys/try_theme_cover_image.png',
        bride: const BridegroomResponse(
          id: 1,
          nickname: 'Rahma',
          fullName: 'Rahma Nur Istiqomah',
          title: 'M.Biomed',
          fatherName: 'Bagyo Trisno Ngulandoro',
          fatherTitle: 'S.T',
          motherName: 'Peni Lestari',
          motherTitle: 'S.E',
        ),
        groom: const BridegroomResponse(
          id: 2,
          nickname: 'Faiq',
          fullName: 'Faiq Ulul Fahmi',
          title: 'S.Pd',
          fatherName: 'Syamsuddin',
          fatherTitle: 'S.Pd.I',
          motherName: 'Sa\'idah',
        ),
        contractEvent: EventResponse(
          id: 1,
          startTime: DateTime(2025, 10, 10, 9, 0),
          place: 'Masjid Raya Bani Umar',
          address: 'Jl. Graha Raya Bintaro Kv. GK 4 No. 2-4, Pondok Aren, Tangerang Selatan',
          mapsUrl:
              'https://www.google.com/maps/place/Masjid+Raya+Bani+Umar+-+Tangerang+Selatan/@-6.2705383,106.6944082,16.87z/data=!4m6!3m5!1s0x2e69faf062460ed5:0xc46eba6617b311d6!8m2!3d-6.2703756!4d106.6893305!16s%2Fg%2F1pztc44x6?entry=ttu&g_ep=EgoyMDI1MDgwNS4wIKXMDSoASAFQAw%3D%3D',
        ),
        receptionEvent: EventResponse(
          id: 1,
          startTime: DateTime(2025, 10, 10, 10, 0),
          place: 'Masjid Raya Bani Umar',
          address: 'Jl. Graha Raya Bintaro Kv. GK 4 No. 2-4, Pondok Aren, Tangerang Selatan',
          mapsUrl:
              'https://www.google.com/maps/place/Masjid+Raya+Bani+Umar+-+Tangerang+Selatan/@-6.2705383,106.6944082,16.87z/data=!4m6!3m5!1s0x2e69faf062460ed5:0xc46eba6617b311d6!8m2!3d-6.2703756!4d106.6893305!16s%2Fg%2F1pztc44x6?entry=ttu&g_ep=EgoyMDI1MDgwNS4wIKXMDSoASAFQAw%3D%3D',
        ),
        bankAccounts: const [
          BankAccountResponse(id: 1, bankName: 'BCA', accountName: 'Rahma Nur Istiqomah', number: '485439574'),
          BankAccountResponse(id: 1, bankName: 'BRI', accountName: 'Rahma Nur Istiqomah', number: '33854986435848'),
          BankAccountResponse(id: 1, bankName: 'BRI', accountName: 'Faiq Ulul Fahmi', number: '33854439745427'),
        ],
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_invitation == null) return const SizedBox.shrink();

    switch (_invitation!.invitationThemeId) {
      case 1:
        return ElegantBlackAndWhiteGlass(invitationData: _invitation!.invitationData);
      default:
        return const SizedBox.shrink();
    }
  }
}
