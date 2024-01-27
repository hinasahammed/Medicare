import 'package:get/get.dart';
import 'package:medicare_admin/res/components/custom_navigation_bar.dart';
import 'package:medicare_admin/res/components/responsive_layout.dart';
import 'package:medicare_admin/res/routes/routes_name.dart';
import 'package:medicare_admin/view/desktop_layout/admin_home/admin_home.dart';
import 'package:medicare_admin/view/desktop_layout/desktop_layout.dart';
import 'package:medicare_admin/view/mobile_layout/mobile_layout.dart';

class Routes {
  static appRoutes() => [
        GetPage(
          name: RoutesName.responsiveLayout,
          page: () => const ResponsiveLayout(),
        ),
        GetPage(
          name: RoutesName.desktopLayout,
          page: () => const DesktopLayout(),
        ),
        GetPage(
          name: RoutesName.mobileLayout,
          page: () => const MobileLayout(),
        ),
        GetPage(
          name: RoutesName.navigationBar,
          page: () => const CustomNavigationBar(),
        ),
        GetPage(
          name: RoutesName.adminHome,
          page: () => const AdminHome(),
        ),
      ];
}