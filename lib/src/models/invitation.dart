import 'package:iv_project_invitation_theme/src/enums/enums.dart';
import 'package:iv_project_model/iv_project_model.dart';

class Invitation {
  Invitation.create({required this.themeId, required this.themeName}) : type = InvitationType.create;

  Invitation.edit({required this.themeId, required this.themeName, required this.data}) : type = InvitationType.edit;

  Invitation.view({required this.themeId, required this.themeName, required this.status, required this.data})
    : type = InvitationType.view;

  final InvitationType type;
  final int themeId;
  final String themeName;
  late final InvitationStatusType status;
  late final InvitationDataResponse data;
}
