import 'package:cronavirus/Presentation/specific_country_detail.dart';
import 'package:cronavirus/Services/statsApis.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  CountriesListScreen({super.key});

  @override
  _CountriesListScreenState createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen>
    with TickerProviderStateMixin {
  TextEditingController _countriesController = TextEditingController();
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1500))
    ..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 29, 29),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 31, 29, 29),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Search Text Field
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _countriesController,
                onChanged: (val) {
                  setState(() {});
                },
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Search Country by Name",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    )),
              ),
            ),
            //  Showing the Countries
            Expanded(
              child: FutureBuilder(
                future: Statsapis().fetchAffectedCountries(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 10, // Placeholder count for shimmer
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[700]!,
                          highlightColor: Colors.grey[500]!,
                          child: ListTile(
                            title: Container(
                              height: 20,
                              width: double.infinity, // Set width to be visible
                              color: Colors.white, // Placeholder color
                            ),
                            subtitle: Container(
                              height: 10,
                              width: 100, // Set width for visibility
                              color: Colors.white,
                            ),
                            leading: Container(
                              width: 50,
                              height: 50,
                              color: Colors.white, // Placeholder for flag
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var country = snapshot.data![index];
                        var flagUrl = country['countryInfo']['flag'] ?? '';

                        if (kDebugMode) {
                          print('Flag URL: $flagUrl');
                        }
                        String name = country['country'];

                        if (_countriesController.text.isEmpty) {
                          return GestureDetector(
                            onTap: () => Get.to(
                              () => ShowCountryDetails(
                                name: country['country'],
                                active: country['active'],
                                critical: country['critical'],
                                tests: country['tests'],
                                total_death: country['deaths'],
                                total_population: country['population'],
                                total_recovered: country['recovered'],
                                totalcase: country['cases'],
                                image: flagUrl,
                              ),
                            ),
                            child: ListTile(
                              title: Text(
                                country['country'] ?? 'Unknown',
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                snapshot.data![index]['cases']?.toString() ??
                                    'Unknown',
                                style: const TextStyle(color: Colors.white),
                              ),
                              leading: Image.network(
                                flagUrl,
                                width: 50,
                                height: 50,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error,
                                      color: Colors.red);
                                },
                              ),
                            ),
                          );
                        } else if (name.toLowerCase().contains(
                            _countriesController.text.toLowerCase())) {
                          return GestureDetector(
                            onTap: () => Get.to(
                              () => ShowCountryDetails(
                                name: country['country'],
                                active: country['active'],
                                critical: country['critical'],
                                tests: country['tests'],
                                total_death: country['deaths'],
                                total_population: country['population'],
                                total_recovered: country['recovered'],
                                totalcase: country['cases'],
                                image: flagUrl,
                              ),
                            ),
                            child: ListTile(
                              title: Text(
                                country['country'] ?? 'Unknown',
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                snapshot.data![index]['cases']?.toString() ??
                                    'Unknown',
                                style: const TextStyle(color: Colors.white),
                              ),
                              leading: Image.network(
                                flagUrl,
                                width: 50,
                                height: 50,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error,
                                      color: Colors.red);
                                },
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
