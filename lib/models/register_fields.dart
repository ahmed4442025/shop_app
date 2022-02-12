class RegisterFields {
  String? name;
  String? email;
  String? pass;
  String? phone;
  String? image;

  RegisterFields(this.name, this.email, this.pass, this.phone, this.image);

  Map<String, dynamic> toData() {
    Map<String, dynamic> data = {};
    if (name != null) {
      data['name'] = name;
    }
    if (email != null) {
      data['email'] = email;
    }
    if (phone != null) {
      data['phone'] = phone;
    }
    if (pass != null) {
      data['password'] = pass;
    }
    if (image != null) {
      data['image'] = image;
    }
    return data;
  }
}
