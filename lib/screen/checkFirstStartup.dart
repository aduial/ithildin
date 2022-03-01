
import 'package:flutter/material.dart';
import '../config/is_first_run.dart';
import 'ithildin_screen.dart';
import 'minui.dart';

class CheckFirstStartup extends StatefulWidget {
  const CheckFirstStartup({Key? key}) : super(key: key);

  @override
  _CheckFirstStartupState createState() => _CheckFirstStartupState();
}

class _CheckFirstStartupState extends State<CheckFirstStartup> {
  bool? _isFirstRun;

  @override
  void initState() {
    super.initState();
    checkFirstRun();
  }

  Future checkFirstRun() async {
    bool ifr = await IsFirstRun.isFirstRun();
    setState(() {
      _isFirstRun = ifr;
      Navigator.of(context).push(minno(_isFirstRun ?? true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}


Route minno(bool isFirstRun) {
  if (isFirstRun) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Minui(),
      transitionDuration: const Duration(milliseconds: 2000),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  } else {
    return PageRouteBuilder(

      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return const IthildinScreen();
      },
      transitionDuration: const Duration(milliseconds: 2000),
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(-1.0, 0.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      },
    );
  }
}
