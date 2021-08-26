class data {
  String? id;
  String? fullname;
  String? email;
  String? cnic;
  String? phone;
  String? contract;
  String? designation;
  String? category;
  String ?totalDiscount;
  String? dhDiscount;
  String? userDiscount;
  String? logo;
  String? headerImage1;
  String? headerImage2;
  String? headerImage3;
  String? address;
  String? result;

  data(
      {this.id,
        this.fullname,
        this.email,
        this.cnic,
        this.phone,
        this.contract,
        this.designation,
        this.category,
        this.totalDiscount,
        this.dhDiscount,
        this.userDiscount,
        this.logo,
        this.headerImage1,
        this.headerImage2,
        this.headerImage3,
        this.address,
        this.result});

  data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    cnic = json['	cnic'];
    phone = json['	phone'];
    contract = json['contract'];
    designation = json['designation'];
    category = json['category'];
    totalDiscount = json['total_discount'];
    dhDiscount = json['dh_discount'];
    userDiscount = json['user_discount'];
    logo = json['logo'];
    headerImage1 = json['header_image1'];
    headerImage2 = json['header_image2'];
    headerImage3 = json['header_image3'];
    address = json['address'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['	cnic'] = this.cnic;
    data['	phone'] = this.phone;
    data['contract'] = this.contract;
    data['designation'] = this.designation;
    data['category'] = this.category;
    data['total_discount'] = this.totalDiscount;
    data['dh_discount'] = this.dhDiscount;
    data['user_discount'] = this.userDiscount;
    data['logo'] = this.logo;
    data['header_image1'] = this.headerImage1;
    data['header_image2'] = this.headerImage2;
    data['header_image3'] = this.headerImage3;
    data['address'] = this.address;
    data['result'] = this.result;
    return data;
  }
}