class LoginStatus {
  String? loginID;
  String? sessionID;

  LoginStatus({
    this.loginID,
    this.sessionID,
  });

  LoginStatus.fromJson(Map<String, dynamic> json)
      : loginID = json["login_id"],
        sessionID = json["session_id"];

  Map<String, dynamic> toJson() => {
        'login_id': loginID,
        'session_id': sessionID,
      };
}
