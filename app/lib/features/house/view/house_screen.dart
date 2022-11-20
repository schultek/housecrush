import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/constants/colors.dart';
import 'package:housecrush_app/features/auth/data/auth_repository.dart';
import 'package:housecrush_app/features/common/view/loading_screen.dart';
import 'package:housecrush_app/features/house/controllers/house_controller.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../common/view/back_button.dart';
import '../../profile/data/profile_repository.dart';
import '../domain/house.dart';
import 'house_card.dart';

class HouseScreen extends StatelessWidget {
  const HouseScreen({required this.id, this.house, Key? key}) : super(key: key);

  final String id;
  final House? house;

  @override
  Widget build(BuildContext context) {
    if (house != null) {
      return buildHouseData(context, house!);
    } else {
      return FutureBuilder(
        future: context.read(houseController).loadHouse(id),
        builder: (context, data) {
          if (data.data != null) {
            return buildHouseData(context, data.data!);
          } else {
            return const LoadingScreen();
          }
        },
      );
    }
  }

  Widget buildHouseData(BuildContext context, House house) {
    var descStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 15);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Builder(builder: (context) {
            var houseWithLoan =
                context.watch(houseWithLoanController(id)).valueOrNull;
            var ownerName = house.owner != context.read(userIdRepository) ?
            context.watch(userNameByIdProvider(house.owner)).valueOrNull : null;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const GoBackButton(),
                      const Spacer(),
                      house.loan == null
                          ? loanLoader(house.id)
                          : const SizedBox.shrink(),
                    ],
                  ),
                  Text(
                    '${house.description}.',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  if (ownerName != null)
                    Text('by ${ownerName}', style: TextStyle(fontWeight: FontWeight.bold),),

                  const SizedBox(height: 20),
                  if (houseWithLoan != null) ...[
                    const SizedBox(height: 10),
                    Text('${houseWithLoan.price!.toStringAsFixed(0)} €',
                        style: const TextStyle(
                          fontSize: 50,
                        )),
                  ],
                  const SizedBox(height: 20),
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Hero(
                        tag: 'hero-${house.id}',
                        child: HouseCard(house: house)),
                  ),
                  const SizedBox(height: 20),
                  if (houseWithLoan != null)
                    if (houseWithLoan.bank != 'None') ...[
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).colorScheme.surfaceVariant,
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Found loan by ${houseWithLoan.bank} over',
                            style: descStyle),
                            Text(
                              '${houseWithLoan.loan!.toStringAsFixed(0)} €',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            Text('with a monthly payment of', style: descStyle),
                            Row(
                              children: [
                                Text(
                                  '${houseWithLoan.monthlyPayment!.toStringAsFixed(0)} €/mo',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                const SizedBox(width: 5),
                                Text('over', style: descStyle),
                                const SizedBox(width: 5),
                                Text(
                                  houseWithLoan.loanYears!.toStringAsFixed(0),
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                const SizedBox(width: 5),
                                Text('years', style: descStyle),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).colorScheme.surfaceVariant,
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text('Based on ${ownerName != null ? '${ownerName}s' : 'your'} income profile, '
                                '${ownerName ?? 'you'} may '
                                'be able to afford this loan in about', style: descStyle),
                            Row(
                              children: [
                                Text(
                                  houseWithLoan.waitYears!.toStringAsFixed(0),
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                    'year${houseWithLoan.waitYears! > 1 ? 's' : ''}.', style: descStyle),
                              ],
                            ),
                            const SizedBox(height: 10),
                            scoreGraph(context, houseWithLoan),
                            const SizedBox(height: 8),
                            if (ownerName == null)
                            Text(
                              [
                                'Your know your finances and have realistic life goals. What a Boomer.',
                                'Wait a few years and safe well. Who knows...',
                                'Seems a bit far fetched, ay?',
                                "You don't seriously think you could ever afford this?"
                              ][houseWithLoan.score],
                              style: const TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ) else Text(
                              [
                                'Has their finances in order and realistic life goals. What a Boomer.',
                                'Even a blind squirrel finds an acorn once in a while.',
                                'Maybe they are planning something?',
                                'What an idiot.'
                              ][houseWithLoan.score],
                              style: const TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ] else ...[
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: hcDark[200],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(children: const [
                          Text('Sorry, no bank offered a loan for this...'),
                        ]),
                      ),
                    ],
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget loanLoader(String id) {
    return Builder(builder: (context) {
      var house = context.watch(houseWithLoanController(id));

      if (house.isLoading) {
        return Row(
          children: const [
            Opacity(
              opacity: 0.6,
              child: Text(
                'Loading loan details...',
                style: TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(width: 10),
            SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget scoreGraph(BuildContext context, House houseWithLoan) {
    var score = houseWithLoan.score;

    var stepTitleStyle = TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.bold);

    return AnotherStepper(
      activeIndex: 3,
      activeBarColor: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
      barThickness: 3,
      stepperList: [
        StepperData(
          title: StepperText('Realist', textStyle: stepTitleStyle),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: score == 0 ? Colors.green : Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: score == 0 ? const Center(child: Text('🥸')) : null,
          ),
        ),
        StepperData(
          title: StepperText('Optimist', textStyle: stepTitleStyle),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: score == 1 ? Colors.green : Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: score == 1 ? const Center(child: Text('😇')) : null,
          ),
        ),
        StepperData(
          title: StepperText('Dreamer', textStyle: stepTitleStyle),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: score == 2 ? Colors.green : Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: score == 2 ? const Center(child: Text('😶‍🌫️')) : null,
          ),
        ),
        StepperData(
          title: StepperText('Idiot', textStyle: stepTitleStyle),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: score == 3 ? Colors.green : Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: score == 3 ? const Center(child: Text('🥴')) : null,
          ),
        ),
      ],
      stepperDirection: Axis.horizontal,
      iconWidth: 40, // Height that will be applied to all the stepper icons
      iconHeight: 40, // Width that will be applied to all the stepper icons
    );
  }
}
