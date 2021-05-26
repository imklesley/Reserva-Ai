class ContactModel {
  late bool isWhatsapp;
  late String number;

  ContactModel({required this.isWhatsapp, required this.number});

  ContactModel.fromJson(Map<String, dynamic> json) {
    isWhatsapp = json['is_whatsapp'] as bool;
    number = json['number'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_whatsapp'] = isWhatsapp;
    data['number'] = number;
    return data;
  }
}