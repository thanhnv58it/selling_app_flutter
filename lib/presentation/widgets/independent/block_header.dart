import 'package:flutter/material.dart';
import 'package:selling_app/config/theme.dart';

class OpenFlutterBlockHeader extends StatelessWidget {
  final double width;
  final String title;
  final String? linkText;
  final VoidCallback? onLinkTap;
  final String? description;

  const OpenFlutterBlockHeader(
      {super.key,
      required this.width,
      required this.title,
      this.linkText,
      this.onLinkTap,
      this.description});

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    const rightLinkWidth = 100.0;
    return InkWell(
      onTap: onLinkTap,
      child: Container(
        padding: const EdgeInsets.only(
            top: AppSizes.sidePadding, left: AppSizes.sidePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: width - rightLinkWidth,
                  child: Text(title, style: _theme.textTheme.headlineLarge),
                ),
                linkText != null
                    ? SizedBox(
                        width: rightLinkWidth,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(linkText!,
                              style: _theme.textTheme.bodyMedium),
                        ),
                      )
                    : Container(),
              ],
            ),
            description != null
                ? Text(
                    description!,
                    style: _theme.textTheme.bodyMedium,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
