class CountryCode {
  final int id;
  final String name;
  final String code;

  const CountryCode({required this.id, required this.name, required this.code});

  factory CountryCode.fromJson(Map<String, dynamic> json) {
    return CountryCode(
      id: json['id'] as int,
      name: json['cname'] as String,
      code: "+${json['country_id']}",
    );
  }
}

const List<CountryCode> defaultCountryCodes = [
  CountryCode(id: 86, name: '中国大陆', code: '+86'),
  CountryCode(id: 1, name: '美国', code: '+1'),
  CountryCode(id: 81, name: '日本', code: '+81'),
  CountryCode(id: 886, name: '中国台湾', code: '+886'),
  CountryCode(id: 852, name: '中国香港', code: '+852'),
  CountryCode(id: 853, name: '中国澳门', code: '+853'),
];
