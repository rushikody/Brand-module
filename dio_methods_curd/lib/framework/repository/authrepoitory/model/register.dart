class Register {
  String? username;
  String? email;
  String? password;
  String? confirmPassword;
  String? firstName;
  String? lastName;
  String? phone;
  String? dateOfBirth;

  Register(
      {this.username,
        this.email,
        this.password,
        this.confirmPassword,
        this.firstName,
        this.lastName,
        this.phone,
        this.dateOfBirth});

  Register.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    dateOfBirth = json['date_of_birth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['confirm_password'] = this.confirmPassword;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone ?? "No Phone Number";
    data['date_of_birth'] = this.dateOfBirth;
    return data;
  }
}
