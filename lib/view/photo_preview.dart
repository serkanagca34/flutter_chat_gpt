// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';

// class PhotoPreviewScreen extends StatefulWidget {
//   final File photoFile;

//   PhotoPreviewScreen({required this.photoFile});

//   @override
//   _PhotoPreviewScreenState createState() => _PhotoPreviewScreenState();
// }

// class _PhotoPreviewScreenState extends State<PhotoPreviewScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Photo Preview')),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Center(
//               child: Image.file(widget.photoFile),
//             ),
//             TextButton(
//               onPressed: () {
//                 // imageCropperView(widget.photoFile.path, context);
//               },
//               child: Text('Crop Image'),
//             ),
//             SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }

//   void imageCropperView(String path, BuildContext context) async {
//     CroppedFile? croppedFile = await ImageCropper().cropImage(
//       sourcePath: path,
//       aspectRatioPresets: [
//         CropAspectRatioPreset.square,
//         CropAspectRatioPreset.ratio3x2,
//         CropAspectRatioPreset.original,
//         CropAspectRatioPreset.ratio4x3,
//         CropAspectRatioPreset.ratio16x9
//       ],
//       uiSettings: [
//         AndroidUiSettings(
//             toolbarTitle: 'Crop Image',
//             toolbarColor: Colors.deepOrange,
//             toolbarWidgetColor: Colors.white,
//             initAspectRatio: CropAspectRatioPreset.original,
//             lockAspectRatio: false),
//         IOSUiSettings(
//           title: 'Crop Image',
//         ),
//         WebUiSettings(
//           context: context,
//         ),
//       ],
//     );
//     if (croppedFile != null) {
//       print('Image Cropped');
//     } else {
//       print('Image Cropped');
//     }
//   }
// }
