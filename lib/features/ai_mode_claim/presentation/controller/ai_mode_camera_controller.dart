// import 'dart:io';
// import 'dart:ui' as ui;
// import 'dart:typed_data';

// import 'package:camerawesome/models/capture_modes.dart';
// import 'package:camerawesome/models/flashmodes.dart';
// import 'package:camerawesome/models/sensors.dart';
// import 'package:camerawesome/picture_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:screenshot/screenshot.dart';

// import '../../../../core/services/logger_service.dart';
// import '../../../../ui/process_usecase_result.dart';
// import '../../../../ui/snackbar.dart';
// import 'package:path_provider/path_provider.dart';

// class AIModeCameraController extends FullLifeCycleController
//     with GetSingleTickerProviderStateMixin {
//   final CallEngineAfterTakePhoto callEngineAfterTakePhoto;
//   final UserCorrectDamage userCorrectDamage;
//   final DeleteImageByID deleteImageByID;

//   AIModeCameraController({
//     required this.callEngineAfterTakePhoto,
//     required this.userCorrectDamage,
//     required this.deleteImageByID,
//   });

//   late Rx<XFile?> previewFile;

//   final switchFlash = ValueNotifier(CameraFlashes.NONE);
//   final sensor = ValueNotifier(Sensors.BACK);
//   final captureMode = ValueNotifier(CaptureModes.PHOTO);
//   final photoSize = ValueNotifier(const Size(1080, 1920));

//   // Controllers
//   final PictureController pictureController = PictureController();
//   final ScreenshotController screenshotController = ScreenshotController();
//   final AIModeClaimController claimController = Get.find();
//   late Rx<AIModeCameraArgument> currentArg;
//   var vehicleBrandFolder = ''.obs;
//   var scaleImageValue = 1.0.obs;

//   // call engine
//   var isEngineProcessing = false.obs;
//   late Rx<AIModeDamageAssessmentModel?> damageAssess;

//   // tab bar
//   late TabController tabController;
//   var currentTabIndex = 0.obs;

//   // images
//   // var overViewImages = <XFileWithId>[].obs;
//   // var middleViewImages = <XFileWithId>[].obs;
//   // var closeViewImages = <XFileWithId>[].obs;

//   // drawing tools
//   // final paintController = PainterController(
//   //   settings: PainterSettings(
//   //     freeStyle: FreeStyleSettings(
//   //       color: DamageConstants.damageClassColors[DamageConstants.typeDent]!
//   //           .withOpacity(baseOpacity),
//   //       strokeWidth: 10,
//   //       mode: FreeStyleMode.draw,
//   //     ),
//   //     scale: const ScaleSettings(
//   //       enabled: true,
//   //       minScale: 0.1,
//   //       maxScale: 10,
//   //     ),
//   //   ),
//   // );
//   var backgroundImage = Rx<ui.Image?>(null);
//   var previewUserMaskImagesBuffer = <Uint8List>[].obs;
//   final GlobalKey painterKey = GlobalKey();
//   final GlobalKey cameraViewKey = GlobalKey();
//   final GlobalKey imagePreviewKey = GlobalKey();
//   Size? painterSize;
//   var currentDamageType = DamageConstants.typeDent.obs;
//   var onDrawingMode = false.obs;
//   var wantToEdit = false.obs;

//   // image server
//   static const colorOpacity = damageBaseOpacity;
//   var damageMaskDrawables = <String, Drawable>{};
//   var currentDamageColor =
//       DamageConstants.damageClassColors[DamageConstants.typeDent]!.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     currentArg =
//         Rx<AIModeCameraArgument>(Get.arguments as AIModeCameraArgument);
//     tabController = TabController(
//         length: 2,
//         vsync: this,
//         initialIndex: (currentArg.value.imageRangeId - 1));
//     currentTabIndex.value = (currentArg.value.imageRangeId - 1);
//     previewFile = Rx<XFile?>(null);
//     damageAssess = Rx<AIModeDamageAssessmentModel?>(null);
//   }

//   @override
//   void dispose() {
//     photoSize.dispose();
//     captureMode.dispose();
//     super.dispose();
//   }

