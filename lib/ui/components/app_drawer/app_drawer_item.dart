import 'package:flutter/material.dart';
import 'package:supinfo_logo/config/theme/app_colors.dart';
import 'package:supinfo_logo/ui/components/app_button.dart';

class AppDrawerItem extends StatefulWidget {
  const AppDrawerItem({
    super.key,
    required this.name,
    this.onTap,
    this.children,
    this.isActive,
    this.isExpanded,
  }) : assert((onTap != null && isActive != null) || children != null);

  final String name;
  final Function()? onTap;
  final List<Widget>? children;
  final bool? isActive;
  final bool? isExpanded;

  @override
  State<AppDrawerItem> createState() => _AppDrawerItemState();
}

class _AppDrawerItemState extends State<AppDrawerItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: appPurple, width: 2)),
      ),
      child: widget.children != null
          ? ExpansionTile(
              initiallyExpanded: widget.isExpanded ?? false,
              title: Text(widget.name),
              children: widget.children!,
            )
          : AppButton(
              isExpanded: true,
              onPressed: widget.isActive! ? () {} : widget.onTap,
              isActive: widget.isActive!,
              label: widget.name,
              isRound: false,
            ),
    );
  }
}
