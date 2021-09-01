import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/screens/conversation/show_media.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:flutter/material.dart';

class ImageItem extends StatelessWidget {
  const ImageItem({Key? key, required this.isMe, required this.medias})
      : super(key: key);
  final bool isMe;
  final List<String> medias;
  @override
  Widget build(BuildContext context) {
    if (medias.length == 1) {
      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: primaryColor, width: 0.5),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              ShowMediaScreen(type: "image", url: medias[0])));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: medias[0].isEmpty
                      ? Image.asset(
                          placeholderImage,
                          fit: BoxFit.cover,
                        )
                      : CachedNetworkImage(
                          imageUrl: medias[0],
                          placeholder: (context, url) => Image.asset(
                            placeholderImage,
                            fit: BoxFit.cover,
                          ),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            )
          ],
        ),
      );
    }
    if (medias.length > 1) {
      double width = (MediaQuery.of(context).size.width) * 0.7;
      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              child: Wrap(
                alignment: isMe ? WrapAlignment.end : WrapAlignment.start,
                spacing: 1,
                runSpacing: 1,
                children: List.generate(
                    medias.length,
                    (index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ShowMediaScreen(
                                        type: "image", url: medias[index])));
                          },
                          child: Container(
                            width: (width - 1) / 2,
                            height: (width - 1) / 2,
                            decoration: BoxDecoration(
                              borderRadius: borderRadius(index),
                              border:
                                  Border.all(color: primaryColor, width: 0.5),
                            ),
                            child: ClipRRect(
                              borderRadius: borderRadius(index),
                              child: medias[index].isEmpty
                                  ? Image.asset(
                                      placeholderImage,
                                      fit: BoxFit.cover,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: medias[index],
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        placeholderImage,
                                        fit: BoxFit.cover,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        )),
              ),
            )
          ],
        ),
      );
    }

    return Container();
  }

  BorderRadius borderRadius(int index) {
    if (index % 2 == 0) {
      if (index == medias.length - 1) {
        return BorderRadius.circular(10);
      }
      return BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(2),
          topRight: Radius.circular(2));
    } else {
      return BorderRadius.only(
          bottomLeft: Radius.circular(2),
          topLeft: Radius.circular(2),
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(10));
    }
  }
}