//   // Future<void> readyToDraw() async {
//   //   if (damageAssess.value != null) {
//   //     backgroundImage.value = await (CachedNetworkImageProvider(
//   //             damageAssess.value!.imgUrl,
//   //             cacheKey: UrlUtils.cacheKeyFromUrl(damageAssess.value!.imgUrl))
//   //         .image);
//   //     paintController.background = backgroundImage.value!.backgroundDrawable;
//   //     wantToEdit.value = false;
//   //     onDrawingMode.value = true;
//   //     update();

//   //     if (damageAssess.value!.carDamages.isNotEmpty) {
//   //       currentDamageType.value =
//   //           damageAssess.value!.carDamages.first.className;
//   //       currentDamageColor.value = DamageConstants
//   //               .damageClassColors[currentDamageType.value]
//   //               ?.withOpacity(colorOpacity) ??
//   //           Colors.transparent.withOpacity(colorOpacity);
//   //       paintController.freeStyleColor = currentDamageColor.value;
//   //       // update();
//   //     }

//   //     WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
//   //       var renderObj =
//   //           painterKey.currentContext?.findRenderObject() as RenderBox;
//   //       painterSize = renderObj.size;
//   //       setDamageMask();
//   //     });
//   //   }
//   // }

//   // Future<void> setDamageMask() async {
//   //   var drawables = <ImageDrawable>[];
//   //   var currentDamageClass = currentDamageType.value;
//   //   paintController.freeStyleMode = FreeStyleMode.draw;

//   //   paintController.performedActions.clear();
//   //   paintController.unperformedActions.clear();

//   //   if (damageMaskDrawables.containsKey(currentDamageClass)) {
//   //     // Get the existing mask
//   //     paintController.value = paintController.value
//   //         .copyWith(drawables: [damageMaskDrawables[currentDamageClass]!]);
//   //     return;
//   //   }

//   //   // Init mask
//   //   var viewWidth = painterSize!.width;
//   //   var viewHeight = painterSize!.height;
//   //   currentDamageColor.value = DamageConstants
//   //           .damageClassColors[currentDamageClass]
//   //           ?.withOpacity(colorOpacity) ??
//   //       Colors.transparent;
//   //   for (var part in damageAssess.value!.carParts) {
//   //     for (var mask in part.carPartDamages) {
//   //       if (mask.className != currentDamageClass) continue;

//   //       var img = await CachedNetworkImageProvider(mask.maskUrl,
//   //               cacheKey: UrlUtils.cacheKeyFromUrl(mask.maskUrl))
//   //           .image;

//   //       var tImg = imageplugin.decodePng(
//   //           (await img.toByteData(format: ui.ImageByteFormat.png))!
//   //               .buffer
//   //               .asUint8List())!;

//   //       tImg = imageplugin.colorOffset(
//   //         tImg,
//   //         alpha: -256 + currentDamageColor.value.alpha,
//   //         red: -255 + currentDamageColor.value.red,
//   //         blue: -255 + currentDamageColor.value.blue,
//   //         green: -255 + currentDamageColor.value.green,
//   //       );

//   //       var maskW = mask.boxes[2] - mask.boxes[0];
//   //       var maskH = mask.boxes[3] - mask.boxes[1];

//   //       var finalImg =
//   //           await MemoryImage(Uint8List.fromList(imageplugin.encodePng(tImg)))
//   //               .image;

//   //       var drawable = ImageDrawable.fittedToSize(
//   //           image: finalImg,
//   //           position: Offset(viewWidth * (mask.boxes[0] + maskW / 2),
//   //               viewHeight * (mask.boxes[1] + maskH / 2)),
//   //           size: Size(viewWidth * maskW, viewHeight * maskH));
//   //       drawables.add(drawable);
//   //     }
//   //   }
//   //   paintController.value =
//   //       paintController.value.copyWith(drawables: drawables);
//   //   await saveDamageMask();
//   // }

//   void captureImage() async {
//     final Directory extDir = await getTemporaryDirectory();
//     final appImageDir =
//         await Directory('${extDir.path}/app_images').create(recursive: true);
//     final String filePath =
//         '${appImageDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

