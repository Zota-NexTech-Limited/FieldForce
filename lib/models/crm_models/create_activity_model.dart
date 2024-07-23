import 'dart:convert';
CreateActivityModel createActivityModelFromJson(String str) => CreateActivityModel.fromJson(json.decode(str));
String createActivityModelToJson(CreateActivityModel data) => json.encode(data.toJson());

class CreateActivityModel {
  String? activityName;
  String? activityDueDate;
  String? activityAssignTo;
  String? activitySummary;
  String? activityNotes;

  CreateActivityModel({
     this.activityName,
     this.activityDueDate,
     this.activityAssignTo,
     this.activitySummary,
     this.activityNotes,
  });

  factory CreateActivityModel.fromJson(Map<String, dynamic> json) => CreateActivityModel(
    activityName: json["activity_name"]==null?"":json['activity_name'].toString(),
    activityDueDate: json["activity_due_date"]==null?"":json['activity_due_date'].toString(),
    activityAssignTo: json["activity_assign_to"]==null?"":json['activity_assign_to'].toString(),
    activitySummary: json["activity_summary"]==null?"":json['activity_summary'].toString(),
    activityNotes: json["activity_notes"]==null?"":json['activity_notes'].toString(),
  );

  Map<String, dynamic> toJson() => {
    "activity_name": activityName,
    "activity_due_date": activityDueDate,
    "activity_assign_to": activityAssignTo,
    "activity_summary": activitySummary,
    "activity_notes": activityNotes,
  };
}
