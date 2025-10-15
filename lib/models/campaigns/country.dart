class Country {
  const Country({
    required this.id,
    required this.name,
    required this.code,
    required this.codeAlpha,
    required this.currencyId,
    required this.locale,
    this.isActive = true,
    required this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String name;
  final String code;
  final String codeAlpha;
  final int currencyId;
  final String locale;
  final bool isActive;
  final int sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      codeAlpha: json['code_alpha3'],
      currencyId: json['currency_id'],
      locale: json['locale'],
      isActive: json['is_active'],
      sortOrder: json['sort_order'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}

// hardcoded countries
final hardcodedCountries = [
  const Country(
    id: 1,
    name: "Indonesia",
    code: "ID",
    codeAlpha: "IDN",
    currencyId: 1,
    locale: "id_ID",
    sortOrder: 1,
  ),
  const Country(
    id: 2,
    name: "Malaysia",
    code: "MY",
    codeAlpha: "MYS",
    currencyId: 2,
    locale: "ms_MY",
    sortOrder: 2,
  ),
  const Country(
    id: 3,
    name: "Singapore",
    code: "SG",
    codeAlpha: "SG",
    currencyId: 3,
    locale: "en_SG",
    sortOrder: 3,
  ),
];
