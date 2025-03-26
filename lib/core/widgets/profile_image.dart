import 'dart:io';

import 'package:cood/core/utils/values/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '/injection_container.dart';
import '../utils/constants.dart';
import 'diff_img.dart';

class ProfileImage extends StatefulWidget {
  final ValueChanged<File>? updateBannerImage;
  final String? image;
  const ProfileImage({super.key, this.updateBannerImage, this.image});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final ImagePicker _picker = ImagePicker();
  File? avatarImageFile;

  @override
  Widget build(BuildContext context) {
    double width = 110.w;
    // double raduis = width * 0.5;
    double raduis = 12.r;
    double height = 110.h;
    return InkWell(
      onTap: () => onPickImage(),
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: width,
              height: width,
              decoration: BoxDecoration(
                color: colors.borderColor,
                borderRadius: BorderRadius.circular(raduis),
              ),
              child: avatarImageFile == null
                  ? widget.image == null
                      ? const SizedBox()
                      // ClipRRect(
                      //             borderRadius: BorderRadius.circular(raduis),
                      //             child: Padding(
                      //               padding: EdgeInsets.all(16.r),
                      //               child: const Icon(FontAwesomeIcons.camera),
                      //             ),
                      //           )
                      : DiffImage(
                          width: width,
                          height: width,
                          image: widget.image ?? '',
                          fitType: BoxFit.cover,
                          radius: raduis,
                        )
                  : Container(
                      decoration: const BoxDecoration(
                        color: Color(0xffEDEEEF),
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(raduis),
                        child: Image.file(
                          avatarImageFile!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
            Positioned(
              bottom: -10,
              right: -10,
              child: Image.asset(
                ImgAssets.editProfileImage,
                fit: BoxFit.fill,
                height: 25.h,
                width: 25.w,
              ),
            ),
          ],
        ),
        // ),
        // Positioned(
        //   bottom: 15,
        //   left: 10,
        //   child: Container(
        //     width: 25,
        //     height: 25,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(5),
        //       color: colors(context).main,
        //     ),
        //     padding: const EdgeInsets.all(4),
        //     child: Icon(
        //       FontAwesomeIcons.pen,
        //       color: colors(context).backGround,
        //       size: 15,
        //     ),
        //   ),
        // ),
        //   ],
        // ),
      ),
    );
  }

  onPickImage() async {
    Constants.imagesSourcesShowModel(
      context: context,
      onCameraPressed: () => _onCameraTapped(),
      onGalleryPressed: () => _onGalleryTapped(),
    );
  }

  _onCameraTapped() async {
    Navigator.pop(context);
    final XFile? xImage = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 88,
    );
    File? image = xImage != null ? File(xImage.path) : null;
    if (!mounted) return;
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath =
        '${dir.absolute.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    if (image != null) {
      File? compressedFile = await Constants().getCompressedFile(
        image,
        targetPath,
      );
      setState(() {
        avatarImageFile = compressedFile ?? image;
      });
      widget.updateBannerImage!(avatarImageFile!);
    }
  }

  _onGalleryTapped() async {
    Navigator.pop(context);
    final XFile? xImage = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 88,
    );

    File? image = xImage != null ? File(xImage.path) : null;
    if (!mounted) return;
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath =
        '${dir.absolute.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    if (image != null) {
      File? compressedFile = await Constants().getCompressedFile(
        image,
        targetPath,
      );
      setState(() {
        avatarImageFile = compressedFile ?? image;
      });
      widget.updateBannerImage!(avatarImageFile!);
    }
  }
}
