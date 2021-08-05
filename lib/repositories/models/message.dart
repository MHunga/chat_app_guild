class Message {
  String? id;
  String? roomChatId;
  String? message;
  String? senderId;
  String? senderName;
  int? timeStamp;
  List<String>? medias;
  Message(
      {this.id,
      this.roomChatId,
      this.message,
      this.senderId,
      this.senderName,
      this.timeStamp,
      this.medias});

  Message.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.roomChatId = json["room_chat_id"];
    this.medias =
        json["medias"] == null ? null : List<String>.from(json["medias"]);
    this.message = json["message"];
    this.senderId = json["sender_id"];
    this.senderName = json["sender_name"];
    this.timeStamp = json["time_stamp"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["room_chat_id"] = this.roomChatId;
    data["message"] = this.message;
    data["sender_id"] = this.senderId;
    data["sender_name"] = this.senderName;
    data["medias"] = this.medias;
    data["time_stamp"] = this.timeStamp;
    return data;
  }
}
