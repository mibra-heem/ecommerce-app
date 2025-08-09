import 'package:ecommerce_app/core/config/route.dart';
import 'package:ecommerce_app/src/cart/presentation/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({required this.shell, super.key});

  final StatefulNavigationShell shell;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<_NavItem> _navItems = [
    _NavItem(
      label: 'Home',
      activeIcon: IconlyBold.home,
      inactiveIcon: IconlyLight.home,
    ),
    _NavItem(
      label: 'Cart',
      activeIcon: IconlyBold.buy,
      inactiveIcon: IconlyLight.buy,
    ),
    _NavItem(
      label: 'Messages',
      activeIcon: IconlyBold.message,
      inactiveIcon: IconlyLight.message,
    ),
    _NavItem(
      label: 'Profile',
      activeIcon: IconlyBold.profile,
      inactiveIcon: IconlyLight.profile,
    ),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('............ Dashboard .............');
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        const tabBasePaths = [
          RoutePath.home,
          RoutePath.cartView,
          RoutePath.message,
          RoutePath.profile
        ];
        if (didPop) return;

        final currentLocation = GoRouterState.of(context).uri.toString();
        final isNestedRoute = tabBasePaths.any(
          (basePath) =>
              currentLocation.startsWith(basePath) &&
              currentLocation != basePath,
        );

        if (isNestedRoute) {
          context.pop();
        } else if (widget.shell.currentIndex != 0) {
          widget.shell.goBranch(0);
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: widget.shell,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.shell.currentIndex,
          onTap: widget.shell.goBranch,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: List.generate(_navItems.length, (index) {
            final item = _navItems[index];
            final isSelected = index == widget.shell.currentIndex;

            // Add badge only on Cart tab
            if (index == 1) {
              return BottomNavigationBarItem(
                label: item.label,
                icon: Consumer<CartProvider>(
                  builder: (_, cart, __) {
                    return Badge(
                      label: Text('${cart.totalItems}'),
                      isLabelVisible: cart.totalItems > 0,
                      offset: const Offset(10, -5),
                      child: Icon(
                        isSelected ? item.activeIcon : item.inactiveIcon,
                      ),
                    );
                  },
                ),
              );
            }

            return BottomNavigationBarItem(
              label: item.label,
              icon: Icon(isSelected ? item.activeIcon : item.inactiveIcon),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem {
  _NavItem({
    required this.label,
    required this.activeIcon,
    required this.inactiveIcon,
  });

  final String label;
  final IconData activeIcon;
  final IconData inactiveIcon;
}
