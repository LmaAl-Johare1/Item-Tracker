import 'package:flutter/material.dart';
import '../../Models/Reminder.dart';
import '../../res/AppColor.dart';
import '../../res/AppText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../ViewModels/Reminder/ReminderViewModel.dart';

class ReminderDetailScreen extends StatelessWidget {
  final Reminder reminder;

  ReminderDetailScreen({required this.reminder});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RemindersViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColor.primary),
        title: Text(
          AppLocalizations.of(context)!.reminderDetails,
          style: TextStyle(
            color: AppColor.primary,
            fontSize: AppText.HeadingOne.fontSize,
            fontWeight: AppText.HeadingOne.fontWeight,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${AppLocalizations.of(context)!.productName}: ${reminder.productName}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '${AppLocalizations.of(context)!.quantity}: ${reminder.currentStock}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '${AppLocalizations.of(context)!.timestamp}: ${reminder.timestamp}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    viewModel.acknowledgeReminder(reminder.id);
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context)!.ok),
                ),
                SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    viewModel.deleteReminder(reminder.id);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.delete,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
