class ProductModel {
  String pID;
  String pName;
  String pNameEn;
  String pDescription;
  String pStock;
  String pMinimum;
  String pPrice;
  String pUnit;
  String pCategory;
  String pSupplier;
  String pCost;
  String pSupplier2;
  String pCost2;
  String pAlert;
  String pWillArrive;
  String pAmountArrive;
  String pIsImport;

  ProductModel(
      {this.pID,
      this.pName,
      this.pNameEn,
      this.pDescription,
      this.pStock,
      this.pMinimum,
      this.pPrice,
      this.pUnit,
      this.pCategory,
      this.pSupplier,
      this.pCost,
      this.pSupplier2,
      this.pCost2,
      this.pAlert,
      this.pWillArrive,
      this.pAmountArrive,
      this.pIsImport});

  ProductModel.fromJson(Map<String, dynamic> json) {
    pID = json['p_ID'];
    pName = json['p_name'];
    pNameEn = json['p_name_en'];
    pDescription = json['p_description'];
    pStock = json['p_stock'];
    pMinimum = json['p_minimum'];
    pPrice = json['p_price'];
    pUnit = json['p_unit'];
    pCategory = json['p_category'];
    pSupplier = json['p_supplier'];
    pCost = json['p_cost'];
    pSupplier2 = json['p_supplier2'];
    pCost2 = json['p_cost2'];
    pAlert = json['p_alert'];
    pWillArrive = json['p_willArrive'];
    pAmountArrive = json['p_amountArrive'];
    pIsImport = json['p_isImport'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['p_ID'] = this.pID;
    data['p_name'] = this.pName;
    data['p_name_en'] = this.pNameEn;
    data['p_description'] = this.pDescription;
    data['p_stock'] = this.pStock;
    data['p_minimum'] = this.pMinimum;
    data['p_price'] = this.pPrice;
    data['p_unit'] = this.pUnit;
    data['p_category'] = this.pCategory;
    data['p_supplier'] = this.pSupplier;
    data['p_cost'] = this.pCost;
    data['p_supplier2'] = this.pSupplier2;
    data['p_cost2'] = this.pCost2;
    data['p_alert'] = this.pAlert;
    data['p_willArrive'] = this.pWillArrive;
    data['p_amountArrive'] = this.pAmountArrive;
    data['p_isImport'] = this.pIsImport;
    return data;
  }
}

