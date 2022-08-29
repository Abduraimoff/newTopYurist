import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:top_yurist/data/Models/user/user.dart';
import 'package:top_yurist/data/Repositories/profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()) {
    loadUser();
  }

  final _request = ProfileRepository();

  Future<void> loadUser() async {
    if (state is! ProfileInitial) {
      return;
    }
    final user = await _request.getUser();
    try {
      if (user == null) {
        emit(const ProfileErrorState('user null'));
      } else {
        emit(UserState(user: user));
      }
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  Future<void> changeUserType(UserType? userType) async {
    final newState = (state as UserState).user.copyWith(userType: userType);
    emit(UserState(user: newState));
  }

  Future<void> editUser(User user) async {
    try {
      await _request.editUser(user);
      emit(UserState(user: user));
    } catch (e) {
      print("edit user error $e");
    }
  }

  Future<String> uploadImage({File? image, String? category}) async {
    final responce = await _request.uploadImage(
      image: image,
      category: category ?? 'test',
    );

    return responce.fullPath ?? '';
  }
}
