import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_role_state.dart';

class UserRoleCubit extends Cubit<UserRoleState> {
  String? userStatus;
  UserRoleCubit() : super(UserRoleInitial());

  void changeUserStatus(String status){
    emit(UserRoleInitial());
    userStatus = status;
    emit(UserRoleChanged(userStatus));
  }
}
