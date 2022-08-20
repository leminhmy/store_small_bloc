class SignUpBody{
  String name;
  String phone;
  String email;
  String password;
  String? image;
  String tokenMessages;

  SignUpBody({
    required this.name,
    required this.phone,
    required this.email,
    this.image,
    required this.password,
    required this.tokenMessages,
});

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["phone"] = this.phone;
    data["email"] = this.email;
    data["image"] = this.image;
    data["password"] = this.password;
    data["token_messages"] = this.tokenMessages;
    return data;
  }
}