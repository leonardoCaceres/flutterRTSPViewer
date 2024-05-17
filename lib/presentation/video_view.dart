import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:spici/presentation/config_page.dart';

class VideoView extends ConsumerWidget {
  const VideoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rtspURL = ref.watch(rtspStateProvider);
    // Create a [Player] to control playback.
    final player = Player();
    player.open(
      Media(rtspURL),
    );
    // Create a [VideoController] to handle video output from [Player].
    final controller = VideoController(player);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(Icons.close_sharp),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        Expanded(
          child: Video(
            controller: controller,
            subtitleViewConfiguration:
                const SubtitleViewConfiguration(visible: false),
          ),
        ),
      ],
    );
  }
}
//width: MediaQuery.of(context).size.width,
//height: MediaQuery.of(context).size.width * 9.0 / 16.0,