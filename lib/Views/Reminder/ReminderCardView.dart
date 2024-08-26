import 'package:flutter/material.dart';
import '../../Models/Reminder.dart';
import '../../res/AppColor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReminderCard extends StatefulWidget {
  final Reminder reminder;
  final VoidCallback onAcknowledge;
  final VoidCallback onDelete;

  const ReminderCard({
    Key? key,
    required this.reminder,
    required this.onAcknowledge,
    required this.onDelete,
  }) : super(key: key);

  @override
  _ReminderCardState createState() => _ReminderCardState();
}

class _ReminderCardState extends State<ReminderCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white, // Set card background color to white
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(16),
            title: Text(
              '${widget.reminder.productName} ${AppLocalizations.of(context)!.nearSoldOut}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.primary,
              ),
            ),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.productName}: ${widget.reminder.productName}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${AppLocalizations.of(context)!.quantity}: ${widget.reminder.currentStock}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
        ],
      ),
    );
  }
}