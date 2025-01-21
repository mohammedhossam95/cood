import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

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
    double width = 350.w;
    // double raduis = width * 0.5;
    double raduis = 12.r;
    double height = 120.h;
    return InkWell(
      onTap: () => onPickImage(),
      child: SizedBox(
        width: width,
        height: height,
        child:
            // Stack(
            //   alignment: Alignment.center,
            //   children: <Widget>[
            // Positioned(
            //   top: 0,
            //   child:
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
    if (!mounted) return;
    if (xImage != null) {
      setState(() {
        avatarImageFile = File(xImage.path);
        widget.updateBannerImage!(avatarImageFile!);
      });
    }
  }

  _onGalleryTapped() async {
    Navigator.pop(context);
    final XFile? xImage = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 88,
    );
    if (!mounted) return;
    if (xImage != null) {
      setState(() {
        avatarImageFile = File(xImage.path);
        widget.updateBannerImage!(avatarImageFile!);
      });
    }
  }
}
