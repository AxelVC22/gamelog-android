import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class AppExpandableHtmlText extends StatefulWidget {
  final String html;
  final double collapsedHeight;

  const AppExpandableHtmlText({
    super.key,
    required this.html,
    this.collapsedHeight = 112,
  });

  @override
  State<AppExpandableHtmlText> createState() => _ExpandableHtmlState();
}

class _ExpandableHtmlState extends State<AppExpandableHtmlText>
    with TickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRect(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: ConstrainedBox(
              constraints: _expanded
                  ? const BoxConstraints()
                  : BoxConstraints(
                maxHeight: widget.collapsedHeight,
              ),
              child: Html(
                data: widget.html,
                style: {
                  "body": Style(
                    fontSize: FontSize(14),
                    fontWeight: FontWeight.w600,
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                  ),
                },
              ),
            ),
          ),
        ),

        const SizedBox(height: 6),

        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Text(
            _expanded ? "Ver menos" : "Ver más",
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