//     await pictureController.takePicture(filePath);

//     final file = await resizeImage(File(filePath));
//     file.saveTo(filePath);
//     previewFile.value = XFile(filePath);
//     update();

//     await doCallEngineAfterTakePhoto(filePath);
//     update();
//   }

//   void autoSwitchTab(XFile file, {int? index}) {
//     if (wantToEdit.isFalse && onDrawingMode.isFalse) {
//       switch (currentTabIndex.value) {
//         case 0:
//           // overViewImages.assignAll([file]);
//           changeTab(index ?? 1);
//           break;
//         case 1:
//           // middleViewImages.add(file);
//           changeTab(index ?? 1);
//           break;
//         // case 2:
//         //   closeViewImages.add(file);
//         //   if (overViewImages.isEmpty) {
//         //     changeTab(index ?? 0);
//         //   } else {
//         //     changeTab(index ?? 1);
//         //   }
//         //   break;
//       }
//       previewFile.value = null;
//     }
//     update();
//   }

//   Future<void> doCallEngineAfterTakePhoto(String imageFilePath) async {
//     wantToEdit.value = false;
//     isEngineProcessing(true);
//     ProgressDialog.showWithCircleIndicator(isLandScape: true);
//     var result = await callEngineAfterTakePhoto(
//       claimFolderId: currentArg.value.claim.claimId,
//       imageRangeId: currentTabIndex.value + 1,
//       imageFiles: imageFilePath,
//       partDirectionName: currentArg.value.partDirection.partDirectionName,
//     );

//     processUsecaseResult(
//       result: result,
//       onSuccess: (data) {
//         ProgressDialog.hide();
//         damageAssess.value = data;
//         wantToEdit.value = true;
//         currentArg.value.partDirection.imageFiles.add(XFileWithId(
//           imageId: damageAssess.value!.imageId,
//           file: previewFile.value!,
//         ));
//         switch (currentTabIndex.value) {
//           case 0:
//             currentArg.value.partDirection.overViewImageFiles.assignAll([
//               XFileWithId(
//                 imageId: damageAssess.value!.imageId,
//                 file: previewFile.value!,
//               )
//             ]);
//             break;
//           case 1:
//             currentArg.value.partDirection.middleViewImageFiles.add(XFileWithId(
//               imageId: damageAssess.value!.imageId,
//               file: previewFile.value!,
//             ));
//             break;
//         }
//       },
//       shouldShowFailure: (f) {
//         ProgressDialog.hide();
//         return true;
//       },
//     );
//   }

//   void changeTab(int index) {
//     previewFile.value = null;
//     currentTabIndex.value = index;
//     tabController.animateTo(index);
//     update();
//   }

//   void onPreviewImageTapped(BuildContext context) {
//     showCupertinoModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return const ImagePreviewBottomSheet();
//       },
//     );
//   }

//   Future<bool> onPop() async {
//     // List<XFileWithId> _imageList = <XFileWithId>[];
//     // _imageList.addAll(overViewImages);
//     // _imageList.addAll(middleViewImages);
//     // _imageList.addAll(closeViewImages);
//     Get.back(result: currentArg.value
//         // result: AiModeCameraOutput(
//         //   allImagesFiles: _imageList,
//         //   overViewImageFiles: overViewImages,
//         //   middleViewImageFiles: middleViewImages,
//         //   closeViewImageFiles: closeViewImages,
//         // ),
//         );
//     return false;
//   }

//   void galleryPicker() async {
//     if (wantToEdit.isFalse) {
//       final ImagePicker _picker = ImagePicker();
//       XFile? file = await _picker.pickImage(source: ImageSource.gallery);
//       if (file != null) {
//         // imageLists.addAll(files);
//         final Directory extDir = await getTemporaryDirectory();
//         final appImageDir = await Directory('${extDir.path}/app_images')
//             .create(recursive: true);
//         final String filePath =
//             '${appImageDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

//         var _resizeFile = await resizeImage(File(file.path));

