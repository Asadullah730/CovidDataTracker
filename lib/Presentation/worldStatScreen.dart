import 'package:cronavirus/Model/wholeworldModel.dart';
import 'package:cronavirus/Presentation/contries_list.dart';
import 'package:cronavirus/Services/Utilities/app_url.dart';
import 'package:cronavirus/Services/statsApis.dart';
import 'package:cronavirus/common/Widgets/reuseableRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatScreen extends StatefulWidget {
  const WorldStatScreen({super.key});

  @override
  State<WorldStatScreen> createState() => _WorldStatScreenState();
}

class _WorldStatScreenState extends State<WorldStatScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();

  final colorList = <Color>[
    const Color.fromARGB(255, 16, 48, 123),
    const Color.fromARGB(255, 50, 118, 4),
    const Color.fromARGB(255, 204, 0, 0),
  ];

  @override
  Widget build(BuildContext context) {
    Statsapis worldstats = Statsapis();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 29, 29),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              FutureBuilder(
                future: worldstats.WorldStats(),
                builder: (context, AsyncSnapshot<WholeWorldModel> snaphot) {
                  if (!snaphot.hasData) {
                    return Expanded(
                        child: SpinKitCircle(
                      color: Colors.white,
                      controller: _controller,
                    ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snaphot.data!.cases.toString()),
                            "Recovered": double.parse(
                                snaphot.data!.recovered.toString()),
                            "Death":
                                double.parse(snaphot.data!.deaths.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                              chartValueBackgroundColor: Colors.red,
                              showChartValueBackground: false,
                              showChartValuesInPercentage: true,
                              showChartValuesOutside: false,
                              chartValueStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          chartLegendSpacing: 30,
                          colorList: colorList,
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left,
                            legendShape: BoxShape.circle,
                            legendTextStyle: TextStyle(color: Colors.white),
                          ),
                          ringStrokeWidth: 25,
                          baseChartColor: Colors.black,
                          // centerText: "Crona Tracker App",

                          chartRadius: 500,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.06),
                          child: Card(
                            color: const Color.fromARGB(255, 79, 75, 75),
                            child: Column(
                              children: [
                                Reuseablerow(
                                  title: 'Total',
                                  value: snaphot.data?.cases.toString(),
                                ),
                                Reuseablerow(
                                  title: 'Recovered',
                                  value: snaphot.data?.recovered.toString(),
                                ),
                                Reuseablerow(
                                  title: 'Death',
                                  value: snaphot.data?.deaths.toString(),
                                ),
                                Reuseablerow(
                                  title: 'Active Cases',
                                  value: snaphot.data?.active.toString(),
                                ),
                                Reuseablerow(
                                  title: 'Critical ',
                                  value: snaphot.data?.critical.toString(),
                                ),
                                Reuseablerow(
                                  title: 'Today Recoverd',
                                  value:
                                      snaphot.data?.todayRecovered.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.to(() => CountriesListScreen()),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2B6404),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Track Countries",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
