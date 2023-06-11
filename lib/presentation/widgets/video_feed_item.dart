// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/models/feeds_model.dart';

class VideoFeedItem extends StatefulWidget {
  final Feed feed;

  const VideoFeedItem({super.key, required this.feed});

  @override
  _VideoFeedItemState createState() => _VideoFeedItemState();
}

class _VideoFeedItemState extends State<VideoFeedItem> {
  late VideoPlayerController _videoPlayerController;
  bool isPlayingBool = false;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.asset(widget.feed.videoUrl ?? "assets/image1.mp4")
          ..initialize().then((value) {
            _videoPlayerController.play();
            _videoPlayerController.setLooping(true);
            setState(() {
              isPlayingBool = false;
            });
          });
    _videoPlayerController.addListener(() {
      setState(() {
        _progress = _videoPlayerController.value.position.inMilliseconds /
            _videoPlayerController.value.duration.inMilliseconds;
      });
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Widget isPlaying() {
    return _videoPlayerController.value.isPlaying && !isPlayingBool
        ? Container()
        : const Icon(
            Icons.play_arrow,
            size: 80,
            color: Colors.black,
          );
  }

  void _seekTo(double progress) {
    final duration = _videoPlayerController.value.duration;
    final newPosition = duration * progress;
    _videoPlayerController.seekTo(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          _videoPlayerController.value.isPlaying
              ? _videoPlayerController.pause()
              : _videoPlayerController.play();
        });
      },
      child: Stack(children: [
        SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: VideoPlayer(_videoPlayerController),
        ),
        Center(child: isPlaying()),
        SizedBox(
          height: size.height,
          width: size.width,
          child: Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 50.0, left: 24.0, bottom: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(
                      "Video title: ${widget.feed.title!}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Video duration: ${widget.feed.duration!}",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      copyVideoFromAssets(widget.feed.videoUrl!).then((value) {
                        if (!value) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(showSnackBar(false));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(showSnackBar(true));
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 50.0, right: 24.0, bottom: 50.0),
                      child: Center(
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.download,
                              color: Colors.white,
                              size: 23,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          children: [
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Slider(
                value: _progress,
                onChanged: (double value) {
                  setState(() {
                    _progress = value;
                  });
                  _seekTo(value);
                },
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

Future<bool> copyVideoFromAssets(String videoAssetsLocation) async {
  try {
    String videoAssetPath =
        videoAssetsLocation; //  the actual asset path of your video
    const String videoFileName =
        'my_video.mp4'; // the desired filename for the video

    // Get the temporary directory path where the video will be copied
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;

    final ByteData assetData = await rootBundle.load(videoAssetPath);
    final File videoFile = File('$tempPath/$videoFileName');
    await videoFile.writeAsBytes(assetData.buffer.asUint8List());

    return true;
  } catch (e) {
    // Error occurred while copying the video
    log('Error: $e');
    return false;
  }
}

showSnackBar(bool isDownloaded) {
  return SnackBar(
    content: Text(isDownloaded
        ? 'Success: The video have been downloaded'
        : 'There was an error downloading the video'),
    duration: const Duration(seconds: 3),
  );
}