//         _resizeFile.saveTo(filePath);
//         previewFile.value = _resizeFile;
//         update();
//         await doCallEngineAfterTakePhoto(_resizeFile.path);
//         update();
//       }
//     }
//   }

//   Future<XFile> resizeImage(File img) async {
//     late File? compressedFile;

//     try {
//       final Directory extDir = await getTemporaryDirectory();
//       final appImageDir =
//           await Directory('${extDir.path}/app_images').create(recursive: true);

//       // convert to jpg
//       final String jpgFilePath =
//           '${appImageDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
//       final imageObject = imageplugin.decodeImage(img.readAsBytesSync())!;
//       File jpgFile = File(jpgFilePath);
//       jpgFile.writeAsBytesSync(imageplugin.encodeJpg(imageObject));

//       // compress
//       final String targetPath =
//           '${appImageDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
//       compressedFile = await FlutterImageCompress.compressAndGetFile(
//         jpgFile.absolute.path,
//         targetPath,
//         quality: 90,
//         // format: CompressFormat.png,
//       );
//       if (compressedFile == null) {
//         return XFile(img.path);
//       }
//       return XFile(compressedFile.path);
//     } catch (e) {
//       logger.e(e);
//       return XFile(img.path);
//     }
//   }

//   String loadImageByVehicleBrand() {
//     String imagePath;
//     switch (vehicleBrandFolder.value) {
//       //Check loại xe để lấy khung tương ứng với ảnh
//       case 'KIA Morning':
//         imagePath = currentArg.value.partDirection.meta.kiaChassisPath;
//         break;
//       case 'Huyndai Kona':
//         imagePath = currentArg.value.partDirection.meta.chassisPath;
//         break;
//       case 'Toyota Vios':
//         imagePath = currentArg.value.partDirection.meta.viosChassisPath;
//         break;
//       case 'KIA Cerato':
//         imagePath = currentArg.value.partDirection.meta.ceratoChassisPath;
//         break;
//       case 'Toyota Innova':
//         imagePath = currentArg.value.partDirection.meta.innovaChassisPath;
//         break;
//       case '7 chỗ':
//         imagePath = currentArg.value.partDirection.meta.innovaChassisPath;
//         break;
//       case 'Xe bán tải':
//         imagePath = currentArg.value.partDirection.meta.innovaChassisPath;
//         break;
//       case '5 chỗ cỡ nhỏ':
//         imagePath = currentArg.value.partDirection.meta.kiaChassisPath;
//         break;
//       case '5 chỗ cỡ lớn':
//         imagePath = currentArg.value.partDirection.meta.chassisPath;
//         break;
//       case 'Sedan':
//         imagePath = currentArg.value.partDirection.meta.viosChassisPath;
//         break;
//       default:
//         imagePath = currentArg.value.partDirection.meta.kiaChassisPath;
//     }
//     return imagePath;
//   }

//   void handleCameraDoNotHavePermission(bool? value) {
//     if (value == null || value == false) {
//       Get.back();
//       Snackbar.show(
//         type: SnackbarType.error,
//         message:
//             'Bạn không có quyền truy cập! Vui lòng cấp quyền trong phần cài đặt trên điện thoại của bạn!',
//       );
//     }
//   }

//   void switchFlashMode() {
//     if (switchFlash.value == CameraFlashes.NONE) {
//       switchFlash.value = CameraFlashes.ON;
//     } else {
//       switchFlash.value = CameraFlashes.NONE;
//     }
//     update();
//   }

//   // Future<void> finishAnnotate() async {
//   //   paintController.freeStyleMode = FreeStyleMode.none;
//   //   ProgressDialog.showWithCircleIndicator(isLandScape: true);
//   //   await saveDamageMask();

//   //   final size = Size(backgroundImage.value!.width.toDouble(),
//   //       backgroundImage.value!.height.toDouble());

