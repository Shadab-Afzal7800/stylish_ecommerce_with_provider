import 'dart:async';

import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

Duration countdownDuration =
    const Duration(hours: 22, minutes: 55, seconds: 20);
Timer? timer;

class _DealOfTheDayState extends State<DealOfTheDay> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => updateTimer());
  }

  void updateTimer() {
    setState(() {
      if (countdownDuration.inSeconds > 0) {
        countdownDuration = countdownDuration - const Duration(seconds: 1);
      } else {
        timer?.cancel();
      }
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}h ${twoDigitMinutes}m ${twoDigitSeconds}s";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: const Color(0xff4392F9),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Deal of the Day",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.watch_later_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    formatDuration(countdownDuration),
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "remaining",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(8)),
            child: const Row(
              children: [
                Text(
                  "VIEW all",
                  style: TextStyle(color: Colors.white),
                ),
                Icon(Icons.arrow_forward, color: Colors.white)
              ],
            ),
          )
        ],
      ),
    );
  }
}
