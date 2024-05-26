import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Models/Reminder.dart';
import '../../ViewModels/ReminderViewModel.dart';
import '../../res/AppColor.dart';
import '../../res/AppText.dart';

class RemindersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RemindersViewModel()..fetchReminders(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColor.primary),
          title: Text(
            'Reminders',
            style: TextStyle(
              color: AppColor.primary,
              fontSize: AppText.HeadingOne.fontSize,
              fontWeight: AppText.HeadingOne.fontWeight,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/dashboard');
            },
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 20), // Added SizedBox
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
                      String message;
                      if (reminder.expDate != null && reminder.expDate!.difference(DateTime.now()).inDays <= 5) {
                        message = 'End date is approaching - ${reminder.productName} nearing to expiry date. Consider selling it immediately';
                      } else {
                        message = 'Low Inventory - ${reminder.productName} nearing depletion. Consider restocking soon';
                      }
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
        title: Text(reminder.expDate != null && reminder.expDate!.difference(DateTime.now()).inDays <= 5
            ? 'End date is approaching - ${reminder.productName} nearing to expiry date'
            : 'Low Inventory - ${reminder.productName} nearing depletion'),
        content: Text('Consider ${reminder.expDate != null && reminder.expDate!.difference(DateTime.now()).inDays <= 5 ? 'selling it immediately' : 'restocking soon'}.'),
        actions: [
          TextButton(
            onPressed: () {
              viewModel.acknowledgeReminder(reminder.id);
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}