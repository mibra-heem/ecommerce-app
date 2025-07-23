import 'package:equatable/equatable.dart';

class Address extends Equatable {
  Address({
    required this.id,
    required this.name,
    required this.recipientName,
    required this.phone,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.isDefault = false,
  });

  final String id;
  String name; // e.g., "Home", "Work"
  String recipientName; // Name of the person receiving the package
  String phone;
  String street;
  String city;
  String state;
  String postalCode;
  String country;
  bool isDefault;

  /// Convenience method for displaying a full address
  String get fullAddress => '$street, $city, $state, $postalCode, $country';

  @override
  List<Object> get props => [
        id,
        name,
        recipientName,
        phone,
        street,
        city,
        state,
        postalCode,
        country,
        isDefault,
      ];

  @override
  String toString() {
    return 'Address{id: $id, name: $name, recipientName : $recipientName, '
        'phone: $phone, street: $street, postalCode : $postalCode, city: $city'
        ', state: $state, country: $country, isDefault: $isDefault, Address: '
        ' $fullAddress }';
  }
}
