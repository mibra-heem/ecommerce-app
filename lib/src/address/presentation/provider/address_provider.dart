import 'package:ecommerce_app/src/address/domain/entities/address.dart';
import 'package:flutter/foundation.dart';

class AddressProvider extends ChangeNotifier {
  final List<Address> _addresses = [];

  List<Address> get addresses => List.unmodifiable(_addresses);

  bool get hasAddress => _addresses.isNotEmpty;

  /// Get default address or first address if no default
  Address? get defaultAddress {
    try {
      return _addresses.firstWhere((a) => a.isDefault);
    } catch (e) {
      return _addresses.isNotEmpty ? _addresses.first : null;
    }
  }

  /// Add a new address
  void addAddress(Address address) {
    if (address.isDefault) {
      _unsetDefault();
    }
    _addresses.add(address);
    notifyListeners();
    debugPrint('Addresss Added => $_addresses');
  }

  /// Update existing address
  void updateAddress(Address updated) {
    final index = _addresses.indexWhere((a) => a.id == updated.id);
    if (index != -1) {
      if (updated.isDefault) {
        _unsetDefault();
      }
      _addresses[index] = updated;
      notifyListeners();
    }
  }

  /// Remove an address
  void removeAddress(String id) {
    _addresses.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  /// Set a specific address as default
  void setDefault(String id) {
    for (var a in _addresses) {
      a.isDefault = a.id == id;
    }
    notifyListeners();
  }

  void _unsetDefault() {
    for (var a in _addresses) {
      a.isDefault = false;
    }
  }
}
