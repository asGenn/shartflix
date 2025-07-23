import 'dart:io';

import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';
import 'package:shartflix/core/models/base_response.dart';
import 'package:shartflix/core/util/constants/network/remote.dart';
import 'package:shartflix/features/auth/data/models/login_request_model.dart';
import 'package:shartflix/features/auth/data/models/register_request_model.dart';
import 'package:shartflix/features/auth/data/models/user_model.dart';

part 'user_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class UserApiService {
  factory UserApiService(Dio dio) = _UserApiService;

  @POST("user/login")
  Future<HttpResponse<BaseResponse<UserModel>>> login(@Body() LoginRequestModel loginRequest);

  @POST("user/register")
  Future<HttpResponse<BaseResponse<UserModel>>> register(@Body() RegisterRequestModel registerRequest);

  @POST("user/upload_photo")
  Future<HttpResponse<BaseResponse<UserModel>>> uploadPhoto(@Header("Authorization") String token, @Part() File file);
}
