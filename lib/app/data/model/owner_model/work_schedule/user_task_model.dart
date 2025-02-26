import 'dart:convert';

class UserTaskModel {
  int? statusCode;
  bool? success;
  String? message;
  UserTaskData? data;

  UserTaskModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory UserTaskModel.fromRawJson(String str) => UserTaskModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserTaskModel.fromJson(Map<String, dynamic> json) => UserTaskModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : UserTaskData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class UserTaskData {
  Meta? meta;
  List<Result>? result;

  UserTaskData({
    this.meta,
    this.result,
  });

  factory UserTaskData.fromRawJson(String str) => UserTaskData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserTaskData.fromJson(Map<String, dynamic> json) => UserTaskData(
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
  Recurrence? recurrence;
  String? startDateStr;
  StartTimeStr? startTimeStr;
  DateTime? startDateTime;
  String? endDateStr;
  EndTimeStr? endTimeStr;
  DateTime? endDateTime;
  String? dayOfWeek;
  String? taskDetails;
  AdditionalMessage? additionalMessage;
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
    taskName: json["taskName"], // ✅ Null check fix
    recurrence: recurrenceValues.map[json["recurrence"]] ?? Recurrence.WEEKLY, // ✅ Default value
    startDateStr: json["startDateStr"] ?? "",
    startTimeStr: startTimeStrValues.map[json["startTimeStr"]] ?? StartTimeStr.THE_0220_PM, // ✅ Fix
    startDateTime: json["startDateTime"] != null ? DateTime.parse(json["startDateTime"]) : null,
    endDateStr: json["endDateStr"] ?? "",
    endTimeStr: endTimeStrValues.map[json["endTimeStr"]] ?? EndTimeStr.THE_0150_AM,
    endDateTime: json["endDateTime"] != null ? DateTime.parse(json["endDateTime"]) : null,
    dayOfWeek: json["dayOfWeek"] ?? "Unknown",
    taskDetails:json["taskDetails"],
    additionalMessage: additionalMessageValues.map[json["additionalMessage"]] ?? AdditionalMessage.GG,
    status: json["status"], // ✅ Null check
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "room": room,
    "assignedTo": assignedTo?.toJson(),
    "taskName": taskName,
    "recurrence": recurrenceValues.reverse[recurrence],
    "startDateStr": startDateStr,
    "startTimeStr": startTimeStrValues.reverse[startTimeStr],
    "startDateTime": startDateTime?.toIso8601String(),
    "endDateStr": endDateStr,
    "endTimeStr": endTimeStrValues.reverse[endTimeStr],
    "endDateTime": endDateTime?.toIso8601String(),
    "dayOfWeek": dayOfWeek,
    "taskDetails": taskDetails,
    "additionalMessage": additionalMessageValues.reverse[additionalMessage],
    "status":status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

enum AdditionalMessage {
  GG,
  USE_THE_NEW_CLEANING_SUPPLIES_UNDER_THE_SINK
}

final additionalMessageValues = EnumValues({
  "gg": AdditionalMessage.GG,
  "Use the new cleaning supplies under the sink.": AdditionalMessage.USE_THE_NEW_CLEANING_SUPPLIES_UNDER_THE_SINK
});

class AssignedTo {
  String? id;
  String? email;
  String? profileImage;
  List<WorkingDay>? workingDay;
  String? firstName;
  String? lastName;

  AssignedTo({
    this.id,
    this.email,
    this.profileImage,
    this.workingDay,
    this.firstName,
    this.lastName,
  });

  factory AssignedTo.fromRawJson(String str) => AssignedTo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssignedTo.fromJson(Map<String, dynamic> json) => AssignedTo(
    id: json["_id"],
    email: json["email"],
    profileImage: json["profile_image"],
    workingDay: json["workingDay"] == null ? [] : List<WorkingDay>.from(json["workingDay"]!.map((x) => workingDayValues.map[x]!)),
    firstName: json["firstName"],
    lastName: json["lastName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "profile_image": profileImage,
    "workingDay": workingDay == null ? [] : List<dynamic>.from(workingDay!.map((x) => workingDayValues.reverse[x])),
    "firstName": firstName,
    "lastName": lastName,
  };
}

enum WorkingDay {
  FRIDAY,
  MONDAY,
  THURSDAY,
  TUESDAY,
  WEDNESDAY
}

final workingDayValues = EnumValues({
  "Friday": WorkingDay.FRIDAY,
  "Monday": WorkingDay.MONDAY,
  "Thursday": WorkingDay.THURSDAY,
  "Tuesday": WorkingDay.TUESDAY,
  "Wednesday": WorkingDay.WEDNESDAY
});

enum EndTimeStr {
  THE_0150_AM,
  THE_0619_PM,
  THE_150_AM
}

final endTimeStrValues = EnumValues({
  "01:50 AM": EndTimeStr.THE_0150_AM,
  "06:19 PM": EndTimeStr.THE_0619_PM,
  "1:50 AM": EndTimeStr.THE_150_AM
});

enum Recurrence {
  ONE_TIME,
  WEEKLY
}

final recurrenceValues = EnumValues({
  "one_time": Recurrence.ONE_TIME,
  "weekly": Recurrence.WEEKLY
});

enum StartTimeStr {
  THE_0220_PM,
  THE_0619_PM,
  THE_130_AM
}

final startTimeStrValues = EnumValues({
  "02:20 PM": StartTimeStr.THE_0220_PM,
  "06:19 PM": StartTimeStr.THE_0619_PM,
  "1:30 AM": StartTimeStr.THE_130_AM
});

enum Statusd {
  COMPLETED,
  ONGOING,
  PENDING
}

final statusValues = EnumValues({
  "completed": Statusd.COMPLETED,
  "ongoing": Statusd.ONGOING,
  "pending": Statusd.PENDING
});

enum TaskDetails {
  GG,
  VACUUM_AND_MOP_THE_LIVING_ROOM_AND_BEDROOMS
}

final taskDetailsValues = EnumValues({
  "gg": TaskDetails.GG,
  "Vacuum and mop the living room and bedrooms.": TaskDetails.VACUUM_AND_MOP_THE_LIVING_ROOM_AND_BEDROOMS
});

enum TaskName {
  DESK_CLEANING,
  GGG
}

final taskNameValues = EnumValues({
  "Desk Cleaning": TaskName.DESK_CLEANING,
  "ggg": TaskName.GGG
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