//   //   List<UserCorrectedDamageItem> correctedItems = [];
//   //   for (var drawableItem in damageMaskDrawables.entries) {
//   //     var renderedImage = await renderDamageMask(drawableItem.value, size,
//   //         DamageConstants.damageClassColors[drawableItem.key]!);
//   //     var pngImageBuffer = (await renderedImage.pngBytes)!;
//   //     correctedItems.add(UserCorrectedDamageItem(
//   //         maskData: pngImageBuffer,
//   //         damageClass: drawableItem.key,
//   //         maskImgName: await nanoid() + '.png'));
//   //     previewUserMaskImagesBuffer.add(pngImageBuffer);
//   //   }
//   //   var result = await userCorrectDamage(
//   //     UserCorrectedDamages(
//   //       imageId: damageAssess.value!.imageId.toString(),
//   //       correctedData: correctedItems,
//   //     ),
//   //     isReAssessment: true,
//   //   );
//   //   ProgressDialog.hide();

//   //   result.fold(
//   //     (l) {
//   //       Snackbar.show(type: SnackbarType.error, message: l.message);
//   //     },
//   //     (r) {
//   //       wantToEdit.value = true;
//   //       onDrawingMode.value = false;
//   //       update();
//   //     },
//   //   );
//   // }

//   // Future<void> switchDamageClass(String targetDamageClass) async {
//   //   await saveDamageMask();

//   //   currentDamageType.value = targetDamageClass;
//   //   currentDamageColor.value = DamageConstants
//   //       .damageClassColors[targetDamageClass]!
//   //       .withOpacity(colorOpacity);
//   //   paintController.freeStyleColor = currentDamageColor.value;
//   //   update();
//   //   await setDamageMask();
//   //   update();
//   // }

//   // Future<ui.Image> renderDamageMask(
//   //     Drawable maskDrawable, Size size, Color color) async {
//   //   final recorder = ui.PictureRecorder();
//   //   final canvas = Canvas(recorder);

//   //   canvas.save();

//   //   var _scale = paintController.painterKey.currentContext?.size ?? size;

//   //   canvas.transform(Matrix4.identity()
//   //       .scaled(size.width / _scale.width, size.height / _scale.height)
//   //       .storage);
//   //   canvas.drawColor(color, ui.BlendMode.clear);
//   //   canvas.saveLayer(Rect.largest, Paint());

//   //   maskDrawable.draw(canvas, size);
//   //   canvas.restore();

//   //   var renderedImage = await recorder
//   //       .endRecording()
//   //       .toImage(size.width.floor(), size.height.floor());
//   //   return renderedImage;
//   // }

//   // Future<void> saveDamageMask() async {
//   //   var currentDamageClass = currentDamageType.value;
//   //   paintController.groupDrawables(newAction: false);
//   //   paintController.performedActions.removeLast();
//   //   var groupedDrawable = paintController.drawables[0];
//   //   damageMaskDrawables[currentDamageClass] = groupedDrawable;
//   // }

//   void doDeleteImage(
//     String? imageId,
//   ) async {
//     // delete on local
//     try {
//       currentArg.value.partDirection.images
//           .removeWhere((element) => element.imageId == imageId);
//       currentArg.value.partDirection.imageFiles
//           .removeWhere((element) => element.imageId.toString() == imageId);
//       // over view
//       currentArg.value.partDirection.overViewImages
//           .removeWhere((element) => element.imageId == imageId);
//       currentArg.value.partDirection.overViewImageFiles
//           .removeWhere((element) => element.imageId.toString() == imageId);
//       // over view
//       currentArg.value.partDirection.middleViewImages
//           .removeWhere((element) => element.imageId == imageId);
//       currentArg.value.partDirection.middleViewImageFiles
//           .removeWhere((element) => element.imageId.toString() == imageId);
//       // over view
//       currentArg.value.partDirection.closeViewImages
//           .removeWhere((element) => element.imageId == imageId);
//       currentArg.value.partDirection.closeViewImageFiles
//           .removeWhere((element) => element.imageId.toString() == imageId);
//       update();
//     } catch (e) {
//       logger.e(e);
//     }

//     // delete on server
//     var result = await deleteImageByID(imageId.toString());
//     await processUsecaseResult(
//       result: result,
//       onSuccess: (data) {
//         claimController.getAllImages();
//         claimController.loadDamageAssessData(autoChangeTab: false);
//       },
//       shouldShowFailure: (f) => true,
//     );
//     update();
//   }
// }
