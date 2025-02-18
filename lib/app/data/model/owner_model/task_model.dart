import 'dart:convert';

class GetTaskModel {
  int? statusCode;
  bool? success;
  String? message;
  TaskData? data;

  GetTaskModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory GetTaskModel.fromRawJson(String str) => GetTaskModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetTaskModel.fromJson(Map<String, dynamic> json) => GetTaskModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : TaskData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class TaskData {
  Meta? meta;
  List<Result>? result;

  TaskData({
    this.meta,
    this.result,
  });

  factory TaskData.fromRawJson(String str) => TaskData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskData.fromJson(Map<String, dynamic> json) => TaskData(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta?.toJson(),
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Meta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json["page"],
    limit: json["limit"],
    total: json["total"],
    totalPage: json["totalPage"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "totalPage": totalPage,
  };
}

class Result {
  String? id;
  String? user;
  String? room;
  AssignedTo? assignedTo;
  String? taskName;
  String? recurrence;
  String? startDateStr;
  String? startTimeStr;
  DateTime? startDateTime;
  String? endDateStr;
  String? endTimeStr;
  DateTime? endDateTime;
  DayOfWeek? dayOfWeek;
  String? taskDetails;
  String? additionalMessage;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Result({
    this.id,
    this.user,
    this.room,
    this.assignedTo,
    this.taskName,
    this.recurrence,
    this.startDateStr,
    this.startTimeStr,
    this.startDateTime,
    this.endDateStr,
    this.endTimeStr,
    this.endDateTime,
    this.dayOfWeek,
    this.taskDetails,
    this.additionalMessage,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    user: json["user"],
    room: json["room"],
    assignedTo: json["assignedTo"] == null ? null : AssignedTo.fromJson(json["assignedTo"]),
    taskName: json["taskName"],
    recurrence: json["recurrence"],
    startDateStr: json["startDateStr"],
    startTimeStr: json["startTimeStr"],
    startDateTime: json["startDateTime"] == null ? null : DateTime.parse(json["startDateTime"]),
    endDateStr: json["endDateStr"],
    endTimeStr: json["endTimeStr"],
    endDateTime: json["endDateTime"] == null ? null : DateTime.parse(json["endDateTime"]),
    dayOfWeek: dayOfWeekValues.map[json["dayOfWeek"]]!,
    taskDetails: json["taskDetails"],
    additionalMessage: json["additionalMessage"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "room": room,
    "assignedTo": assignedTo?.toJson(),
    "taskName": taskName,
    "recurrence": recurrence,
    "startDateStr": startDateStr,
    "startTimeStr": startTimeStr,
    "startDateTime": startDateTime?.toIso8601String(),
    "endDateStr": endDateStr,
    "endTimeStr": endTimeStr,
    "endDateTime": endDateTime?.toIso8601String(),
    "dayOfWeek": dayOfWeekValues.reverse[dayOfWeek],
    "taskDetails": taskDetails,
    "additionalMessage": additionalMessage,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class AssignedTo {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? profileImage;
  List<DayOfWeek>? workingDay;

  AssignedTo({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.profileImage,
    this.workingDay,
  });

  factory AssignedTo.fromRawJson(String str) => AssignedTo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssignedTo.fromJson(Map<String, dynamic> json) => AssignedTo(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    profileImage: json["profile_image"],
    workingDay: json["workingDay"] == null ? [] : List<DayOfWeek>.from(json["workingDay"]!.map((x) => dayOfWeekValues.map[x]!)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "profile_image": profileImage,
    "workingDay": workingDay == null ? [] : List<dynamic>.from(workingDay!.map((x) => dayOfWeekValues.reverse[x])),
  };
}

enum DayOfWeek {
  FRIDAY,
  MONDAY,
  THURSDAY,
  TUESDAY,
  WEDNESDAY
}

final dayOfWeekValues = EnumValues({
  "Friday": DayOfWeek.FRIDAY,
  "Monday": DayOfWeek.MONDAY,
  "Thursday": DayOfWeek.THURSDAY,
  "Tuesday": DayOfWeek.TUESDAY,
  "Wednesday": DayOfWeek.WEDNESDAY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
