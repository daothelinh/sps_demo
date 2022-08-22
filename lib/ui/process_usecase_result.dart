import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sps_demo/ui/snackbar.dart';

import '../core/failures/failures.dart';

Future<void> processUsecaseResult(
    {required Either<Failure, dynamic> result,
    Function(dynamic)? onSuccess,
    bool Function(Failure)? shouldShowFailure,
    RefreshController? refreshController,
    bool isRefreshing = true}) async {
  result.fold((failure) {
    bool shoudShow = true;
    if (shouldShowFailure != null) {
      shoudShow = shouldShowFailure(failure);
    }
    if (shoudShow) {
      // Show snack bar or dialog error
      Get.until((route) => !Get.isDialogOpen!);
      Snackbar.show(type: SnackbarType.error, message: failure.message);
    }

    if (refreshController != null) {
      isRefreshing
          ? refreshController.refreshFailed()
          : refreshController.loadFailed();
    }
  }, (data) {
    if (onSuccess != null) {
      onSuccess(data);
    }
    if (refreshController != null) {
      if (isRefreshing) {
        refreshController.refreshCompleted(resetFooterState: true);
      } else {
        if (data is List && data.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      }
    }
  });
}
