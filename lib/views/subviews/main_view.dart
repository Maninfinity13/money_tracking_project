import 'package:flutter/material.dart';
import 'package:money_tracking_project/models/money.dart';
import 'package:money_tracking_project/models/user.dart';
import 'package:money_tracking_project/services/call_api.dart';
import 'package:money_tracking_project/services/provider.dart';
import 'package:money_tracking_project/utils/env.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  final User user;
  const MainView({Key? key, required this.user}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  Future<List<Money>>? moneyData;

  getMoneyDetailList(Money money) {
    setState(() {
      moneyData = CallAPI.callGetMoneyDetailListAPI(money);
    });
  }

  @override
  void initState() {
    Money money = Money(
      userId: widget.user.userId,
    );
    getMoneyDetailList(money);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 60, 140, 134),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.all(20.0),
            child: SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.user.userFullname}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: widget.user.userImage != null &&
                              widget.user.userImage!.isNotEmpty
                          ? NetworkImage(
                              '${Env.hostName}/moneytracking/picupload/userImage/${widget.user.userImage}')
                          : AssetImage('assets/images/person.png')
                              as ImageProvider,
                      onBackgroundImageError: (exception, stackTrace) {
                        print('Error loading image: $exception');
                      },
                      backgroundColor: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.175,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 57, 126, 121),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10,
                        offset: Offset(0, 0.5),
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: FutureBuilder<List<Money>>(
                    future: moneyData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      } else if (snapshot.hasData) {
                        final moneyList = snapshot.data ?? [];
                        final totalIn = moneyList
                            .where((money) => money.moneyType == '1')
                            .fold(
                                0.0,
                                (sum, item) =>
                                    sum + double.parse(item.moneyInOut!));
                        final totalOut = moneyList
                            .where((money) => money.moneyType == '2')
                            .fold(
                                0.0,
                                (sum, item) =>
                                    sum + double.parse(item.moneyInOut!));

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Provider.of<BalanceProvider>(context, listen: false)
                              .updateBalance(totalIn, totalOut);
                        });

                        return Column(
                          children: [
                            Text(
                              "ยอดเงินคงเหลือ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              (totalIn - totalOut).toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "ยอดเงินเข้ารวม",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      totalIn.toStringAsFixed(2),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("ยอดเงินออกรวม",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        )),
                                    SizedBox(height: 5),
                                    Text(totalOut.toStringAsFixed(2),
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ],
                            )
                          ],
                        );
                      } else {
                        return Center(child: Text("ยังไม่มีข้อมูล"));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.475,
              ),
              Text(
                "เงินเข้า/เงินออก",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Money>>(
                  future: moneyData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data![0].message == "0") {
                        return Text("ยังไม่มีพบข้อมูล");
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Divider(),
                                ListTile(
                                  onTap: () {},
                                  leading: Icon(
                                    snapshot.data![index].moneyType! == '1'
                                        ? Icons.arrow_circle_up
                                        : Icons.arrow_circle_down,
                                    color:
                                        snapshot.data![index].moneyType! == '1'
                                            ? Colors.green
                                            : Colors.red,
                                  ),
                                  title: Text(
                                    snapshot.data![index].moneyDetail!,
                                  ),
                                  subtitle: Text(
                                    '${snapshot.data![index].moneyDate!}',
                                  ),
                                  trailing: Text(
                                    '${snapshot.data![index].moneyType! == '1' ? '+' : '-'}${snapshot.data![index].moneyInOut!}',
                                    style: TextStyle(
                                      color: snapshot.data![index].moneyType! ==
                                              '1'
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
