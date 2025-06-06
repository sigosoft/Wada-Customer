
import 'package:flutter/material.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

import '../../Resource/Colors.dart';

class CheckBoxWithTextWidget extends StatelessWidget {
  const CheckBoxWithTextWidget({
    super.key,
    required this.isChecked,
    this.onChanged,
    this.onTap,
  });

  final bool isChecked;
  final ValueChanged<bool?>? onChanged;
  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: onChanged,
              checkColor: premiumMembershipColor,
              fillColor: WidgetStateProperty.resolveWith<Color>((
                  Set<WidgetState> states,
                  ) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.white;
                }
                return Colors.transparent;
              }),
              side: WidgetStateBorderSide.resolveWith((Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return const BorderSide(color: Colors.transparent, width: 2);
                }
                return const BorderSide(color: Colors.white, width: 2);
              }),
            ),
            TextStyleInterWithoutPadding(
              text: Strings.autoSubscription,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              size: MediaQuery.of(context).size.width * 0.040,
            ),
          ],
        ),
      ),
    );
  }
}