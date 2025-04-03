import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:cood/config/routes/app_routes.dart';
import 'package:cood/core/utils/values/text_styles.dart';
import 'package:cood/core/widgets/gaps.dart';
import 'package:cood/core/widgets/loading_view.dart';
import 'package:cood/core/widgets/my_default_button.dart';
import 'package:cood/features/discover/presentation/cubit/add_story_cubit/add_story_cubit.dart';
import 'package:cood/injection_container.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class PreviewParams extends Equatable {
  final File mediaFile;
  final bool isVideo;

  const PreviewParams({
    required this.mediaFile,
    required this.isVideo,
  });
  @override
  List<Object?> get props => [
        mediaFile,
        isVideo,
      ];
}

class StoryPreviewScreen extends StatefulWidget {
  final PreviewParams params;
  const StoryPreviewScreen({
    super.key,
    required this.params,
  });

  @override
  State<StoryPreviewScreen> createState() => _StoryPreviewScreenState();
}

class _StoryPreviewScreenState extends State<StoryPreviewScreen> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  final TextEditingController _captionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.params.isVideo) {
      _videoPlayerController =
          VideoPlayerController.file(widget.params.mediaFile);
      _videoPlayerController!.initialize().then((_) {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          autoPlay: true,
          looping: false,
        );
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backGround,
      appBar: AppBar(),
      body: Stack(
        children: [
          Center(
            child: widget.params.isVideo
                ? (_chewieController != null
                    ? Chewie(controller: _chewieController!)
                    : CircularProgressIndicator())
                : Image.file(widget.params.mediaFile),
          ),
          Positioned(
            bottom: 20,
            left: 50.w,
            right: 50.w,
            child: BlocConsumer<AddStoryCubit, StoryState>(
              listener: (context, state) {
                if (state is StorySuccess) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.mainPageRoute,
                    (route) => false,
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    (state is StoryLoading)
                        ? LoadingView()
                        : MyDefaultButton(
                            onPressed: () {
                              context
                                  .read<AddStoryCubit>()
                                  .addStory(widget.params);
                            },
                            btnText: "add",
                          ),
                    if (state is StoryFailure) ...[
                      Gaps.vGap10,
                      Text(
                        state.errorMessage,
                        style: TextStyles.regular10(
                          color: colors.errorColor,
                        ),
                      ),
                    ]
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
