import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insides/features/fitness/components/circular_progress_indicator.dart';

class StepsInsightsCardComponent extends StatelessWidget {
  final double totalSteps, goal, calories;
  final int nAchieved;
  const StepsInsightsCardComponent(
      {super.key,
      required this.totalSteps,
      required this.goal,
      required this.calories,
      required this.nAchieved});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25, top: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 200, 200, 200),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Steps Walked",
                    style: GoogleFonts.openSans(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  RadialProgressComponent(
                    progress: totalSteps != 0 ? totalSteps / 6000 : 0,
                    primaryText: totalSteps != 0
                        ? totalSteps.toInt().toString() + "/" + 6000.toString()
                        : 0.toString() + "/" + goal.toInt().toString(),
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.3,
                    secondaryText: 'Steps Walked',
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Achieved Goals"),
                    Spacer(),
                    Text("$nAchieved Days"),
                  ],
                ),
              ),
              Divider(
                color: Colors.white.withOpacity(0.8),
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Review"),
                    Spacer(),
                    Text(
                        "${(totalSteps * 100 / goal).toStringAsFixed(2)}% Achieved")
                  ],
                ),
              ),
              Divider(
                color: Colors.white.withOpacity(0.8),
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Calories Burned"),
                    Spacer(),
                    Text(calories.toStringAsFixed(2) + " kcal")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
