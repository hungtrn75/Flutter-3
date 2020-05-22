class FirebaseResponse {
  final String name;

  FirebaseResponse(this.name);

  FirebaseResponse.fromJson(Map<String, dynamic> json) : name = json["name"];
}
