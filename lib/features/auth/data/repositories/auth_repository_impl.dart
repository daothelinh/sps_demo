import 'package:either_dart/either.dart';
import 'package:get/get.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/values/endpoints.dart';
import '../../../../resful/resful_module.dart';
import '../../domain/repository/auth_repository.dart';
import '../models/auth_res.dart';

class AuthRepositoryImpl implements AuthRepository {
  final GetConnect getConnect;
  AuthRepositoryImpl(this.getConnect);

  @override
  Future<Either<Failure, AuthRes>> doLogin(
      {required String fullName}) async {
    var body = {"fullName": fullName};
    try {
      RestfulModule restfulModule = Get.find();

      var response = await restfulModule.post(Endpoints.login, body);
      if (response.statusCode == 404) {
        return Left(AuthFailure(message: response.body['message']));
      }
      var token = response.headers!['x-auth-token'] ?? "";
      await restfulModule.saveAuthToken(token);
      var result = response.body;
      return Right(AuthRes.fromJson(result));
    } catch (e, stacktrace) {
      // logger.e('$e $stacktrace');
      return Left(SystemFailure(message: e.toString()));
    }
  }
  @override
  Future<Either<Failure, bool>> checkExisted(
      {required String fullName}) async {
    try {
      var response = await getConnect.post(Endpoints.checkExisted, {
        "fullName": fullName,
      });
      var result = response.body;
      return Right(result['existed']);
    } catch (e) {
      // logger.e(e);
      return Left(SystemFailure(message: e.toString()));
    }
  }
}