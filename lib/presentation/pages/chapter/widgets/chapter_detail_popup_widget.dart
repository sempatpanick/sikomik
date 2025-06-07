import 'package:flutter/material.dart';

class ChapterDetailPopupWidget extends StatelessWidget {
  final String item;
  const ChapterDetailPopupWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navigator = Navigator.of(context);

    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: InteractiveViewer(
              child: Image(
                image: NetworkImage(
                  item,
                  webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
                ),
                fit: BoxFit.fill,
                frameBuilder: (context, child, value, state) {
                  if (value == null) {
                    return SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Center(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    );
                  }
                  return child;
                },
                loadingBuilder: (context, child, event) => event == null
                    ? child
                    : SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: Center(
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              value: event.cumulativeBytesLoaded /
                                  (event.expectedTotalBytes ?? 1),
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                errorBuilder: (context, url, error) => const SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: navigator.pop,
              icon: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.close,
                  color: theme.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
