class Coupon {
  final String id;
  final String code;
  final double discount;
  final DateTime expiryDate;

  Coupon(
      {required this.id,
      required this.code,
      required this.discount,
      required this.expiryDate});
}
