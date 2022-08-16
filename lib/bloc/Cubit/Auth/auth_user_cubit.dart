import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:top_yurist/data/Models/user/newUser.dart';
part 'auth_user_state.dart';

class AuthUserCubit extends Cubit<AuthUserState> {
  final NewUser newUser = NewUser();
  AuthUserCubit() : super(AuthUserInitial());
  void getUserType(String userType){
    emit(AuthUserInitial());
    newUser.userType = userType;
    newUser.problemTypes = [];
    emit(CollectUserData(newUser));
  }
  void getUserPhone(String phone){
    emit(AuthUserInitial());
    newUser.phoneNumber = phone;
    emit(CollectUserData(newUser));
  }
  void getRegionId(String title, int id){
    emit(AuthUserInitial());
   newUser.regionId = id;
   newUser.regionName = title;
    emit(CollectUserData(newUser));
  }
  void getProblemType(String id){
    emit(AuthUserInitial());
    newUser.problemTypes?.add(id);
    emit(CollectUserData(newUser));
  }
  void deleteProblemType(String id){
    emit(AuthUserInitial());
    newUser.problemTypes?.remove(id);
    emit(CollectUserData(newUser));
  }
  void getUserAgreement(bool agreement){
    emit(AuthUserInitial());
    newUser.agreement = agreement;
    emit(CollectUserData(newUser));
  }
  void getFullName(String name){
    emit(AuthUserInitial());
    newUser.fullName = name;
    emit(CollectUserData(newUser));
  }
}
