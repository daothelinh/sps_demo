class AuthRes {
  AuthRes({
    required this.msg,
    required this.assessorInfo,
  });

  String msg;
  AssessorInfo assessorInfo;

  factory AuthRes.fromJson(Map<String, dynamic> json) => AuthRes(
        msg: json["msg"] ?? '',
        assessorInfo: json["assessorInfo"] == null
            ? AssessorInfo.fromJson({})
            : AssessorInfo.fromJson(json["assessorInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "assessorInfo": assessorInfo.toJson(),
      };
}

class AssessorInfo {
  AssessorInfo({
    required this.assessorId,
    required this.fullName,
    required this.phoneNumber,
    required this.region,
  });
  String? assessorId;
  String? fullName;
  String? region;
  String? phoneNumber;
  factory AssessorInfo.fromJson(Map<String, dynamic> json) => AssessorInfo(
        assessorId: json["assessorId"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        region: json["region"],
      );
  Map<String, dynamic> toJson() => {
        "assessorId": assessorId,
        "fullName": fullName,
        "region": region,
        "phoneNumber": phoneNumber,
      };
}
