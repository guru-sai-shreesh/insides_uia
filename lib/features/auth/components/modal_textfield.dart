import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ModalTextField extends ConsumerStatefulWidget {
  final String title;
  final List<String> options;
  final TextEditingController controller;
  final Color color;
  final StateProvider<String> stateProvider;

  const ModalTextField(
      {super.key,
      required this.title,
      required this.options,
      required this.controller,
      required this.color,
      required this.stateProvider});
  @override
  ConsumerState<ModalTextField> createState() => _ModalTextFieldState();
}

class _ModalTextFieldState extends ConsumerState<ModalTextField> {
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
            controller: widget.controller,
            cursorHeight: 18,
            cursorColor: widget.color,
            readOnly: true,
            style: GoogleFonts.openSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    var selectedIndex;
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                      ),
                      height: widget.options.length * 90 + 70,
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    150.0, 10.0, 150.0, 20.0),
                                child: Container(
                                  height: 8.0,
                                  width: 80.0,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "Select ${widget.title}",
                                  style: GoogleFonts.openSans(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const Divider(),
                            ],
                          ),
                          StatefulBuilder(builder:
                              (BuildContext context, StateSetter mystate) {
                            return Container(
                              padding:
                                  const EdgeInsets.only(top: 75, bottom: 50),
                              child: ListView.builder(
                                itemCount: widget.options.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text(widget.options[index]),
                                        leading: (selectedIndex == index)
                                            ? const Icon(
                                                Icons.check_circle,
                                                color: Color(0xFF0D47A1),
                                              )
                                            : const Icon(Icons.circle_outlined),
                                        onTap: () {
                                          widget.controller.text =
                                              widget.options[index];
                                          ref
                                              .read(
                                                  widget.stateProvider.notifier)
                                              .state = widget.options[index];
                                          Navigator.pop(context);
                                        },
                                      ),
                                      const Divider()
                                    ],
                                  );
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  });
            },
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
              suffixIcon: const Icon(
                Icons.arrow_drop_down_rounded,
                color: Colors.black,
              ),
              hintStyle: GoogleFonts.openSans(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
              hintText: "Select ${widget.title}",
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
