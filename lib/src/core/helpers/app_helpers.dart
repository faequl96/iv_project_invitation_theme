import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_model/iv_project_model.dart';

class AppHelpers {
  const AppHelpers._();

  static bool isGalleriesNotEmptyChecker(ViewType viewType, ImagesRaw? imagesRaw, InvitationDataResponse invitationData) {
    bool returnValue = false;

    if (viewType == ViewType.preview) {
      if (imagesRaw != null) {
        for (final file in imagesRaw.galleries) {
          if (file != null) {
            returnValue = true;
            break;
          }
        }
      }
    } else {
      final gallery = invitationData.gallery;
      if (gallery.imageURL1 != null ||
          gallery.imageURL2 != null ||
          gallery.imageURL3 != null ||
          gallery.imageURL4 != null ||
          gallery.imageURL5 != null ||
          gallery.imageURL6 != null ||
          gallery.imageURL7 != null ||
          gallery.imageURL8 != null ||
          gallery.imageURL9 != null ||
          gallery.imageURL10 != null ||
          gallery.imageURL11 != null ||
          gallery.imageURL12 != null) {
        returnValue = true;
      }
    }

    return returnValue;
  }

  static void setSize(InvitationThemeCoreCubit coreCubit, double heightAdjustment) {
    final size = MediaQuery.of(GlobalContextService.value).size;
    final padding = MediaQuery.of(GlobalContextService.value).padding;

    late final Size finalSize;
    if (size.width > 440) {
      if (size.height < 840) {
        finalSize = Size(412, size.height - (padding.top + heightAdjustment + padding.bottom));
      } else {
        finalSize = const Size(412, 812);
      }
    } else {
      if (size.height < 840) {
        finalSize = Size(size.width, size.height - (padding.top + heightAdjustment + padding.bottom));
      } else {
        finalSize = Size(size.width, 812);
      }
    }

    Screen.set(finalSize);
    H.set(finalSize.height);
    W.set(finalSize.width);
    FontSize.set(finalSize.width);

    coreCubit.state.copyWith(size: finalSize).emitState();
  }
}
