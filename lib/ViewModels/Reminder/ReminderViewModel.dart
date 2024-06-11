import 'package:flutter/material.dart';
import '../../Models/Reminder.dart';
import '../../Services/network_service.dart';
import '../../Services/notification_service.dart';

class RemindersViewModel extends ChangeNotifier {
  final NetworkService _networkService = NetworkService();
  final NotificationService _notificationService = NotificationService();
  List<Reminder> _reminders = [];

  List<Reminder> get reminders => _reminders;

  RemindersViewModel() {
    fetchReminders();
    _checkAndAddRemindersForAllProducts();
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

  Future<void> _checkAndAddRemindersForAllProducts() async {
    try {
      List<Map<String, dynamic>> productsData = await _networkService.fetchAll('products');
      for (var productData in productsData) {
        String productId = productData['id'] ?? '';
        await checkAndAddReminder(productId);
      }
    } catch (e) {
      print('Failed to check and add reminders for all products: $e');
    }
  }

  Future<void> checkAndAddReminder(String productId) async {
    try {
      Map<String, dynamic>? productData = await _networkService.fetchData('products', 'productId', productId);
      if (productData == null) {
        print('No document found for id: $productId');
        return;
      }

      int currentStock = productData['quantity'] ?? 0;
      String productName = productData['productName'] ?? 'Unknown';

      // Check if the product is near sold out
      if (currentStock <= 10) {
        Reminder newReminder = Reminder(
          id: '',
          productId: productId,
          productName: productName,
          currentStock: currentStock,
          timestamp: DateTime.now(),
        );

        await _networkService.sendData('Reminders', newReminder.toMap());
        await fetchReminders();

        // Show notification
        await _notificationService.showNotification(
          id: productId.hashCode,
          title: 'Low Stock Alert',
          body: 'The stock of $productName is below 10.',
        );
      }
    } catch (e) {
      print('Failed to check and add reminder: $e');
    }
  }
}
