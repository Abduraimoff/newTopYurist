import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:top_yurist/data/Models/user/user.dart';

part 'profile_cubit_state.dart';

class ProfileCubit extends Cubit<User> {
  ProfileCubit(initialState) : super(initialState);

  void changeUserType(UserType userType) {
    emit(state.copyWith(type: userType));
  }
}
