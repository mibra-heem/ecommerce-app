
import 'package:ecommerce_app/src/address/domain/entities/address.dart';

class AddressModel extends Address {

  AddressModel({
    required super.id,
    required super.name,
    required super.recipientName,
    required super.phone,
    required super.street,
    required super.city,
    required super.state,
    required super.postalCode,
    required super.country,
    super.isDefault = false,
  });
  /// Create Address from Map
  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as String,
      name: map['name'] as String,
      recipientName: map['recipientName'] as String,
      phone: map['phone'] as String,
      street: map['street'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      postalCode: map['postalCode'] as String,
      country: map['country'] as String,
      isDefault: map['isDefault'] as bool,
    );
  }

  /// Convenience method for displaying a full AddressModel
  String get fullAddressModel => '$street, $city, $state, $postalCode, $country';

  /// Clone an AddressModel with new values (useful for updates)
  AddressModel copyWith({
    String? id,
    String? name,
    String? recipientName,
    String? phone,
    String? street,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      name: name ?? this.name,
      recipientName: recipientName ?? this.recipientName,
      phone: phone ?? this.phone,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  /// Convert AddressModel to Map (useful for persistence)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'recipientName': recipientName,
      'phone': phone,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'isDefault': isDefault,
    };
  }
}
