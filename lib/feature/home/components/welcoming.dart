import 'package:chrconnecthpdraft/feature/app/extension/context.dart';
import 'package:flutter/material.dart';

class Welcoming extends StatelessWidget {
  const Welcoming({
    Key? key,
    required this.state,
    required this.name,
    this.onboard=false,
  }) : super(key: key);

  final WelcomingStates state;
  final String name;
  final bool? onboard;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: (onboard==true)?Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.normal)!
          :Theme.of(context).textTheme.displayLarge!,
      child: Builder(builder: (context) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state == WelcomingStates.morning)
              Text(context.localizations.good_morning),
            if (state == WelcomingStates.afternoon)
              Text(context.localizations.good_afternoon),
            if (state == WelcomingStates.evening)
              Text(context.localizations.good_evening),
            Text(' ${context.localizations.name_exclamation(name)}'),
          ],
        );
      }),
    );
  }
}

enum WelcomingStates {
  morning,
  afternoon,
  evening,
}
