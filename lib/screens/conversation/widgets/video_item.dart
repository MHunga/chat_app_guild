import 'package:chat_app/repositories/models/message.dart';
import 'package:chat_app/screens/conversation/show_media.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  const VideoItem({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);
  final Message message;
  final bool isMe;

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  VideoPlayerController? controller;
  Future<void>? initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    if (widget.message.medias![0].isNotEmpty) {
      controller = VideoPlayerController.network(widget.message.medias![0])
        ..initialize();
      initializeVideoPlayerFuture = controller!.initialize();
    }
  }

  @override
  void dispose() async {
    super.dispose();
    if (controller != null) {
      await controller!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Column(
            children: List.generate(
              widget.message.medias!.length,
              (index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ShowMediaScreen(
                              type: widget.message.type!,
                              url: widget.message.medias![0])));
                },
                child: widget.message.medias![index].isEmpty
                    ? Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 1),
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.7),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: primaryColor, width: 0.5)),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Center(
                              child: CircleAvatar(
                                radius: 26,
                                backgroundColor: Colors.black45,
                                child: SvgPicture.asset(
                                  videoIcon,
                                  color: Colors.white,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : FutureBuilder(
                        future: initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          return Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: primaryColor, width: 0.5)),
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  snapshot.connectionState ==
                                          ConnectionState.done
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: VideoPlayer(
                                            controller!,
                                          ))
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(placeholderImage)),
                                  CircleAvatar(
                                    radius: 26,
                                    backgroundColor: Colors.black45,
                                    child: SvgPicture.asset(
                                      videoIcon,
                                      color: Colors.white,
                                      height: 24,
                                      width: 24,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
