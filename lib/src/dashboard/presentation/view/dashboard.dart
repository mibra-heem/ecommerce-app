import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({required this.shell, super.key});

  final StatefulNavigationShell shell;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
        const tabBasePaths = ['/home', '/cart'];

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
        body: widget.shell,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.shell.currentIndex,
          onTap: widget.shell.goBranch,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                widget.shell.currentIndex == 0
                    ? IconlyBold.home
                    : IconlyLight.home,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Cart',
              icon: Icon(
                widget.shell.currentIndex == 1
                    ? IconlyBold.bag_2
                    : IconlyLight.bag_2,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(
                widget.shell.currentIndex == 1
                    ? IconlyBold.profile
                    : IconlyLight.profile,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
