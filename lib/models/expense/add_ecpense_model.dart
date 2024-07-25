import 'dart:convert';
AddExpenseModel addExpenseModelFromJson(String str) => AddExpenseModel.fromJson(json.decode(str));
String addExpenseModelToJson(AddExpenseModel data) => json.encode(data.toJson());
class AddExpenseModel {
  String? expenseProduct;
  String? expenseStationType;
  String? expenseStationLocation;
  String? expenseReportingPlace;
  String? expenseClaimPrice;
  String? expenseClaimQuantity;
  String? expenseTotalPrice;
  String? expenseDate;
  String? expenseBillReference;
  String? expenseDescription;
  List<dynamic>? expenseAttachDocuments;
  AddExpenseModel({
    this.expenseProduct,
    this.expenseStationType,
    this.expenseStationLocation,
    this.expenseReportingPlace,
    this.expenseClaimPrice,
    this.expenseClaimQuantity,
    this.expenseTotalPrice,
    this.expenseDate,
    this.expenseBillReference,
    this.expenseDescription,
    this.expenseAttachDocuments,
  });

  factory AddExpenseModel.fromJson(Map<String, dynamic> json) => AddExpenseModel(
    expenseProduct: json["expense_product"]==null?"":json["expense_product"].toString(),
    expenseStationType: json["expense_station_type"]==null?"":json["expense_station_type"].toString(),
    expenseStationLocation: json["expense_station_location"]==null?"":json["expense_station_location"].toString(),
    expenseReportingPlace: json["expense_reporting_place"]==null?"":json["expense_reporting_place"].toString(),
    expenseClaimPrice: json["expense_claim_price"]==null?"":json["expense_claim_price"].toString(),
    expenseClaimQuantity: json["expense_claim_quantity"]==null?"":json["expense_claim_quantity"].toString(),
    expenseTotalPrice: json["expense_total_price"]==null?"":json["expense_total_price"].toString(),
    expenseDate: json["expense_date"]==null?"":json["expense_date"].toString(),
    expenseBillReference: json["expense_bill_reference"]==null?"":json["expense_bill_reference"].toString(),
    expenseDescription: json["expense_description"]==null?"":json["expense_description"].toString(),
    expenseAttachDocuments:json["expense_attach_documents"]==null?[]: List<dynamic>.from(json["expense_attach_documents"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "expense_product": expenseProduct,
    "expense_station_type": expenseStationType,
    "expense_station_location": expenseStationLocation,
    "expense_reporting_place": expenseReportingPlace,
    "expense_claim_price": expenseClaimPrice,
    "expense_claim_quantity": expenseClaimQuantity,
    "expense_total_price": expenseTotalPrice,
    "expense_date": expenseDate,
    "expense_bill_reference": expenseBillReference,
    "expense_description": expenseDescription,
    "expense_attach_documents": List<dynamic>.from(expenseAttachDocuments!.map((x) => x)),
  };
}
