// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cood/features/home/domain/entities/user_social_media_entity.dart';
import 'package:flutter/material.dart';

import 'package:cood/features/home/presentation/widgets/myAccounts/social_container_item.dart';

/// A widget that displays a scrollable list of social accounts with customizable colors.
class SocialAccounts extends StatelessWidget {
  const SocialAccounts({
    super.key,
    required this.socialAccounts,
  });

  /// List of social accounts to be displayed.
  final List<SocialMediaEntity> socialAccounts;
  

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      shrinkWrap: true,
      itemCount: socialAccounts.length,
      itemBuilder: (context, index) {
        return SocialContainerItem(
          socialAccount: socialAccounts[index],
        );
      },
    );
  }
}
