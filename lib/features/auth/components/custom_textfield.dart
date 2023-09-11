import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends ConsumerStatefulWidget {
  final String title;
  final TextEditingController controller;
  final Color color;
  final StateProvider<String> stateProvider;

  const CustomTextField(
      {super.key,
      required this.title,
      required this.controller,
      required this.color,
      required this.stateProvider});
  @override
  ConsumerState<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends ConsumerState<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
            widget.title.toUpperCase(),
            style: GoogleFonts.openSans(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 47,
          width: MediaQuery.of(context).size.width * 0.85,
          child: TextField(
            onChanged: (value) {
              ref.read(widget.stateProvider.notifier).state = value;
            },
            controller: widget.controller,
            cursorHeight: 18,
            cursorColor: widget.color,
            style: GoogleFonts.openSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              hintStyle: GoogleFonts.openSans(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
              hintText: 'Enter ${widget.title}',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
