// To parse this JSON data, do
//
//     final newLeadModel = newLeadModelFromJson(jsonString);

import 'dart:convert';

NewLeadModel newLeadModelFromJson(String str) => NewLeadModel.fromJson(json.decode(str));

String newLeadModelToJson(NewLeadModel data) => json.encode(data.toJson());

class NewLeadModel {
  String? leadId;
  String? leadFullName;
  String? leadContactName;
  String? leadContactTitle;
  String? leadCompanyName;
  String? leadCompanySize;
  String? leadIndustry;
  String? leadSource;
  String? leadPhoneNumber;
  String? leadEmail;
  String? leadWebsite;
  String? leadState;
  String? leadCity;
  String? leadPincode;
  String? leadAddress;
  String? leadProduct;
  String? leadDetails;
  String? leadQuantity;
  String? leadBudget;
  String? leadInquiryMedium;
  String? leadInquirySource;
  String? leadDescription;
  String? leadKeywords;
  String? leadRequirements;
  String? leadCompInformation;
  String? leadNextSteps;
  String? leadNotes;

  NewLeadModel({
     this.leadFullName,
     this.leadContactName,
     this.leadContactTitle,
     this.leadCompanyName,
     this.leadCompanySize,
     this.leadIndustry,
     this.leadSource,
     this.leadPhoneNumber,
     this.leadEmail,
     this.leadWebsite,
     this.leadState,
     this.leadCity,
     this.leadPincode,
     this.leadAddress,
     this.leadProduct,
     this.leadDetails,
     this.leadQuantity,
     this.leadBudget,
     this.leadInquiryMedium,
     this.leadInquirySource,
     this.leadDescription,
     this.leadKeywords,
     this.leadRequirements,
     this.leadCompInformation,
     this.leadNextSteps,
     this.leadNotes,
     this.leadId,
  });

  factory NewLeadModel.fromJson(Map<String, dynamic> json) => NewLeadModel(
    leadId: json["lead_id"]==null?"":json["lead_id"].toString(),
    leadFullName: json["lead_full_name"]==null?"":json["lead_full_name"].toString(),
    leadContactName: json["lead_contact_name"]==null?"":json["lead_contact_name"].toString(),
    leadContactTitle: json["lead_contact_title"]==null?"":json["lead_contact_title"].toString(),
    leadCompanyName: json["lead_company_name"]==null?"":json["lead_company_name"].toString(),
    leadCompanySize: json["lead_company_size"]==null?"":json["lead_company_size"].toString(),
    leadIndustry: json["lead_industry"]==null?"":json["lead_industry"].toString(),
    leadSource: json["lead_source"]==null?"":json["lead_source"].toString(),
    leadPhoneNumber: json["lead_phone_number"]==null?"":json["lead_phone_number"].toString(),
    leadEmail: json["lead_email"]==null?"":json["lead_email"].toString(),
    leadWebsite: json["lead_website"]==null?"":json["lead_website"].toString(),
    leadState: json["lead_state"]==null?"":json["lead_state"].toString(),
    leadCity: json["lead_city"]==null?"":json["lead_city"].toString(),
    leadPincode: json["lead_pincode"]==null?"":json["lead_pincode"].toString(),
    leadAddress: json["lead_address"]==null?"":json["lead_address"].toString(),
    leadProduct: json["lead_product"]==null?"":json["lead_product"].toString(),
    leadDetails: json["lead_details"]==null?"":json["lead_details"].toString(),
    leadQuantity: json["lead_quantity"]==null?"":json["lead_quantity"].toString(),
    leadBudget: json["lead_budget"]==null?"":json["lead_budget"].toString(),
    leadInquiryMedium: json["lead_inquiry_medium"]==null?"":json["lead_inquiry_medium"].toString(),
    leadInquirySource: json["lead_inquiry_source"]==null?"":json["lead_inquiry_source"].toString(),
    leadDescription: json["lead_description"]==null?"":json["lead_description"].toString(),
    leadKeywords: json["lead_keywords"]==null?"":json["lead_keywords"].toString(),
    leadRequirements: json["lead_requirements"]==null?"":json["lead_requirements"].toString(),
    leadCompInformation: json["lead_comp_information"]==null?"":json["lead_comp_information"].toString(),
    leadNextSteps: json["lead_next_steps"]==null?"":json["lead_next_steps"].toString(),
    leadNotes: json["lead_notes"]==null?"":json["lead_notes"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "lead_id": leadId,
    "lead_full_name": leadFullName,
    "lead_contact_name": leadContactName,
    "lead_contact_title": leadContactTitle,
    "lead_company_name": leadCompanyName,
    "lead_company_size": leadCompanySize,
    "lead_industry": leadIndustry,
    "lead_source": leadSource,
    "lead_phone_number": leadPhoneNumber,
    "lead_email": leadEmail,
    "lead_website": leadWebsite,
    "lead_state": leadState,
    "lead_city": leadCity,
    "lead_pincode": leadPincode,
    "lead_address": leadAddress,
    "lead_product": leadProduct,
    "lead_details": leadDetails,
    "lead_quantity": leadQuantity,
    "lead_budget": leadBudget,
    "lead_inquiry_medium": leadInquiryMedium,
    "lead_inquiry_source": leadInquirySource,
    "lead_description": leadDescription,
    "lead_keywords": leadKeywords,
    "lead_requirements": leadRequirements,
    "lead_comp_information": leadCompInformation,
    "lead_next_steps": leadNextSteps,
    "lead_notes": leadNotes,
  };
}
