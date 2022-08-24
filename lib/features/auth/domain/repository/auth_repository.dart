import 'package:either_dart/either.dart';

import '../../../../core/failures/failures.dart';
import '../../data/models/auth_res.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthRes>> doLogin({required String fullName});
  // Future<Either<Failure, AuthRes>> doRegister(
  //     {required String phoneNumber,
  //     required String province,
  //     required String fullName,
  //     required String password});
  // Future<Either<Failure, ChangePasswordRes>> changePassword(
  //     {required String phoneNumber, required String newPassword});
  Future<Either<Failure, bool>> checkExisted({required String fullName});
}
