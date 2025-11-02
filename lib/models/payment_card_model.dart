class PaymentCardModel {
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;
  final String id;
  final bool isChosen;

  PaymentCardModel({
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
    required this.id,
    this.isChosen = false,
  });

  PaymentCardModel copyWith({
    String? cardNumber,
    String? cardHolderName,
    String? expiryDate,
    String? cvv,
    String? id,
    bool? isChosen,
  }) {
    return PaymentCardModel(
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      id: id ?? this.id,
      isChosen: isChosen ?? this.isChosen,
    );
  }
}

List<PaymentCardModel> dummyPaymentCards = [
  PaymentCardModel(
    id: '1',
    cardNumber: '5060 2256 2222 1234',
    cardHolderName: 'Khaled Alqedra',
    expiryDate: '12/24',
    cvv: '123',
  ),
  PaymentCardModel(
    id: '2',
    cardNumber: '**** **** **** 5678',
    cardHolderName: 'Jane Smith',
    expiryDate: '11/23',
    cvv: '456',
  ),
  PaymentCardModel(
    id: '3',
    cardNumber: '**** **** **** 9012',
    cardHolderName: 'John Doe',
    expiryDate: '10/25',
    cvv: '789',
  ),
];
