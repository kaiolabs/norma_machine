// ignore_for_file: public_member_api_docs, sort_constructors_first

class Register {
  String name;
  int value;

  Register({
    this.name = '',
    this.value = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
    };
  }

  factory Register.fromMap(Map<String, dynamic> map) {
    return Register(
      name: map['name'] ?? '',
      value: map['value'] ?? 0,
    );
  }
}
