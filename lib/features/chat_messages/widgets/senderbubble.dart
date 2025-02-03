import 'package:flutter/material.dart';

import '../../app/consts/colors.dart';


Widget messageBubble({
  required BuildContext context,
  required String message,
  required String time,
  required bool isSender,
  required bool isSeen,  // New parameter
}) {
  return Directionality(
    textDirection: isSender ? TextDirection.rtl : TextDirection.ltr,
    child: IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: isSender
            ? EdgeInsets.only(
            left: MediaQuery.sizeOf(context).width * 0.15,
            right: 5,
            bottom: 10)
            : EdgeInsets.only(
            right: MediaQuery.sizeOf(context).width * 0.15,
            left: 5,
            bottom: 10),
        decoration: BoxDecoration(
          boxShadow: [const BoxShadow(blurRadius: 10)],
          color: isSender ? redColor : darkFontGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: const TextStyle(fontSize: 16, color: whiteColor),
            ),
            const SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: TextStyle(color: whiteColor.withOpacity(0.5)),
                ),
                const SizedBox(width: 5,),
                if (isSender)
                  Icon(
                    isSeen ? Icons.done_all : Icons.done_all, // Seen indicator
                    color: isSeen ? Colors.blue :whiteColor.withOpacity(0.5),
                    size: 16,
                  ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
