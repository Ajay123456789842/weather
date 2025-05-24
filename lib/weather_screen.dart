import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherapp/authprovider.dart';
import 'package:weatherapp/reusablewidget.dart';
import 'package:weatherapp/service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    WeatherService.apiWeatherResponse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
            icon: Icon(Icons.logout_outlined),
          ),
          SizedBox(width: 10),
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: WeatherService.apiWeatherResponse(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            final wm = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    //height: 200,
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(),
                      color: const Color.fromARGB(109, 158, 158, 158),
                      elevation: 10,
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                        children: [
                          Text(
                            wm.temp[0].toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),

                          SizedBox(
                            height: 100,
                            width: 100,
                            child: WeatherService().getWeatherCondition(
                              wm.weathertype[0],
                            ),
                          ),
                          // Icon(
                          //   wm.weathertype[0] == 'Rain'
                          //       ? WeatherIcons.rain_mix
                          //       : wm.weathertype[0] == 'Clouds'
                          //       ? Icons.cloud
                          //       : Icons.sunny,
                          //   size: 60,
                          // ),
                          const SizedBox(height: 10),
                          Text(
                            wm.weathertype[0],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Weather forecast',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 132.h,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: wm.time.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          clipBehavior: Clip.hardEdge,
                          shape: OutlineInputBorder(),
                          color: const Color.fromARGB(109, 158, 158, 158),
                          elevation: 6,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  DateFormat().add_j().format(
                                    DateTime.parse(wm.time[i]),
                                  ),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),

                                SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: WeatherService().getWeatherCondition(
                                    wm.weathertype[i],
                                  ),
                                ),

                                // Icon(
                                //   wm.weathertype[i] == 'Rain'
                                //       ? WeatherIcons.rain_mix
                                //       : wm.weathertype[i] == 'Clouds'
                                //       ? Icons.cloud
                                //       : Icons.sunny,
                                //   size: 25,
                                // ),
                                Text(
                                  wm.temp[i].toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Additional Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalDetails(
                      icon: Icons.water_drop,
                      text: 'Humidity',
                      val: double.parse(wm.humidity.toString()),
                    ),
                    AdditionalDetails(
                      icon: Icons.wind_power,
                      text: 'wind speed',
                      val: double.parse(wm.windspeed.toString()),
                    ),
                    AdditionalDetails(
                      icon: Icons.umbrella_sharp,
                      text: 'pressure',
                      val: double.parse(wm.pressure.toString()),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
