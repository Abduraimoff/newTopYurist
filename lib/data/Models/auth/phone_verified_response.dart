
class PhoneVerifiedResponse {
  PhoneVerifiedResponse({
    this.state,
    this.id,
    this.userExits,
    this.token,
    this.error
  });

  String? state;
  String? id;
  bool? userExits;
  String? token;
  String? error;

  factory PhoneVerifiedResponse.fromJson(Map<String, dynamic> json) => PhoneVerifiedResponse(
    state: json["state"],
    id: json["id"],
    userExits: json["user_exits"],
    token: json["token"],
  );

}
