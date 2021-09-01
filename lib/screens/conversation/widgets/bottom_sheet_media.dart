import 'dart:typed_data';

import 'package:chat_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheetMedia extends StatefulWidget {
  const BottomSheetMedia({
    Key? key,
    required this.mediaData,
  }) : super(key: key);

  final List<Uint8List> mediaData;

  @override
  _BottomSheetMediaState createState() => _BottomSheetMediaState();
}

class _BottomSheetMediaState extends State<BottomSheetMedia> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) => Container(
        margin: EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          color: Color(0xffe9e9e9),
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 6,
                width: 70,
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Color(0xff6a6a6a),
                    borderRadius: BorderRadius.circular(3)),
              ),
            ),
            Expanded(
              child: ChangeNotifierProvider<SelectMediaController>(
                  create: (_) => SelectMediaController(widget.mediaData.length),
                  builder: (context, child) {
                    return Stack(
                      children: [
                        SingleChildScrollView(
                          controller: scrollController,
                          child: SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              spacing: 1,
                              runSpacing: 1,
                              children: List.generate(widget.mediaData.length,
                                  (index) {
                                final width =
                                    (MediaQuery.of(context).size.width - 2) / 3;
                                return GestureDetector(
                                  onTap: () {
                                    context
                                        .read<SelectMediaController>()
                                        .select(index);
                                  },
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: width,
                                        height: width,
                                        child: Image.memory(
                                          widget.mediaData[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      if (context
                                          .watch<SelectMediaController>()
                                          .listSelectMedia[index]
                                          .isSelected)
                                        Container(
                                          width: width,
                                          height: width,
                                          color: Colors.white30,
                                          child: Center(
                                            child: CircleAvatar(
                                              radius: 15,
                                              backgroundColor: primaryColor,
                                              child: Text(
                                                "${context.watch<SelectMediaController>().listSelectMedia[index].stt}",
                                                style: txtSemiBold(
                                                    14, Colors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        if (context
                            .watch<SelectMediaController>()
                            .listSelectMedia
                            .any((element) => element.isSelected))
                          Positioned(
                              bottom: 16,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: ElevatedButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: primaryColor,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 13, horizontal: 33),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(26))),
                                    onPressed: () {
                                      List<int> indexs = [];
                                      for (var item in context
                                          .read<SelectMediaController>()
                                          .listSelectMedia) {
                                        if (item.isSelected) {
                                          indexs.add(item.index);
                                        }
                                      }
                                      Navigator.pop(context, indexs);
                                    },
                                    child: Text(
                                      "Send",
                                      style: txtSemiBold(16),
                                    )),
                              ))
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectMediaController extends ChangeNotifier {
  int lengthMedia;
  List<SelectMedia> listSelectMedia = [];
  SelectMediaController(this.lengthMedia) {
    for (var i = 0; i < lengthMedia; i++) {
      listSelectMedia.add(SelectMedia(index: i, isSelected: false));
    }
  }

  select(int index) {
    if (listSelectMedia[index].isSelected) {
      listSelectMedia[index].isSelected = false;
      for (var i = 0; i < lengthMedia; i++) {
        if (listSelectMedia[i].stt != null) {
          if (listSelectMedia[i].stt! > listSelectMedia[index].stt!) {
            listSelectMedia[i].stt = listSelectMedia[i].stt! - 1;
          }
        }
      }
      listSelectMedia[index].stt = null;
    } else {
      listSelectMedia[index].isSelected = true;
      int x = 0;
      for (var i = 0; i < lengthMedia; i++) {
        if (listSelectMedia[i].isSelected) {
          x++;
        }
      }
      listSelectMedia[index].stt = x;
    }
    notifyListeners();
  }
}

class SelectMedia {
  int index;
  bool isSelected;
  int? stt;

  SelectMedia({required this.index, required this.isSelected, this.stt});
}
