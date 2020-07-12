import 'dart:async';

import 'package:authmabform/auth_services/auth.dart';
import 'package:authmabform/sidebar_navigation/custom_clipper.dart';
import 'package:authmabform/sidebar_navigation/menu_item.dart';
import 'package:authmabform/sidebar_navigation/navigation_bloc.dart';
import 'package:authmabform/widgest/platform_alert_dailog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  final _animationDuration = const Duration(milliseconds: 500);
  StreamController<bool> _isSidebarOpenStreamController;
  Stream<bool> _isSidebarOpenStream;
  StreamSink<bool> _isSidebarOpenSink;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: _animationDuration);
    _isSidebarOpenStreamController = PublishSubject<bool>();
    _isSidebarOpenStream = _isSidebarOpenStreamController.stream;
    _isSidebarOpenSink = _isSidebarOpenStreamController.sink;
  }

  @override
  void dispose() {
    _controller.dispose();
    _isSidebarOpenStreamController.close();
    _isSidebarOpenSink.close();
    super.dispose();
  }

  void _onIconPressed() {
    final animationStatus = _controller.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;
    if (isAnimationCompleted) {
      _isSidebarOpenSink.add(false);
      _controller.reverse();
    } else {
      _isSidebarOpenSink.add(true);
      _controller.forward();
    }
  }

  Future<void> _signOut(context) async {
    try {
      final auth = Provider.of<Auth>(context, listen: false);
      await auth.signOut();
    } catch (e) {}
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to lougout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final user = Provider.of<User>(context);
    return StreamBuilder<bool>(
      initialData: false,
      stream: _isSidebarOpenStream,
      builder: (context, sidebarSnapshot) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: sidebarSnapshot.data ? 0 : -mediaQuery.width,
          right: sidebarSnapshot.data ? 0 : mediaQuery.width - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 100),
                        ListTile(
                          title: user.displayName != null
                              ? Text(
                                  user.displayName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )
                              : Text(
                                  'username',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                          leading: CircleAvatar(
                            backgroundImage: user.photoUrl != null
                                ? NetworkImage(user.photoUrl)
                                : null,
                            child: user.photoUrl == null
                                ? Icon(
                                    Icons.camera_alt,
                                    size: 25,
                                  )
                                : null,
                            radius: 25,
                          ),
                        ),
                        Divider(
                          height: 64,
                          thickness: 1,
                          color: Colors.white.withOpacity(0.3),
                          indent: 32,
                          endIndent: 32,
                        ),
                        MenuItem(
                          icon: Icons.home,
                          title: 'Home',
                          onTap: () {
                            _onIconPressed();
                            BlocProvider.of<NavigationBloc>(context).add(
                              NavigationEvents.HomePageClickedEvent,
                            );
                          },
                        ),
                        MenuItem(
                          icon: Icons.person,
                          title: 'Account',
                          onTap: () {
                            _onIconPressed();
                            BlocProvider.of<NavigationBloc>(context).add(
                              NavigationEvents.AccountClickedEvent,
                            );
                          },
                        ),
                        Divider(
                          height: 64,
                          thickness: 1,
                          color: Colors.white.withOpacity(0.3),
                          indent: 32,
                          endIndent: 32,
                        ),
                        MenuItem(
                          icon: Icons.exit_to_app,
                          title: 'Logout',
                          onTap: () => _confirmSignOut(context),
                        ),
                      ],
                    )),
              ),
              Align(
                alignment: Alignment(0, 1),
                child: GestureDetector(
                  onTap: () => _onIconPressed(),
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: 35,
                      height: 110,
                      color: Theme.of(context).primaryColor,
                      child: AnimatedIcon(
                        progress: _controller.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
