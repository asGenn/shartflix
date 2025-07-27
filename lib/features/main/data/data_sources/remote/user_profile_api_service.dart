import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shartflix/core/shared/models/base_response.dart';
import 'package:shartflix/core/util/constants/network/remote.dart';
import 'package:shartflix/features/auth/data/models/user_model.dart';

part 'user_profile_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class UserProfileApiService {
  factory UserProfileApiService(Dio dio) = _UserProfileApiService;

  @GET("user/profile")
  Future<HttpResponse<BaseResponse<UserModel>>> getUserProfile(
    @Header("Authorization") String token,
  );

  @POST("user/upload_photo")
  Future<HttpResponse<BaseResponse<UserModel>>> uploadPhoto(
    @Header("Authorization") String token,
    @Part() File file,
  );
}
