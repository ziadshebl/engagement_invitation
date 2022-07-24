import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class InvitationView extends StatefulWidget {
  final String id;

  const InvitationView({super.key, required this.id});
  @override
  _InvitationViewState createState() => _InvitationViewState();
}

class _InvitationViewState extends State<InvitationView> {
  Map<String, dynamic>? guests;
  Future<void> _launchUrl() async {
    if (!await launchUrl(
        Uri.parse("https://g.page/villa-Dream-for-Events?share"))) {
      throw 'Could not launch';
    }
  }

  Future load() async {
    String stringJsonValues = await rootBundle.loadString("assets/guests.json");
    print(stringJsonValues);
    guests = json.decode(stringJsonValues);
  }

  @override
  void initState() {
    Future.microtask(() async {
      await load();
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    print(guests);
    return guests == null
        ? CircularProgressIndicator()
        : Scaffold(
            body: Container(
              height: deviceSize.height,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(244, 237, 229, 1),
              ),
              child: Container(
                child: Stack(children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/InvitationCard.png"),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 184),
                          child: Text(
                            guests?[widget.id] ?? "None",
                            style: TextStyle(
                              height: 1,
                              fontFamily: "Stylus",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 184),
                          child: TextButton(
                            onPressed: () {
                              _launchUrl();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.pin_drop),
                                Text(
                                  "View Location",
                                  style: TextStyle(
                                      fontFamily: "Stylus",
                                      decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              ),
            ),
          );
  }
}
