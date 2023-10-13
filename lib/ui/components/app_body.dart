import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:okteo_flutter_icons/okteo_icons.dart';

import '../../config/app_router.dart';
import '../../config/flavor_config.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';
import 'app_bottom_navigation_bar.dart';
import 'template_appbar.dart';

class AppBody extends StatelessWidget {
  const AppBody({
    super.key,
    required this.body,
    this.onWillPop,
    this.appBar,
    this.showAppBar = true,
    this.showBottomBar = true,
    this.backgroundColor,
    this.appBarBackgroundColor,
    this.bottomBar,
    this.contentPadding = true,
    this.scrollController,
    this.title,
    this.titleIcon,
    this.scrollPhysics,
    this.hasSingleChildScrollView = true,
  });

  final Future<bool> Function()? onWillPop;
  final PreferredSizeWidget? appBar;
  final bool showAppBar;
  final Color? backgroundColor;
  final Color? appBarBackgroundColor;
  final Widget? bottomBar;
  final Widget body;
  final String? title;
  final IconData? titleIcon;
  final ScrollPhysics? scrollPhysics;
  final bool showBottomBar;

  final bool contentPadding;
  final ScrollController? scrollController;
  final bool hasSingleChildScrollView;

  @override
  Widget build(BuildContext context) {
    final flavorConfig = GetIt.I<FlavorConfig>();
    return WillPopScope(
      onWillPop: onWillPop ??
          () async {
            if (context.canPop) {
              context.pop();
            } else {
              await context.go(RoutePaths.home);
            }
            return Future.value(false);
          },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Banner(
          location: BannerLocation.topEnd,
          color: flavorConfig.color,
          message: flavorConfig.flavor.toString(),
          child: Scaffold(
            backgroundColor: backgroundColor ?? appWhite,
            bottomNavigationBar: showBottomBar
                ? (bottomBar ?? const AppBottomNavigationBar())
                : null,
            appBar: appBar ??
                (showAppBar
                    ? TemplateAppbar(
                        backgroundColor: appBarBackgroundColor ??
                            homeBackgroundColor.lighten(0.5),
                        child: Row(
                          children: [
                            if (titleIcon != null)
                              OkteoIcon(
                                titleIcon!,
                                color: appBlack,
                              ),
                            const SizedBox(width: 10),
                            Text(
                              title!,
                              style: bold20Black,
                            ),
                          ],
                        ),
                      )
                    : null),
            body: hasSingleChildScrollView
                ? SingleChildScrollView(
                    physics: scrollPhysics,
                    controller: scrollController,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: contentPadding ? 16 : 0,
                      ),
                      child: body,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: contentPadding ? 16 : 0,
                    ),
                    child: body,
                  ),
          ),
        ),
      ),
    );
  }
}
