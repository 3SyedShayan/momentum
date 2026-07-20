import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/momentum_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final MomentumRepository _momentumRepository;

  ProfileCubit({required MomentumRepository momentumRepository})
      : _momentumRepository = momentumRepository,
        super(ProfileInitial());

  Future<void> fetchProfile(String uid) async {
    emit(ProfileLoading());
    try {
      final profile = await _momentumRepository.getUserProfile(uid);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateProfileSettings({
    required String uid,
    bool? notificationsEnabled,
    int? defaultReminderMinutes,
    String? themeMode,
    String? displayName,
  }) async {
    if (state is ProfileLoaded) {
      final currentProfile = (state as ProfileLoaded).profile;
      final updatedProfile = currentProfile.copyWith(
        notificationsEnabled: notificationsEnabled,
        defaultReminderMinutes: defaultReminderMinutes,
        themeMode: themeMode,
        displayName: displayName,
      );

      emit(ProfileLoaded(updatedProfile)); // optimistic UI update

      try {
        await _momentumRepository.updateUserProfile(updatedProfile);
      } catch (e) {
        emit(ProfileError(e.toString()));
        emit(ProfileLoaded(currentProfile)); // revert on error
      }
    }
  }
}
