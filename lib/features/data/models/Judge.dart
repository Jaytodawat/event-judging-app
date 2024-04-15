class Judge{
  late int id;
  late String name;
  late String email;
  late String password;
  late int eventId;

  Judge(this.name, this.email, this.eventId);


  Judge.name(this.id, this.name, this.email, this.password);


  Judge.login(this.email, this.password);

  Map<String, dynamic> toLoginJson(){
    return {
      'email':email.trim(),
      'password':password.trim()
    };
  }


  Map<String, dynamic> toJson(){
    return {
      'email':email,
      'name':name,
      'event_id':eventId
    };
  }

  factory Judge.fromJson(Map<String, dynamic> json){
    return Judge.name(json["pk_judgeid"], json["name"], json["email"], json["password"]);
  }
}

