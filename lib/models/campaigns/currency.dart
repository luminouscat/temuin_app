class Currency {
  const Currency({
    required this.id,
    required this.name,
    required this.code,
    required this.symbol,
    required this.symbolPosition,
    required this.decimalPlaces,
    required this.decimalSeparator,
    required this.thousandsSeparator,
    required this.exchangeToUsd,
    this.isActive = true,
    this.isDefault = 0,
    this.createdAt,
    this.updateAt,
  });

  final int id;
  final String name;
  final String code;
  final String symbol;
  final String symbolPosition;
  final int decimalPlaces;
  final String decimalSeparator;
  final String thousandsSeparator;
  final String exchangeToUsd;
  final bool isActive;
  final int isDefault;
  final DateTime? createdAt;
  final DateTime? updateAt;

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      symbol: json['symbol'],
      symbolPosition: json['symbol_position'],
      decimalPlaces: json['decimal_places'],
      decimalSeparator: json['decimal_separator'],
      thousandsSeparator: json['thousands_separator'],
      exchangeToUsd: json['exchange_rate_to_usd'],
      isActive: json['is_active'] ?? true,
      isDefault: json['is_default'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updateAt: json['updated_at'] != null
          ? DateTime.parse(json['update_at'])
          : null,
    );
  }

  String formatAmount(double amount) {
    final formattedAmount = amount.toStringAsFixed(decimalPlaces);
    final parts = formattedAmount.split('.');
    final integerPart = parts[0].replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => thousandsSeparator,
    );
    final decimalPart = parts.length > 1 ? decimalSeparator + parts[1] : '';

    if (symbolPosition == 'before') {
      return '$symbol$integerPart$decimalPart';
    } else {
      return '$integerPart$decimalPart$symbol';
    }
  }
}

// hardcoded currencies
final hardcodedCurrencies = [
  const Currency(
    id: 1,
    name: "Indonesian Rupiah",
    code: "IDR",
    symbol: "Rp",
    symbolPosition: "before",
    decimalPlaces: 0,
    decimalSeparator: ",",
    thousandsSeparator: ".",
    exchangeToUsd: "15000.000000",
  ),
  const Currency(
    id: 2,
    name: "Malaysian Ringgit",
    code: "MYR",
    symbol: "RM",
    symbolPosition: "before",
    decimalPlaces: 0,
    decimalSeparator: ",",
    thousandsSeparator: ".",
    exchangeToUsd: "4,22.000000",
  ),
  const Currency(
    id: 3,
    name: "Singaporean Dollar",
    code: "SGD",
    symbol: "S\$",
    symbolPosition: "before",
    decimalPlaces: 0,
    decimalSeparator: ",",
    thousandsSeparator: ".",
    exchangeToUsd: "1,30.000000",
  ),
];
