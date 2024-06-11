import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Models/Reminder.dart';
import '../../ViewModels/Reminder/ReminderViewModel.dart';
import '../../res/AppColor.dart';
import '../../res/AppText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        body: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: Consumer<RemindersViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.reminders.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: viewModel.reminders.length,
                    itemBuilder: (context, index) {
                      final reminder = viewModel.reminders[index];
                      String message = '${AppLocalizations.of(context)!.productOut} - ${reminder.productName} ${AppLocalizations.of(context)!.nearSoldOut}';
                      return Center(
                        child: Container(
                          width: 350,
                          height: 100,
                          child: Card(
                            color: Colors.grey[300],
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(
                                message,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                _showReminderDialog(context, reminder, viewModel);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReminderDialog(BuildContext context, Reminder reminder, RemindersViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${AppLocalizations.of(context)!.productOut} - ${reminder.productName} ${AppLocalizations.of(context)!.nearSoldOut}'),
        content: Text('Do you want to acknowledge this reminder?'),
        actions: [
          TextButton(
            onPressed: () {
              viewModel.acknowledgeReminder(reminder.id);
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context)!.delete),
          ),
        ],
      ),
    );
  }
}