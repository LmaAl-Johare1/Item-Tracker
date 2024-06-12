import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Models/Reminder.dart';
import '../../ViewModels/Reminder/ReminderViewModel.dart';
import '../../res/AppColor.dart';
import '../../res/AppText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'ReminderCardView.dart';

class RemindersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RemindersViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColor.primary),
          title: Text(
            AppLocalizations.of(context)!.reminders,
            style: TextStyle(
              color: AppColor.primary,
              fontSize: AppText.HeadingOne.fontSize,
              fontWeight: AppText.HeadingOne.fontWeight,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/dashboard');
            },
          ),
        ),
        body: Consumer<RemindersViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.reminders.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: viewModel.reminders.length,
              itemBuilder: (context, index) {
                final reminder = viewModel.reminders[index];
                return ReminderCard(
                  reminder: reminder,
                  onAcknowledge: () {
                    viewModel.acknowledgeReminder(reminder.id);
                  },
                  onDelete: () {
                    viewModel.deleteReminder(reminder.id);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}