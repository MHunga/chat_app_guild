class RoomChat {
  String? id;
  List<String>? membersId;
  String? message;
  String? senderId;
  int? timeStamp;

  RoomChat(
      {this.id, this.membersId, this.message, this.senderId, this.timeStamp});

  RoomChat.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.membersId = json["members_id"] == null
        ? null
        : List<String>.from(json["members_id"]);
    this.message = json["message"];
    this.senderId = json["sender_id"];
    this.timeStamp = json["time_stamp"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    if (this.membersId != null) data["members_id"] = this.membersId;
    data["message"] = this.message;
    data["sender_id"] = this.senderId;
    data["time_stamp"] = this.timeStamp;
    return data;
  }
}
