import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:top_yurist/data/Models/auth/image_response.dart';
import 'package:top_yurist/data/Repositories/AuthRepository.dart';

import '../../../data/Models/auth/phone_verified_response.dart';
import '../../../data/Models/auth/profile_response.dart';
import '../../../data/Models/regions/regions.dart';
import '../../../data/Models/user/newUser.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository = AuthRepository();
  AuthBloc() : super(AuthInitial()) {
    on<VerifyPhoneNumber>((event, emit) async {
      try {
        final PhoneVerifiedResponse response = await repository.verifyPhone(
          event.context,
        );
        emit(PhoneNumberVerifiedSuccessState(response));
      } on DioError catch (e) {
        if (e.response != null) {
          emit(AuthErrorState(error: e.response?.data["error"]));
        } else {
          emit(AuthErrorState(error: e.message));
        }
      }
    });

    on<OtpCodeSendEvent>((event, emit) async {
      try {
        final ProfileResponse response =
            await repository.sendOtpCode(event.context);
        if (response.statusCode == 400) {
          emit(AuthErrorState(error: response.error));
        }
        emit(OtpCodeSuccessState(response: response));
      } on DioError catch (e) {
        emit(AuthErrorState(error: e.response?.data["error"]));
      }
    });

    on<UploadImageEvent>((event, emit) async {
      try {
        final response = await repository.uploadImage(
            image: event.file, category: event.category);

        emit(UploadImageSuccessState(response: response));
      } on DioError catch (e) {
        if (e.response != null) {
          emit(AuthErrorState(error: e.response?.data["error"]));
        } else {
          emit(AuthErrorState(error: e.message));
        }
      }
    });

    on<RegisterUserEvent>((event, emit) async {
      try {
        final response = await repository.registerUser(event.user);
        emit(RegisterUserSuccessState(response));
      } on DioError catch (e) {
        if (e.response != null) {
          emit(AuthErrorState(error: e.response?.data["error"]));
        } else {
          emit(AuthErrorState(error: e.message));
        }
      }
    });
  }
}
