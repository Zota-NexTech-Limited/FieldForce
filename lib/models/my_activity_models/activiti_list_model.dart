// To parse this JSON data, do
//
//     final activityListModel = activityListModelFromJson(jsonString);

import 'dart:convert';

List<ActivityListModel> activityListModelFromJson(String str) => List<ActivityListModel>.from(json.decode(str).map((x) => ActivityListModel.fromJson(x)));

String activityListModelToJson(List<ActivityListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityListModel {
  String ?date;
  List<Activity> ?activity;

  ActivityListModel({
     this.date,
     this.activity,
  });

  factory ActivityListModel.fromJson(Map<String, dynamic> json) => ActivityListModel(
    date: json["date"]==null?"": json["date"].toString(),
    activity: List<Activity>.from(json["activity"].map((x) => Activity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "activity": List<dynamic>.from(activity!.map((x) => x.toJson())),
  };
}

class Activity {
  String? activityId;
  String? activityName;
  String? activityDueDate;
  String? activityAssignTo;
  String? activitySummary;
  String? activityNotes;
  String? updateDate;
  String? createdDate;

  Activity({
    this.activityId,
    this.activityName,
    this.activityDueDate,
    this.activityAssignTo,
    this.activitySummary,
    this.activityNotes,
    this.updateDate,
    this.createdDate,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    activityId: json["activity_id"]==null?"":json["activity_id"].toString(),
    activityName: json["activity_name"]==null?"":json["activity_name"].toString(),
    activityDueDate: json["activity_due_date"]==null?"":json["activity_due_date"].toString(),
    activityAssignTo: json["activity_assign_to"]==null?"":json["activity_assign_to"].toString(),
    activitySummary: json["activity_summary"]==null?"":json["activity_summary"].toString(),
    activityNotes: json["activity_notes"]==null?"":json["activity_notes"].toString(),
    updateDate: json["update_date"]==null?"":json["update_date"].toString(),
    createdDate: json["created_date"]==null?"":json["created_date"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "activity_id": activityId,
    "activity_name": activityName,
    "activity_due_date": activityDueDate,
    "activity_assign_to": activityAssignTo,
    "activity_summary": activitySummary,
    "activity_notes": activityNotes,
    "update_date": updateDate,
    "created_date": createdDate,
  };
}