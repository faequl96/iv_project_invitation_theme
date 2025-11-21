import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_model/iv_project_model.dart';

part 'rsvp_state.dart';

class RSVPCubit extends Cubit<RSVPState> {
  RSVPCubit() : super(const RSVPState());

  void emitState(RSVPState state) => emit(state);

  Future<bool> create(RSVPRequest request) async {
    try {
      emit(state.copyWith(isLoadingCreate: true, rsvp: null.toCopyWithValue()));

      final url = Uri.parse('https://9dae0f172e7c.ngrok-free.app/api/v1/rsvp');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'ngrok-skip-browser-warning': 'true'},
        body: jsonEncode(request.toJson()),
      );
      if (response.statusCode == 200) {
        final RSVPResponse rsvp = RSVPResponse.fromJson(jsonDecode(response.body)['data']);

        emit(state.copyWith(isLoadingCreate: false, rsvp: rsvp.toCopyWithValue()));

        return true;
      }

      emit(state.copyWith(isLoadingCreate: false));

      return false;
    } catch (e) {
      emit(state.copyWith(isLoadingCreate: false));

      return false;
    }
  }

  Future<bool> getsByInvitationId(String invitationId) async {
    try {
      emit(state.copyWith(isLoadingGetsByInvitationId: true, rsvps: null.toCopyWithValue()));

      await Future.delayed(const Duration(seconds: 8));
      final url = Uri.parse('https://9dae0f172e7c.ngrok-free.app/api/v1/rsvps/invitation-id/$invitationId');
      final response = await http.get(url, headers: {'ngrok-skip-browser-warning': 'true'});
      if (response.statusCode == 200) {
        final List<RSVPResponse> rsvps = (jsonDecode(response.body)['data'] as List)
            .map((json) => RSVPResponse.fromJson(json))
            .toList();

        emit(state.copyWith(isLoadingGetsByInvitationId: false, rsvps: rsvps.toCopyWithValue()));

        return true;
      }

      emit(state.copyWith(isLoadingGetsByInvitationId: false));

      return false;
    } catch (e) {
      emit(state.copyWith(isLoadingGetsByInvitationId: false));

      return false;
    }
  }
}
