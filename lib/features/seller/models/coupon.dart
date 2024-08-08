class Coupon {
  final String code;
  final double discount;
  final DateTime expiryDate;
  final String email;

  Coupon({
    required this.code,
    required this.discount,
    required this.expiryDate,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'discount': discount,
      'expiryDate': expiryDate.toIso8601String(),
      'email': email,
    };
  }

  static Coupon fromMap(Map<String, dynamic> map) {
    return Coupon(
      code: map['code'],
      discount: map['discount'],
      expiryDate: DateTime.parse(map['expiryDate']),
      email: map['email'],
    );
  }
}
