import 'dart:math';

import 'package:flutter/material.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm(
      {this.currentIncome,
      this.currentSavings,
      this.expectedIncome,
      required this.onCurrentIncomeChanged,
      required this.onSavingsChanged,
      required this.onExpectedIncomeChanged,
      Key? key})
      : super(key: key);

  final double? currentIncome;
  final double? currentSavings;
  final double? expectedIncome;

  final ValueChanged<double> onCurrentIncomeChanged;
  final ValueChanged<double> onSavingsChanged;
  final ValueChanged<double> onExpectedIncomeChanged;

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  double currentIncomeLog = 4;

  double get currentIncome {
    return pot(currentIncomeLog);
  }

  double currentSavingsLog = 3;

  double get currentSavings {
    return pot(currentSavingsLog);
  }

  double expectedIncomeLog = 5;

  double get expectedIncome {
    return pot(expectedIncomeLog);
  }

  @override
  void initState() {
    if (widget.currentIncome != null) {
      currentIncomeLog = log(widget.currentIncome!) / log(10);
    }
    if (widget.currentSavings != null) {
      currentSavingsLog = log(widget.currentSavings!) / log(10);
    }
    if (widget.expectedIncome != null) {
      expectedIncomeLog = log(widget.expectedIncome!) / log(10);
    }
    super.initState();
  }

  double pot(double value) {
    value = pow(10, value).toDouble();
    if (value < 1000) {
      value = (value / 100).roundToDouble() * 100;
    } else if (value < 10000) {
      value = (value / 1000).roundToDouble() * 1000;
    } else {
      value = (value / 10000).roundToDouble() * 10000;
    }
    return value;
  }

  String format(double v) {
    var s = v.round().toString();
    var l = s.length;
    if (l > 3) s = '${s.substring(0, l - 3)}.${s.substring(l - 3)}';
    if (l > 6) s = '${s.substring(0, l - 6)}.${s.substring(l - 6)}';
    return s;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Current yearly income',
                style: Theme.of(context).textTheme.labelLarge),
            const Spacer(),
            Text('${format(currentIncome)}€',
                style: Theme.of(context).textTheme.labelMedium),
          ],
        ),
        Slider(
          value: currentIncomeLog,
          min: 3,
          max: 6,
          onChanged: (value) {
            setState(() {
              currentIncomeLog = value;
              if (expectedIncomeLog < currentIncomeLog) {
                expectedIncomeLog = currentIncomeLog;
              }
            });
            widget.onCurrentIncomeChanged.call(currentIncome);
          },
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Text('Current savings',
                style: Theme.of(context).textTheme.labelLarge),
            const Spacer(),
            Text('${format(currentSavings)}€',
                style: Theme.of(context).textTheme.labelMedium),
          ],
        ),
        Slider(
          value: currentSavingsLog,
          min: 3,
          max: 6,
          onChanged: (value) {
            setState(() {
              currentSavingsLog = value;
            });
            widget.onSavingsChanged.call(currentSavings);
          },
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Expected yearly income in 20 years',
                    style: Theme.of(context).textTheme.labelLarge),
                Text('Try to be realistic based on your current career path.',
                    style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
            const Spacer(),
            Text('${format(expectedIncome)}€',
                style: Theme.of(context).textTheme.labelMedium),
          ],
        ),
        Slider(
          value: expectedIncomeLog,
          min: 3,
          max: 7,
          onChanged: (value) {
            setState(() {
              expectedIncomeLog = value;
              if (expectedIncomeLog < currentIncomeLog) {
                currentIncomeLog = expectedIncomeLog;
              }
            });
            widget.onExpectedIncomeChanged.call(expectedIncome);
          },
        ),
      ],
    );
  }
}
