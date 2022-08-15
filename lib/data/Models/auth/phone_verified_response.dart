
class PhoneVerifiedResponse {
  PhoneVerifiedResponse({
    this.state,
    this.id,
    this.userExits,
    this.token,
  });

  String? state;
  String? id;
  bool? userExits;
  String? token;

  factory PhoneVerifiedResponse.fromJson(Map<String, dynamic> json) => PhoneVerifiedResponse(
    state: json["state"],
    id: json["id"],
    userExits: json["user_exits"],
    token: json["token"],
  );

}
