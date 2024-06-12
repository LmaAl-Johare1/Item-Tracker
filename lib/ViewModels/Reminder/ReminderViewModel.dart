import 'package:flutter/material.dart';
import '../../Models/Reminder.dart';
import '../../Services/network_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// ViewModel for managing reminders in the application.
///
/// This class handles fetching reminders from the database, acknowledging and deleting reminders,
/// and adding new reminders based on product stock levels.
class RemindersViewModel extends ChangeNotifier {
  /// Instance of NetworkService to handle database operations.
  final NetworkService _networkService = NetworkService();

  /// Instance of FirebaseFirestore to interact with Firestore.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// List of reminders to be displayed in the UI.
  List<Reminder> _reminders = [];

  /// Getter for the list of reminders.
  List<Reminder> get reminders => _reminders;

  /// Constructor that initializes the ViewModel and fetches reminders.
  RemindersViewModel() {
    _fetchAndAddReminders();
  }

  /// Fetches and adds reminders to the list.
  ///
  /// This method first fetches existing reminders and then checks and adds new reminders for all products.
  Future<void> _fetchAndAddReminders() async {
    try {
      await fetchReminders();
      await _checkAndAddRemindersForAllProducts();
    } catch (e) {
      print('Failed to fetch and add reminders: $e');
    }
  }

  /// Fetches reminders from the database.
  ///
  /// This method fetches all reminders from the 'Reminders' collection in Firestore
  /// and updates the local list of reminders.
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

  /// Acknowledges a reminder by updating its status in the database.
  ///
  /// This method sets the 'acknowledged' field of the specified reminder to true
  /// and then fetches the updated list of reminders.
  ///
  /// [reminderId] - The ID of the reminder to acknowledge.
  Future<void> acknowledgeReminder(String reminderId) async {
    try {
      await _networkService.updateData('Reminders', 'id', reminderId, {'acknowledged': true});
      await fetchReminders();
    } catch (e) {
      print('Failed to acknowledge reminder: $e');
    }
  }

  /// Deletes a reminder from the database and updates the local list.
  ///
  /// This method removes the specified reminder from the Firestore 'Reminders' collection
  /// and updates the local list of reminders.
  ///
  /// [reminderId] - The ID of the reminder to delete.
  Future<void> deleteReminder(String reminderId) async {
    try {
      await _firestore.collection('Reminders').doc(reminderId).delete();
      _reminders.removeWhere((reminder) => reminder.id == reminderId);
      notifyListeners();
    } catch (e) {
      print('Failed to delete reminder: $e');
    }
  }

  /// Checks and adds reminders for all products in the database.
  ///
  /// This method fetches all products and checks if a reminder needs to be added based on their stock levels.
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

  /// Checks if a reminder needs to be added for a specific product and adds it if necessary.
  ///
  /// This method checks the stock level of the specified product and adds a reminder if the stock is low.
  ///
  /// [productId] - The ID of the product to check.
  /// [productData] - The data of the product.
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
