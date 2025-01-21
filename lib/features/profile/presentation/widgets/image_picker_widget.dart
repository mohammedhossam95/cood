import 'dart:io';

// import '/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '/core/utils/constants.dart';
import '/core/widgets/diff_img.dart';
import '/injection_container.dart';

class ImagePickerWidget extends StatefulWidget {
  final ValueChanged<File>? updateBannerImage;
  final String? image;
  const ImagePickerWidget({super.key, this.updateBannerImage, this.image});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _picker = ImagePicker();
  File? avatarImageFile;

  @override
  Widget build(BuildContext context) {
    double width = ScreenUtil().screenWidth;
    double raduis = width * 0.5;
    double height = 120.h;
    return InkWell(
      onTap: () => onPickImage(),
      child: SizedBox(
        width: width,
        height: height,
        child: Container(
          width: width,
          height: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: colors.dividerColor,
              )),
          child: avatarImageFile == null
              ? widget.image == null
                  ? const SizedBox()
                  : DiffImage(
                      width: width,
                      height: width,
                      image: widget.image ?? '',
                      fitType: BoxFit.cover,
                      radius: raduis,
                    )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.file(
                      avatarImageFile!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        ),
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
