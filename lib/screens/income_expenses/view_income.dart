import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_gym_manager/config/palette.dart';
import 'package:my_gym_manager/screens/drawer.dart';
import 'package:my_gym_manager/widgets/custom_app_bar2.dart';
import 'package:my_gym_manager/widgets/custom_card_money.dart';

class ViewIncome extends StatefulWidget {
  @override
  _ViewIncomeState createState() => _ViewIncomeState();
}

class _ViewIncomeState extends State<ViewIncome> {
  DatabaseReference _incomeRef;
  DateTime date;
  @override
  void initState() {
    date = DateTime.now();
    String ndate = DateFormat('yyyy-MM-dd').format(date).toString();
    final FirebaseDatabase database = FirebaseDatabase();
    _incomeRef = database
        .reference()
        .child(FirebaseAuth.instance.currentUser.uid)
        .child('Income')
        .child(ndate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: CustomAppBar2(Icons.arrow_back_ios, () {
        Navigator.pop(context);
      }, 'View Incomes'),
      drawer: AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Palette.secondaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
              ),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextField(
                        onChanged: (value) => {},
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Search',
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                          contentPadding: const EdgeInsets.only(top: 15.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Flexible(
                    child: new FirebaseAnimatedList(
                      shrinkWrap: true,
                      query: _incomeRef,
                      itemBuilder: (
                        BuildContext context,
                        DataSnapshot snapshot,
                        Animation<double> animation,
                        int index,
                      ) {
                        return CustomCardMoney(
                          title: snapshot.value['Title'].toString(),
                          amount: snapshot.value['Amount'].toString(),
                          date: snapshot.value['Date'].toString(),
                          detail: snapshot.value['Details'].toString(),
                          imagePath:
                              'assets/images/cash_flow_tranfer_finance-512.png',
                          // func1: () => {
                          //   Alert(
                          //     context: context,
                          //     type: AlertType.warning,
                          //     title: "Renew Service Date",
                          //     desc:
                          //         "Are you sure you want to renew service date?",
                          //     buttons: [
                          //       DialogButton(
                          //         child: Text(
                          //           "Renew",
                          //           style: TextStyle(
                          //               color: Colors.white, fontSize: 20),
                          //         ),
                          //         onPressed: () {
                          //           date = DateTime.parse(snapshot
                          //               .value['Service_Date']
                          //               .toString());
                          //           _incomeRef
                          //               .child(snapshot.key)
                          //               .child('Service_Date')
                          //               .set(DateFormat('yyyy-MM-dd')
                          //                   .format(
                          //                     date.add(
                          //                       Duration(days: 120),
                          //                     ),
                          //                   )
                          //                   .toString());
                          //           Navigator.pop(context);
                          //         },
                          //         color: Color.fromRGBO(0, 179, 134, 1.0),
                          //       ),
                          //       DialogButton(
                          //         child: Text(
                          //           "Cancel",
                          //           style: TextStyle(
                          //               color: Colors.white, fontSize: 20),
                          //         ),
                          //         onPressed: () => Navigator.pop(context),
                          //         color: Colors.red,
                          //       )
                          //     ],
                          //   ).show(),
                          // },
                          func2: () =>
                              {_incomeRef.child(snapshot.key).remove()},
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
