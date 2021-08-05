class AppUser {
  String? uid;
  String? displayName;
  String? email;
  String? photoUrl;
  AppUser({this.uid, this.displayName, this.email, this.photoUrl});

  AppUser.fromJson(Map<String, dynamic> json) {
    this.uid = json["uid"];
    this.displayName = json["display_name"];
    this.email = json["email"];
    this.photoUrl = json["photo_url"];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data["uid"] = this.uid;
    data["display_name"] = this.displayName;
    data["email"] = this.email;
    data["photo_url"] = this.photoUrl;
    return data;
  }
}
