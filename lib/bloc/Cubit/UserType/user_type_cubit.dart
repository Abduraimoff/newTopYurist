import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_type_state.dart';

class UserTypeCubit extends Cubit<UserTypeState> {
  String? userType = "lawyer";
  UserTypeCubit() : super(UserTypeInitial());

  void changeType(String? type){
    emit(UserTypeInitial());
    userType = type;
    emit(UserTypeChanged(userType));
  }
}
