import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/img_constants.dart';
import '../provider/weather_provider.dart';

var height;
var width;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _clicked = false;
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    // Access the WeatherProvider once
    final weatherProvider = Provider.of<WeatherProvider>(context);

     String bg = ImgConstants.cloudy;
     String icon = ImgConstants.sun;

    if (weatherProvider.weatherData != null) {
      String description = weatherProvider.weatherData!['weather'][0]['description'];
      if (description == "clear sky") {
        bg = ImgConstants.clear_sky;
        String icon = ImgConstants.clear_sky;
      } else if (description == "broken clouds") {
        bg = ImgConstants.broken_clouds;
        String icon = ImgConstants.overcast_cloud_icon;
      } else if (description == "light rain") {
        bg = ImgConstants.moderate_rain;
        String icon = ImgConstants.moderate_rain_icon;
      } else if (description == "cloudy sky") {
        bg = ImgConstants.cloudy_sky;
        String icon = ImgConstants.few_cloud_icon;
      } else if (description == "few clouds") {
        bg = ImgConstants.few_clouds;
        bg = ImgConstants.few_cloud_icon;
      } else if (description == "moderate rain") {
        bg = ImgConstants.moderate_rain;
        String icon = ImgConstants.moderate_rain_icon;
      } else if (description == "overcast clouds") {
        bg = ImgConstants.overcast_clouds;
        String icon = ImgConstants.overcast_cloud_icon;
      } else if (description == "scattered clouds") {
        bg = ImgConstants.scattered_clouds;
        String icon = ImgConstants.scattered_cloud_icon;
      }
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: height * 0.1),
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(bg),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.red),
                        SizedBox(width: width * 0.03),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              weatherProvider.weatherData != null
                                  ? weatherProvider.weatherData!['name'] as String
                                  : "Location",
                              style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              weatherProvider.weatherData != null
                                  ? DateTime.fromMillisecondsSinceEpoch(
                                  weatherProvider.weatherData!['dt'] * 1000)
                                  .toLocal()
                                  .toString()
                                  .split(' ')[0] // Format the date as needed
                                  : "Date",
                              style: TextStyle(
                                fontSize: width * 0.025,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _clicked = !_clicked;
                        });
                      },
                    )
                  ],
                ),
                _clicked
                    ? Padding(
                  padding: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
                  child: TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(
                      hintText: "location",
                      hintStyle: TextStyle(color: Colors.black.withOpacity(0.45)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                    cursorColor: Colors.white,
                    onFieldSubmitted: (value) {
                      weatherProvider.fetchWeather(value);
                    },
                  ),
                )
                    : SizedBox(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(icon, height: height * 0.125),
                Text(
                  weatherProvider.weatherData != null
                      ? "${weatherProvider.weatherData!['main']['temp']} °C"
                      : "Temperature",
                  style: TextStyle(
                      fontSize: width * 0.075,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                Text(
                  weatherProvider.weatherData != null
                      ? weatherProvider.weatherData!['weather'][0]['description']
                      : "Condition",
                  style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                Text(
                  "${DateTime.now()}",
                  style: TextStyle(
                      fontSize: width * 0.03,
                      color: Colors.white),
                ),
              ],
            ),
            Container(
              width: width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(width * 0.02)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: height * 0.08,
                        width: width * 0.275,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(ImgConstants.temp_max, height: height * 0.05),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Temp max",
                                    style: TextStyle(
                                        fontSize: width * 0.015,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    weatherProvider.weatherData != null
                                        ? "${weatherProvider.weatherData!['main']['temp_max']} °C"
                                        : "N/A",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: width * 0.035,
                                        color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: height * 0.08,
                        width: width * 0.275,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(ImgConstants.temp_min, height: height * 0.05),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Temp min",
                                    style: TextStyle(
                                        fontSize: width * 0.015,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    weatherProvider.weatherData != null
                                        ? "${weatherProvider.weatherData!['main']['temp_min']} °C"
                                        : "N/A",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: width * 0.035,
                                        color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: width * 0.005,
                    endIndent: width * 0.2,
                    indent: width * 0.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: height * 0.08,
                        width: width * 0.275,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.sunny, color: Colors.orange),
                              SizedBox(width: width * 0.025),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    weatherProvider.weatherData != null
                                        ? "${DateTime.fromMillisecondsSinceEpoch(weatherProvider.weatherData!['sys']['sunrise'] * 1000).toLocal().hour}:${DateTime.fromMillisecondsSinceEpoch(weatherProvider.weatherData!['sys']['sunrise'] * 1000).toLocal().minute}"
                                        : "N/A",
                                    style: TextStyle(
                                        fontSize: width * 0.015,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "21 °C",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: width * 0.035,
                                        color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: height * 0.08,
                        width: width * 0.275,
                        child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Icon(Icons.nightlight_rounded, color: Colors.yellowAccent),
                          SizedBox(width: width * 0.025),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sunset",
                                style: TextStyle(
                                    fontSize: width * 0.015,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              ),
                              Text(
                                weatherProvider.weatherData != null
                                    ? "${DateTime.fromMillisecondsSinceEpoch(weatherProvider.weatherData!['sys']['sunset'] * 1000).toLocal().hour}:${DateTime.fromMillisecondsSinceEpoch(weatherProvider.weatherData!['sys']['sunset'] * 1000).toLocal().minute}"
                                    : "N/A",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: width * 0.035,
                                    color: Colors.white),
                              ),
                            ],
                          )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.2)
          ],
        ),
      ),
    );
  }
}