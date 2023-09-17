import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FitnessCard extends StatefulWidget {
  final Color cardColor;
  final String cardTitle;
  final IconData? cardIcon;
  final String? cardDescription;
  final String cardData;
  final String? cardData2;
  final String? cardSecondaryData;
  final String? cardSecondaryData2;
  final Widget? page;
  final double? progress;
  final DateTime dateTime;
  const FitnessCard(
      {super.key,
      required this.cardColor,
      required this.cardTitle,
      this.cardIcon,
      this.cardDescription,
      required this.cardData,
      this.page,
      this.progress,
      required this.dateTime,
      this.cardSecondaryData,
      this.cardData2,
      this.cardSecondaryData2});

  @override
  State<FitnessCard> createState() => _FitnessCardState();
}

class _FitnessCardState extends State<FitnessCard> {
  String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 10) {
      return 'Just now';
    } else if (difference.inSeconds < 60) {
      return '${difference.inSeconds} sec ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      final formatter = DateFormat('MMM dd, yyyy');
      return formatter.format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.page != null) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => widget.page!)));
        }
      },
      child: Card(
        margin: EdgeInsets.all(10),
        color: widget.cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          // height: 120,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    Text(
                      widget.cardTitle.toUpperCase(),
                      style: GoogleFonts.openSans(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                    Spacer(),
                    Text(
                      formatDateTime(widget.dateTime),
                      style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: Colors.white60,
                          fontWeight: FontWeight.w600),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 12,
                    ),
                  ],
                ),
              ),
              widget.progress != null
                  ? Container(
                      padding: EdgeInsets.only(left: 15, top: 15),
                      width: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: widget.progress,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                          backgroundColor: Colors.white.withOpacity(0.2),
                        ),
                      ),
                    )
                  : const SizedBox(),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.openSans(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                              children: <TextSpan>[
                                TextSpan(
                                  text: widget.cardData,
                                  style: GoogleFonts.openSans(
                                      fontSize: 34,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                widget.cardSecondaryData != null
                                    ? TextSpan(
                                        text: ' ${widget.cardSecondaryData}',
                                      )
                                    : const TextSpan(),
                                widget.cardData2 != null
                                    ? TextSpan(
                                        text: widget.cardData2,
                                        style: GoogleFonts.openSans(
                                            fontSize: 34,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      )
                                    : const TextSpan(),
                                widget.cardSecondaryData2 != null
                                    ? TextSpan(
                                        text: ' ${widget.cardSecondaryData2}',
                                      )
                                    : const TextSpan(),
                              ],
                            ),
                          )),
                      widget.cardDescription != null
                          ? Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Text(
                                widget.cardDescription!,
                                style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Icon(
                      widget.cardIcon,
                      color: Colors.white,
                      size: 40,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
