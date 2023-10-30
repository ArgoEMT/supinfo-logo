import 'package:flutter/material.dart';

import '../../config/app_router.dart';
import '../../config/theme/app_colors.dart';

enum ReturnType {
  close,
  back,
}

class TemplateAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TemplateAppbar({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.textColor,
    this.returnType,
    this.onPop,
    this.actions,
  }) : super(key: key);

  final void Function()? onPop;

  final Color? backgroundColor;
  final Color? textColor;
  final ReturnType? returnType;
  final Widget child;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(100);

  static double get height => 30;

  @override
  Widget build(BuildContext context) {
    final color = backgroundColor ?? appWhite;

    return SizedBox(
      height: 30,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: AppBar(
          backgroundColor: color,
          elevation: 0,
          automaticallyImplyLeading: returnType != null,
          leadingWidth: 48,
          leading: returnType != null
              ? InkWell(
                  onTap: () => onPop != null ? onPop!() : context.pop(),
                  child: Icon(
                    returnType == ReturnType.close
                        ? Icons.close
                        : Icons.arrow_back_ios_new,
                    color: textColor ?? appPurple,
                    size: 18,
                  ),
                )
              : null,
          title: child,
          centerTitle: false,
          actions: actions,
        ),
      ),
    );
  }
}
