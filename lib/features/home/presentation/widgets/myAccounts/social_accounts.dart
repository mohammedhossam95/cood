// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cood/features/home/domain/entities/social_entity.dart';
import 'package:cood/features/home/presentation/widgets/myAccounts/social_container_item.dart';

/// A widget that displays a scrollable list of social accounts with customizable colors.
class SocialAccounts extends StatelessWidget {
  const SocialAccounts({
    super.key,
    required this.socialAccounts,
    required this.socialPhotoColors,
    required this.socialBackgroundColors,
  });

  /// List of social accounts to be displayed.
  final List<SocialEntity> socialAccounts;

  /// Colors for the social account photos.
  final List<Color> socialPhotoColors;

  /// Background colors for the social account containers.
  final List<Color> socialBackgroundColors;

  @override
  Widget build(BuildContext context) {
    assert(
      socialAccounts.length == socialPhotoColors.length &&
          socialAccounts.length == socialBackgroundColors.length,
      'The lengths of socialAccounts, socialPhotoColors, and socialBackgroundColors must match.',
    );

    return ListView.builder(
      shrinkWrap: true,
      itemCount: socialAccounts.length,
      itemBuilder: (context, index) {
        return SocialContainerItem(
          socialAccount: socialAccounts[index],
          socialPhotoColors: socialPhotoColors[index],
          socialBackgroundColors: socialBackgroundColors[index],
        );
      },
    );
  }
}
