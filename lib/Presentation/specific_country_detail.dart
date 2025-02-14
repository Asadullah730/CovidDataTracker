import 'package:cronavirus/common/Widgets/reuseableRow.dart';
import 'package:flutter/material.dart';

class ShowCountryDetails extends StatelessWidget {
  final String name;
  final String image;
  final int totalcase,
      total_recovered,
      total_death,
      total_population,
      tests,
      active,
      critical;

  ShowCountryDetails({
    required this.name,
    required this.totalcase,
    required this.image,
    required this.total_recovered,
    required this.total_death,
    required this.total_population,
    required this.tests,
    required this.active,
    required this.critical,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 29, 29),
      appBar: AppBar(
        title: Text(
          name,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 31, 29, 29),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.04), // Adjusted spacing
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: screenHeight * 0.08),
                    padding: EdgeInsets.only(top: screenHeight * 0.08),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 44, 42, 42),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Reuseablerow(
                              title: 'Total Population',
                              value: total_population.toString()),
                          Reuseablerow(
                              title: 'Report Cases',
                              value: totalcase.toString()),
                          Reuseablerow(
                              title: 'Total Recovered',
                              value: total_recovered.toString()),
                          Reuseablerow(
                              title: 'Total Death',
                              value: total_death.toString()),
                          Reuseablerow(
                              title: 'Active Cases', value: active.toString()),
                          Reuseablerow(
                              title: 'Tests Conducted',
                              value: tests.toString()),
                          Reuseablerow(
                              title: 'Critical Persons',
                              value: critical.toString()),
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(image),
                    maxRadius: screenWidth * 0.15,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
