import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:ecommerce_app/core/config/route.dart';
import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/src/address/presentation/provider/address_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addressProvider = context.watch<AddressProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Address'),
      ),
      body: addressProvider.addresses.isEmpty
          ? Center(
              child: Text(
                'No addresses found.\nTap + to add new.',
                textAlign: TextAlign.center,
                style: context.theme.textTheme.bodyLarge,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: addressProvider.addresses.length,
              itemBuilder: (context, index) {
                final address = addressProvider.addresses[index];
                return Card(
                  color: context.color.surfaceContainer,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            address.name,
                            style: context.theme.textTheme.titleMedium,
                          ),
                        ),
                        if (address.isDefault)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colours.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Default',
                              style: TextStyle(
                                color: Colours.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        address.fullAddress,
                        style: context.theme.textTheme.bodySmall,
                      ),
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (val) {
                        if (val == 'edit') {
                          context.pushNamed(
                            RouteName.addressEdit,
                            pathParameters: {'id': address.id},
                            extra: address,
                          );
                        } else if (val == 'delete') {
                          addressProvider.removeAddress(address.id);
                        } else if (val == 'default') {
                          addressProvider.setDefault(address.id);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                        if (!address.isDefault)
                          const PopupMenuItem(
                            value: 'default',
                            child: Text('Set as Default'),
                          ),
                      ],
                    ),
                    onTap: () {
                      addressProvider.setDefault(address.id);
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colours.primary,
        onPressed: () {
          context.pushNamed(RouteName.addressCreate);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
