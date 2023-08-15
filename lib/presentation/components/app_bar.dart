import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:notepad/common/constants.dart';
import 'package:notepad/common/extension/map_index.dart';
import 'package:notepad/presentation/components/components.dart';
import 'package:notepad/presentation/theme/colors.dart';
import 'package:notepad/presentation/theme/spacing.dart';
import 'package:notepad/presentation/theme/typography.dart';

class NoteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NoteAppBar({
    Key? key,
    this.autoImplementLeading = true,
    this.title,
    this.actions,
    this.systemUiOverlayStyle = SystemUiOverlayStyle.light,
  }) : super(key: key);

  final bool autoImplementLeading;
  final String? title;
  final List<Widget>? actions;
  final SystemUiOverlayStyle systemUiOverlayStyle;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyle,
      child: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: AppColors.title),
          brightness: Brightness.light,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSpacings.xl),
          padding: const EdgeInsets.symmetric(vertical: AppSpacings.xl),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (autoImplementLeading)
                  AppButton(
                    child: const Icon(FeatherIcons.chevronLeft),
                    onPressed: () => context.router.pop(),
                  ),
                (title != null)
                    ? Expanded(
                        child: Text(
                          title!,
                          style: AppTypography.headline1
                              .copyWith(color: AppColors.title),
                        ),
                      )
                    : const Spacer(),
                if (actions != null) ...{
                  ...actions!
                      .mapIndexed(
                        (action, i) => Padding(
                          padding: (i == actions!.length - 1)
                              ? EdgeInsets.zero
                              : const EdgeInsets.only(right: AppSpacings.l),
                          child: action,
                        ),
                      )
                      .toList(),
                },
              ],
            ),
          ),
        )
            .animate()
            .fadeIn(duration: animationDuration)
            .slideY(duration: animationDuration),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
