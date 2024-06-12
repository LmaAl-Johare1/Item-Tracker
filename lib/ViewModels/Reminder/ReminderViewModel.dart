import 'package:flutter/material.dart';
import '../../Models/Reminder.dart';
import '../../Services/network_service.dart';

class RemindersViewModel extends ChangeNotifier {
  final NetworkService _networkService = NetworkService();
  List<Reminder> _reminders = [];

  List<Reminder> get reminders => _reminders;

  RemindersViewModel() {
    _fetchAndAddReminders();
  }

  Future<void> _fetchAndAddReminders() async {
    try {
      await fetchReminders();
      await _checkAndAddRemindersForAllProducts();
    } catch (e) {
      print('Failed to fetch and add reminders: $e');
    }
  }

  Future<void> fetchReminders() async {
    try {
      List<Map<String, dynamic>> remindersData = await _networkService.fetchAll('Reminders');
      _reminders = remindersData.map((data) {
        String documentId = data['id'] ?? '';
        return Reminder.fromMap(data, documentId);
      }).toList();
      notifyListeners();
    } catch (e) {
      print('Failed to fetch reminders: $e');
    }
  }

  Future<void> acknowledgeReminder(String reminderId) async {
    try {
      await _networkService.updateData('Reminders', 'id', reminderId, {'acknowledged': true});
      await fetchReminders();
    } catch (e) {
      print('Failed to acknowledge reminder: $e');
    }
  }

  Future<void> deleteReminder(String reminderId) async {
    try {
      await _networkService.deleteData('Reminders', 'id', reminderId);
      _reminders.removeWhere((reminder) => reminder.id == reminderId);
      notifyListeners();
    } catch (e) {
      print('Failed to delete reminder: $e');
    }
  }

  Future<void> _checkAndAddRemindersForAllProducts() async {
    try {
      List<Map<String, dynamic>> productsData = await _networkService.fetchAll('products');
      for (var productData in productsData) {
        String productId = productData['productId'] ?? '';
        await checkAndAddReminder(productId, productData);
      }
    } catch (e) {
      print('Failed to check and add reminders for all products: $e');
    }
  }

  Future<void> checkAndAddReminder(String productId, Map<String, dynamic> productData) async {
    try {
      bool reminderExists = _reminders.any((reminder) => reminder.productId == productId);
      if (reminderExists) {
        return;
      }

      int currentStock = productData['quantity'] ?? 0;
      String productName = productData['productName'] ?? 'Unknown';

      if (currentStock <= 10) {
        Reminder newReminder = Reminder(
          id: '',
          productId: productId,
          productName: productName,
          currentStock: currentStock,
          timestamp: DateTime.now(),
        );

        _reminders.add(newReminder);
        notifyListeners();
      }
    } catch (e) {
      print('Failed to check and add reminder: $e');
    }
  }
}
