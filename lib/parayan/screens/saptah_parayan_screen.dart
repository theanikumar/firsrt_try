import 'package:flutter/material.dart';
import '../widgets/parayan_main_container.dart';
import '../widgets/saptah_parayan/saptah_parayan_info_card.dart';
import '../widgets/saptah_parayan/saptah_parayan_progress_widget.dart';
import '../widgets/saptah_parayan/daily_saptah_schedule.dart';

class SaptahParayanScreen extends StatefulWidget {
  const SaptahParayanScreen({super.key});

  @override
  State<SaptahParayanScreen> createState() => _SaptahParayanScreenState();
}

class _SaptahParayanScreenState extends State<SaptahParayanScreen> {
  double _selectedSpeed = 1.0;

  void _handleSpeedChange(double speed) {
    setState(() {
      _selectedSpeed = speed;
    });
    print('Speed changed to: $speed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3EC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ParayanMainContainer(
            children: [
              // 1. Saptah Parayan Info Card
              SaptahParayanInfoCard(
                title: 'Shravan Shukla Parayan',
                dateRange: 'Thu 24 Oct - Wed 30 Oct',
                daysLeft: '3 days left',
                selectedSpeed: _selectedSpeed,
                onSpeedChanged: _handleSpeedChange,
              ),

              // 2. Saptah Parayan Progress Widget
              const SaptahParayanProgressWidget(
                completedChapters: 18,
                totalChapters: 51,
                completedDays: 2,
                timeListened: '4h 12m listened',
                timeLeft: 'Est. 5h 45m left',
              ),

              // 3. Daily Saptah Schedule
              const DailySaptahSchedule(),
            ],
          ),
        ),
      ),
    );
  }
}
