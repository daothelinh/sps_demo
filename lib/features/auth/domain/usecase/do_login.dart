import 'package:either_dart/either.dart';

import '../../../../core/failures/failures.dart';
import '../../data/models/auth_res.dart';
import '../repository/auth_repository.dart';

class DoLogin {
  final AuthRepository repository;
  DoLogin(this.repository);

  Future<Either<Failure, AuthRes>> call({required String fullName}) async {
    return await repository.doLogin(fullName: fullName);
  }
}
