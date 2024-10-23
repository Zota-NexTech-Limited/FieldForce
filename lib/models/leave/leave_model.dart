
import 'dart:convert';

List<LeaveModel> leaveModelFromJson(String str) => List<LeaveModel>.from(json.decode(str).map((x) => LeaveModel.fromJson(x)));

String leaveModelToJson(List<LeaveModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveModel {
  String? date;
  List<Leave>? leave;

  LeaveModel({
     this.date,
     this.leave,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) => LeaveModel(
    date: json["date"]==null?"": json["date"].toString(),
    leave:json["leave"]==null?[]: List<Leave>.from(json["leave"].map((x) => Leave.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "leave": List<dynamic>.from(leave!.map((x) => x.toJson())),
  };
}

class Leave {
  String? leaveId;
  String ?userId;
  String? leaveType;
  DateTime? leaveFromDate;
  DateTime? leaveToDate;
  String? description;
  bool? isHalfday;
  DateTime? updateDate;
  DateTime? createdDate;

  Leave({
     this.leaveId,
     this.userId,
     this.leaveType,
     this.leaveFromDate,
     this.leaveToDate,
     this.description,
     this.isHalfday,
     this.updateDate,
     this.createdDate,
  });

  factory Leave.fromJson(Map<String, dynamic> json) => Leave(
    leaveId: json["leave_id"]==null?"":json["leave_id"].toString(),
    userId: json["user_id"]==null?"":json["user_id"].toString(),
    leaveType: json["leave_type"]==null?"":json["leave_type"].toString(),
    leaveFromDate: DateTime.parse(json["leave_from_date"]),
    leaveToDate: DateTime.parse(json["leave_to_date"]),
    description: json["description"]==null?"":json["description"].toString(),
    isHalfday: json["is_halfday"]??false,
    updateDate: DateTime.parse(json["update_date"]),
    createdDate: DateTime.parse(json["created_date"]),
  );

  Map<String, dynamic> toJson() => {
    "leave_id": leaveId,
    "user_id": userId,
    "leave_type": leaveType,
    "leave_from_date": leaveFromDate!.toIso8601String(),
    "leave_to_date": leaveToDate!.toIso8601String(),
    "description": description,
    "is_halfday": isHalfday,
    "update_date": updateDate!.toIso8601String(),
    "created_date": createdDate!.toIso8601String(),
  };
}
