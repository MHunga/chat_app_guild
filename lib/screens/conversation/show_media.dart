import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

class ShowMediaScreen extends StatefulWidget {
  const ShowMediaScreen({Key? key, required this.type, required this.url})
      : super(key: key);
  final String type;
  final String url;
  @override
  _ShowMediaScreenState createState() => _ShowMediaScreenState();
}

class _ShowMediaScreenState extends State<ShowMediaScreen> {
  VideoPlayerController? controller;
  Future<void>? initializeVideoPlayerFuture;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    if (widget.type == "video") {
      controller = VideoPlayerController.network(widget.url);
      initializeVideoPlayerFuture = controller!.initialize();
      controller!.addListener(() {
        print(controller!.value.duration);
        print(controller!.value.position);
      });
      chewieController = ChewieController(
        videoPlayerController: controller!,
        autoPlay: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(backIcon,
                        color: primaryColor, height: 30, width: 30),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Expanded(
                child: Center(
              child: widget.type == "image"
                  ? CachedNetworkImage(imageUrl: widget.url)
                  : FutureBuilder(
                      future: initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          chewieController!.play();
                          return AspectRatio(
                            aspectRatio: controller!.value.aspectRatio,
                            child: Chewie(
                              controller: chewieController!,
                            ),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
            ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (controller != null) {
      controller!.dispose();
      chewieController!.dispose();
    }
  }
}
