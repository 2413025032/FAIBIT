import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class FaiMascot extends StatelessWidget {
  const FaiMascot({
    super.key,
    required this.assetName,
    this.width = 80,
    this.height = 100,
    this.semanticLabel,
  });

  final String assetName;
  final double width;
  final double height;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    height: height,
    child: Image.asset(
      'assets/images/fai/$assetName',
      fit: BoxFit.contain,
      semanticLabel: semanticLabel,
    ),
  );
}

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
    color: Theme.of(context).colorScheme.surface,
    borderRadius: BorderRadius.circular(AppTheme.radius),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radius),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radius),
          boxShadow: const [
            BoxShadow(
              color: Color(0x120F9D78),
              blurRadius: 14,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: child,
      ),
    ),
  );
}

class PageTitle extends StatelessWidget implements PreferredSizeWidget {
  const PageTitle({
    super.key,
    required this.title,
    this.showBack = true,
    this.actions,
    this.onBack,
  });
  final String title;
  final bool showBack;
  final List<Widget>? actions;
  final VoidCallback? onBack;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) => AppBar(
    centerTitle: true,
    automaticallyImplyLeading: false,
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
    leading: showBack
        ? IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 19),
            onPressed: onBack ?? () => Navigator.maybePop(context),
          )
        : null,
    actions: actions,
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
      color: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    ),
  );
}
