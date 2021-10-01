class detailsS {
  final Map<String, List> datam = new Map<String, List>();
  String? id;
  String? brandId;
  String? brandName;
  String? start;
  String? end;
  String? category;
  String? userDiscount;
  String? qrCodeImage;
  String? result;

  detailsS(
      {this.id,
        this.brandId,
        this.brandName,
        this.start,
        this.end,
        this.category,
        this.userDiscount,
        this.qrCodeImage,
        this.result});

  detailsS.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    start = json['start'];
    end = json['end'];
    category = json['category'];
    userDiscount = json['user_discount'];
    qrCodeImage = json['qr_code_image'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> datam = new Map<String, dynamic>();
    datam['id'] = this.id;
    datam['brand_id'] = this.brandId;
    datam['brand_name'] = this.brandName;
    datam['start'] = this.start;
    datam['end'] = this.end;
    datam['category'] = this.category;
    datam['user_discount'] = this.userDiscount;
    datam['qr_code_image'] = this.qrCodeImage;
    datam['result'] = this.result;
    return datam;
  }
}