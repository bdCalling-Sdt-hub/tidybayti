import 'dart:convert';

class SingleEmployeeModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final SingleEmployeeData? data;

  SingleEmployeeModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory SingleEmployeeModel.fromRawJson(String str) => SingleEmployeeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SingleEmployeeModel.fromJson(Map<String, dynamic> json) => SingleEmployeeModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : SingleEmployeeData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class SingleEmployeeData {
  final String? id;
  final String? authId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? profileImage;
  final String? phoneNumber;
  final String? employer;
  final String? jobType;
  final String? cprNumber;
  final String? cprExpDate;
  final String? passportNumber;
  final String? passportExpDate;
  final String? note;
  final String? dutyTime;
  final String? breakTimeStart;
  final String? breakTimeEnd;
  final List<String>? workingDay;
  final String? offDay;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? employeeId;

  SingleEmployeeData({
    this.id,
    this.authId,
    this.firstName,
    this.lastName,
    this.email,
    this.profileImage,
    this.phoneNumber,
    this.employer,
    this.jobType,
    this.cprNumber,
    this.cprExpDate,
    this.passportNumber,
    this.passportExpDate,
    this.note,
    this.dutyTime,
    this.workingDay,
    this.offDay,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.employeeId,
    this.breakTimeStart,
    this.breakTimeEnd
  });

  factory SingleEmployeeData.fromRawJson(String str) => SingleEmployeeData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SingleEmployeeData.fromJson(Map<String, dynamic> json) => SingleEmployeeData(
    id: json["_id"],
    authId: json["authId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    profileImage: json["profile_image"],
    phoneNumber: json["phoneNumber"],
    employer: json["employer"],
    jobType: json["jobType"],
    cprNumber: json["CPRNumber"],
    cprExpDate: json["CPRExpDate"],
    passportNumber: json["passportNumber"],
    passportExpDate: json["passportExpDate"],
    note: json["note"],
    dutyTime: json["dutyTime"],
    breakTimeStart: json["breakTimeStart"],
    breakTimeEnd: json["breakTimeEnd"],
    workingDay: json["workingDay"] == null ? [] : List<String>.from(json["workingDay"]!.map((x) => x)),
    offDay: json["offDay"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    employeeId: json["employeeId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "authId": authId,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "profile_image": profileImage,
    "phoneNumber": phoneNumber,
    "employer": employer,
    "jobType": jobType,
    "CPRNumber": cprNumber,
    "CPRExpDate": cprExpDate,
    "passportNumber": passportNumber,
    "passportExpDate": passportExpDate,
    "note": note,
    "dutyTime": dutyTime,
    "breakTimeStart": breakTimeStart,
    "breakTimeEnd": breakTimeEnd,
    "workingDay": workingDay == null ? [] : List<dynamic>.from(workingDay!.map((x) => x)),
    "offDay": offDay,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "employeeId": employeeId,
  };
}
