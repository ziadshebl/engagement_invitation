import 'package:engagement_invitation/invitation_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:vrouter/vrouter.dart';

class EngagementApp extends StatefulWidget {
  const EngagementApp({Key? key}) : super(key: key);

  @override
  State<EngagementApp> createState() => _EngagementAppState();
}

class _EngagementAppState extends State<EngagementApp> {
  late Future myFuture;
  static final vRouterKey = GlobalKey<VRouterState>();

  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return VRouter(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      key: vRouterKey,
      mode: VRouterMode.hash,
      title: 'Survai',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      buildTransition: (animation1, _, child) =>
          FadeTransition(opacity: animation1, child: child),
      routes: [
        VWidget(
          path: '/',
          widget: Builder(
            builder: (context) => Container(
              child: Text("Empty"),
            ),
          ),
        ),
        VWidget(
          path: '/:id',
          widget: Builder(
            builder: (context) => InvitationView(
              id: context.vRouter.pathParameters['id']!,
            ),
          ),
        ),
        VRouteRedirector(
          path: ':_(.*)',
          redirectTo: '/',
        ),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
