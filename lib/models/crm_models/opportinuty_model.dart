// To parse this JSON data, do
//
//     final opportunityDetailsModel = opportunityDetailsModelFromJson(jsonString);

import 'dart:convert';

OpportunityDetailsModel opportunityDetailsModelFromJson(String str) => OpportunityDetailsModel.fromJson(json.decode(str));

String opportunityDetailsModelToJson(OpportunityDetailsModel data) => json.encode(data.toJson());

class OpportunityDetailsModel {
  String? opportunityId;
  String? opportunityName;
  String? opportunityValue;
  String? opportunityCloseDate;
  String? opportunityStage;
  String? opportunityProbabilityOfClose;
  String? opportunityContactName;
  String? opportunityNumber;
  String? opportunityEmail;
  String? opportunityCompanyName;
  String? opportunityIndustry;
  String? opportunitySource;
  String? opportunitySourceDetails;
  String? opportunityProducts;
  List<String> ?opportunityCompetitors;
  String? opportunityNextStep;
  String? opportunityNotes;
  DateTime? updateDate;
  DateTime? createdDate;

  OpportunityDetailsModel({
     this.opportunityId,
     this.opportunityName,
     this.opportunityValue,
     this.opportunityCloseDate,
     this.opportunityStage,
     this.opportunityProbabilityOfClose,
     this.opportunityContactName,
     this.opportunityNumber,
     this.opportunityEmail,
     this.opportunityCompanyName,
     this.opportunityIndustry,
     this.opportunitySource,
     this.opportunitySourceDetails,
     this.opportunityProducts,
     this.opportunityCompetitors,
     this.opportunityNextStep,
     this.opportunityNotes,
     this.updateDate,
     this.createdDate,
  });

  factory OpportunityDetailsModel.fromJson(Map<String, dynamic> json) => OpportunityDetailsModel(
    opportunityId: json["opportunity_id"]==null?"":json["opportunity_id"].toString(),
    opportunityName: json["opportunity_name"]==null?"":json["opportunity_name"].toString(),
    opportunityValue: json["opportunity_value"]==null?"":json["opportunity_value"].toString(),
    opportunityCloseDate: json["opportunity_close_date"]==null?"":json["opportunity_close_date"].toString(),
    opportunityStage: json["opportunity_stage"]==null?"":json["opportunity_stage"].toString(),
    opportunityProbabilityOfClose: json["opportunity_propability_of_close"]==null?"":json["opportunity_propability_of_close"].toString(),
    opportunityContactName: json["opportunity__contact_name"]==null?"":json["opportunity__contact_name"].toString(),
    opportunityNumber: json["opportunity_number"]==null?"":json["opportunity_number"].toString(),
    opportunityEmail: json["opportunity_email"]==null?"":json["opportunity_email"].toString(),
    opportunityCompanyName: json["opportunity_company_name"]==null?"":json["opportunity_company_name"].toString(),
    opportunityIndustry: json["opportunity_industry"]==null?"":json["opportunity_industry"].toString(),
    opportunitySource: json["opportunity_source"]==null?"":json["opportunity_source"].toString(),
    opportunitySourceDetails: json["opportunity_source_details"]==null?"":json["opportunity_source_details"].toString(),
    opportunityProducts: json["opportunity_products"]==null?"":json["opportunity_products"].toString(),
    opportunityCompetitors:json["opportunity_compitetors"]==null?[]:List<String>.from(json["opportunity_compitetors"].map((x) => x)),
    opportunityNextStep: json["opportunity_next_step"]==null?"":json["opportunity_next_step"].toString(),
    opportunityNotes: json["opportunity_notes"]==null?"":json["opportunity_notes"].toString(),
    updateDate:json["update_date"]==null?DateTime.now(): DateTime.parse(json["update_date"]) ,
    createdDate:json["created_date"]==null?DateTime.now(): DateTime.parse(json["created_date"]),
  );

  Map<String, dynamic> toJson() => {
    "opportunity_id": opportunityId,
    "opportunity_name": opportunityName,
    "opportunity_value": opportunityValue,
    "opportunity_close_date": opportunityCloseDate,
    "opportunity_stage": opportunityStage,
    "opportunity_propability_of_close": opportunityProbabilityOfClose,
    "opportunity__contact_name": opportunityContactName,
    "opportunity_number": opportunityNumber,
    "opportunity_email": opportunityEmail,
    "opportunity_company_name": opportunityCompanyName,
    "opportunity_industry": opportunityIndustry,
    "opportunity_source": opportunitySource,
    "opportunity_source_details": opportunitySourceDetails,
    "opportunity_products": opportunityProducts,
    "opportunity_compitetors": List<dynamic>.from(opportunityCompetitors!.map((x) => x)),
    "opportunity_next_step": opportunityNextStep,
    "opportunity_notes": opportunityNotes,
    //"update_date": updateDate!.toIso8601String(),
    //"created_date": createdDate!.toIso8601String(),
  };
}
