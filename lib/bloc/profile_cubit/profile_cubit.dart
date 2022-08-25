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
    final user = await _request.getUser();

    if (user == null) {
      emit(ProfileErrorState());
    } else {
      emit(UserState(user: user));
    }
  }

  Future<void> changeUserType(UserType? userType) async {
    final newState = (state as UserState).user.copyWith(userType: userType);
    emit(UserState(user: newState));
  }
}
