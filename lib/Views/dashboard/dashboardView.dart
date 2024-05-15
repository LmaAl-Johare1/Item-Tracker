import 'package:flutter/material.dart';
import 'package:project/res/AppText.dart';
import 'package:project/res/AppColor.dart';
import 'package:project/services/network_service.dart';
import '../../ViewModels/DashboardViewModel.dart';



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
  late MyHomePageViewModel _viewModel;
  final NetworkService _networkService = NetworkService();

  @override
  void initState() {
    super.initState();

    _viewModel = MyHomePageViewModel();

    if (_viewModel.total == 0 && _viewModel.productIn == 0 && _viewModel.productOut == 0) {

      _viewModel.updateProductInCount();
      _viewModel.listenForProductInsertions();
      _viewModel.checkAndAggregateQuantities();
    } else {
      setState(() {});
    }
  }

  int _selectedIndex = 1;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //     switch (_selectedIndex) {
  //       // case 0:
  //       //   Navigator.push(
  //       //       context, MaterialPageRoute(builder: (context) => LoginScreen()));
  //       //   break;
  //       case 1:
  //       // (Home)
  //         Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (context) => MyHomePage()));
  //         break;
  //       case 2:
  //         Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => SettingsPage()));
  //         break;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.white,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      Text(
                        'Dashboard',
                        style: AppText.headingOne
                            .copyWith(color: AppColor.primary),
                      ),
                      SizedBox(height: 30),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 8),
                              decoration: BoxDecoration(
                                color: AppColor.greylight,
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.inventory,
                                        size: 30,
                                        color: AppColor.primary,
                                      ),
                                      SizedBox(width: 15),
                                      Text(
                                        'Total:               ${_viewModel.total}',
                                        style: AppText.headingThree
                                            .copyWith(color: AppColor.primary),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Icon(Icons.file_upload_outlined,
                                          size: 30, color: AppColor.primary),
                                      SizedBox(width: 15),
                                      Text(
                                        'Product In:      ${_viewModel.productIn}',
                                        style: AppText.headingThree
                                            .copyWith(color: AppColor.primary),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Icon(Icons.file_download_outlined,
                                          size: 30, color: AppColor.primary),
                                      SizedBox(width: 15),
                                      Text(
                                        'Product Out:      ${_viewModel.productOut}',
                                        style: AppText.headingThree
                                            .copyWith(color: AppColor.primary),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(25),
                            child: TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.fromLTRB(20, 10, 20, 8)),
                                backgroundColor:
                                MaterialStateProperty.all(AppColor.greylight),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.notifications_none_outlined,
                                      color: AppColor.productInfo, size: 30),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      'Reminders',
                                      style: AppText.headingThree
                                          .copyWith(color: AppColor.primary),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(),
                                  ),
                                  Icon(Icons.arrow_forward_ios,
                                      color: AppColor.primary),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 3),
                          SizedBox(height: 10),
                          Center(
                            child: TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                foregroundColor:
                                MaterialStateProperty.all(AppColor.primary),
                                overlayColor: MaterialStateProperty.all(
                                    AppColor.primary.withOpacity(0.1)),
                                textStyle: MaterialStateProperty.all(
                                  AppText.headingTwo.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Go to Charts',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 165,
                                height: 65,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Center(
                                    child: Text('View Category',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppColor.secondary)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 165,
                                height: 65,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Center(
                                    child: Text('Insert Product',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppColor.secondary)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 165,
                                height: 65,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17),
                                    ),
                                  ),
                                  onPressed: () {
                                    // أضف الكود هنا لإضافة منتج جديد
                                  },
                                  child: Center(
                                    child: Text('supply product',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppColor.secondary)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 165,
                                height: 65,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17),
                                    ),
                                  ),
                                  onPressed: () {
                                    // أضف الكود هنا لتوليد رمز شريطي
                                  },
                                  child: Center(
                                    child: Text('Generate Barcode',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColor.secondary)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),



      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.insert_chart),
      //       label: 'Reports',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Settings',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   backgroundColor: AppColor.greylight,
      //   selectedItemColor: Colors.black,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
