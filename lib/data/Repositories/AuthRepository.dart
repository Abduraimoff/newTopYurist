import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:top_yurist/bloc/Cubit/Auth/auth_user_cubit.dart';
import 'package:top_yurist/data/HttpRequest/http_requests.dart';
import 'package:top_yurist/data/Models/auth/image_response.dart';
import '../../utils/config.dart';
import '../Models/auth/phone_verified_response.dart';
import '../Models/auth/profile_response.dart';
import '../Models/user/newUser.dart';

class AuthRepository{
  final ApiRequest request = ApiRequest();
  final storage =  const FlutterSecureStorage();

  Future<PhoneVerifiedResponse> verifyPhone(BuildContext context) async{

    try{
      final  response = await request.doPostRequest(slug: "/api/auth",
          queryParameters: {
            "grant_type": "authorization_code",
            "user_type": context.read<AuthUserCubit>().newUser.userType,
            "phone_country": "998",
            "phone_number": context.read<AuthUserCubit>().newUser.phoneNumber,
          },
          options: Options(headers: {
            "Client-Authorization": "Basic ZGV2OjhmZGE5MTE1LTc3ZDktOWNiMS1iYWRjLWY4NmQyNmVlYzIwYw==",
          })
      );
      if(response.statusCode == 200){
        return PhoneVerifiedResponse.fromJson(response.data);
      }
      return response.data;


    }catch(e){

      rethrow;
    }
  }



  Future<ProfileResponse> sendOtpCode(BuildContext? context) async {
    try {
      final response = await ApiRequest().doPostRequest(
          slug: "/api/auth",
          queryParameters: {
            "grant_type": "authorization_code",
            "token": context?.read<AuthUserCubit>().newUser.token,
            "code": context?.read<AuthUserCubit>().newUser.otpCode,
          },
          options: Options(headers: {
            "Client-Authorization": "Basic ZGV2OjhmZGE5MTE1LTc3ZDktOWNiMS1iYWRjLWY4NmQyNmVlYzIwYw==",
          })
      );
      if(response.statusCode == 200){
        final ProfileResponse data = ProfileResponse.fromJson(response.data);
        await storage.write(key: Config.accessToken, value: "Bearer ${data.credentials?.accessToken}");
        await storage.write(key: Config.refreshToken, value: data.credentials?.refreshToken);
        await storage.write(key: Config.userType, value: data.data?.userType);
        await storage.write(key: Config.userId, value: response.data["id"]);


        return data;
      }
      if(response.statusCode == 400){
        return ProfileResponse(error: response.data["error"], statusCode: response.statusCode);
      }
      return response.data;

    }catch(e){

      rethrow;
    }
  }


  Future<ImageResponse> uploadImage({File? image, String? category}) async {
    ImageResponse res = ImageResponse();
    var formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(image!.path),
      "category": "test"
    });
    try {
      final response = await ApiRequest().doPostRequest(
          slug: "/file/upload-unique",
          data: formData,
          options: Options(headers: {
            "Authorization": await storage.read(key: Config.accessToken),
          }));

      res.statusCode = response.statusCode;
      if(response.statusCode == 200){
        return ImageResponse.fromJson(response.data) ;
      }
      if(response.statusCode == 400){
        res.error = response.data;
        return res;
      }
      return res;

    }catch(e){
      rethrow;
    }

  }






  Future<ProfileResponse> registerUser(NewUser user) async{
    try{
      final Response response = await request.doPostRequest(slug: "/api/registration", options: Options(
        headers: {"Authorization": await storage.read(key: Config.accessToken),},),
          data: {
            "profile_photo": user.imageUrl,
            "full_name": user.fullName,
            "region_id": user.regionId,
            "agreement": true,
            "problem_types": user.problemTypes,
          }
      );
      return ProfileResponse.fromJson(response.data);
    }on DioError catch(e){
      return ProfileResponse(error: e.response?.data["error"]);
    }
  }


}

