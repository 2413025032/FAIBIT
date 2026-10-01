import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class EmptySlot extends StatelessWidget {
  const EmptySlot({super.key, this.width = double.infinity, this.height = 100});
  final double width, height;
  @override
  Widget build(BuildContext context) => SizedBox(width: width, height: height);
}

class OutlineCard extends StatelessWidget {
  const OutlineCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.onTap,
  });
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(AppTheme.radius),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radius),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.line),
          borderRadius: BorderRadius.circular(AppTheme.radius),
        ),
        child: child,
      ),
    ),
  );
}

class PageTitle extends StatelessWidget implements PreferredSizeWidget {
  const PageTitle({super.key, required this.title});
  final String title;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) => AppBar(
    centerTitle: true,
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new, size: 19),
      onPressed: () => Navigator.maybePop(context),
    ),
  );
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({super.key, required this.value});
  final double value;
  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(9),
    child: LinearProgressIndicator(
      value: value,
      minHeight: 10,
      color: AppTheme.ink,
      backgroundColor: const Color(0xFFE5E5E5),
    ),
  );
}
