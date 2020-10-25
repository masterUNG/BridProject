class UserModel {
  String uUsername;
  String uPassword;
  String uRealname;
  String uAddress;
  String uIdnum;
  String uTelephone;
  String uTelephone2;
  String uPosition;
  String uEmail;
  String uGender;
  String uEtc;

  UserModel(
      {this.uUsername,
      this.uPassword,
      this.uRealname,
      this.uAddress,
      this.uIdnum,
      this.uTelephone,
      this.uTelephone2,
      this.uPosition,
      this.uEmail,
      this.uGender,
      this.uEtc});

  UserModel.fromJson(Map<String, dynamic> json) {
    uUsername = json['u_username'];
    uPassword = json['u_password'];
    uRealname = json['u_realname'];
    uAddress = json['u_address'];
    uIdnum = json['u_idnum'];
    uTelephone = json['u_telephone'];
    uTelephone2 = json['u_telephone2'];
    uPosition = json['u_position'];
    uEmail = json['u_email'];
    uGender = json['u_gender'];
    uEtc = json['u_etc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['u_username'] = this.uUsername;
    data['u_password'] = this.uPassword;
    data['u_realname'] = this.uRealname;
    data['u_address'] = this.uAddress;
    data['u_idnum'] = this.uIdnum;
    data['u_telephone'] = this.uTelephone;
    data['u_telephone2'] = this.uTelephone2;
    data['u_position'] = this.uPosition;
    data['u_email'] = this.uEmail;
    data['u_gender'] = this.uGender;
    data['u_etc'] = this.uEtc;
    return data;
  }
}
