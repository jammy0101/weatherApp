import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/api_services.dart';

import '../Modals/WeatherModal.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<WeatherModal> getProductsApi()async{
    final response = await http.get(Uri.parse('https://api.weatherapi.com/v1/current.json?key=4d19a30d322c4c56b2c73339251606&q=Bannu&aqi=yes'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      print(data);
      return WeatherModal.fromJson(data);
    }else{
      return WeatherModal.fromJson(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WeatherApp'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: FutureBuilder<WeatherModal>(
            future:getProductsApi(),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }else if(snapshot.hasError){
                return Center(child: Text('Error loading weather api'));
              }else if(!snapshot.hasData){
                return Center(child: Text('No data found'));
              }

              final weather = snapshot.data!;
              final current = weather.current;
              final location = weather.location;

              return SingleChildScrollView(
                padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          elevation: 6,
                          color: Colors.lightBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Text('${location.name}, ${location.country}',style: TextStyle(fontWeight: FontWeight.bold),),
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.lightBlue,
                                  backgroundImage: NetworkImage('https:${current.condition.icon}',),
                                ),
                                Text(current.condition.text,style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(height: 8,),
                                Text('${current.tempC}°C',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                                Text('Feel Like:${current.feelslikeC}'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),

                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1,
                        mainAxisSpacing: 10,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          buildInfoList(Icons.air, 'Wind', '${current.windKph} Kph' ),
                          buildInfoList(Icons.opacity, 'humidity', '${current.humidity} ' ),
                          buildInfoList(Icons.warning, 'UV', '${current.uv}' ),
                          buildInfoList(Icons.device_thermostat, 'pressure', '${current.pressureMb} mb' ),
                          buildInfoList(Icons.air_rounded, 'Viskm', '${current.visKm} km ' ),
                          buildInfoList(Icons.ac_unit, 'feelslikeC', '${current.feelslikeC}°C' ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Wrap(
                                spacing: 2,
                                children: [
                                  airQuality("pm2_5", current.airQuality.pm2_5),
                                  airQuality("co", current.airQuality.co),
                                  airQuality("no2", current.airQuality.no2),
                                ],
                              ),
                              airQuality("o3", current.airQuality.o3),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
              );
            }
        ),
      ),
    );
  }
}


Widget buildInfoList(IconData icon ,String label, String value,){
  return SizedBox(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue.withOpacity(.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.blueGrey, size: 24),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(label,style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(value,style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
            )
          ],
        ),
      )
    ),
  );
}


Widget airQuality(String label,double value){
return Chip(
    label: Text('${label} : ${value.toStringAsFixed(1)}'),
  backgroundColor: Colors.grey.shade300,
  shape: RoundedRectangleBorder(),
);
}



// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import '../Modals/WeatherModal.dart';
// import '../services/api_services.dart'; // Make sure this is well defined
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   WeatherStates weatherStates = WeatherStates();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueGrey.shade50,
//       appBar: AppBar(
//         title: const Text('WeatherApp'),
//         centerTitle: true,
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: FutureBuilder<WeatherModal>(
//         future: weatherStates.getProductsApi(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return const Center(child: Text("Error loading weather data"));
//           } else if (!snapshot.hasData) {
//             return const Center(child: Text("No data found"));
//           }
//
//           final weather = snapshot.data!;
//           final current = weather.current;
//           final location = weather.location;
//
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               children: [
//                 // Summary Card
//                 Card(
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                   elevation: 6,
//                   color: Colors.lightBlue,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       children: [
//                         Text(
//                           '${location.name}, ${location.country}',
//                           style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 10),
//                         Image.network('https:${current.condition.icon}', width: 80),
//                         Text(
//                           current.condition.text,
//                           style: const TextStyle(fontSize: 17, color: Colors.black),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           '${current.tempC}°C',
//                           style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//                         ),
//                         Text('Feels like ${current.feelslikeC}°C'),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Grid Data
//                 GridView.count(
//                   crossAxisCount: 2,
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   childAspectRatio: 1,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                   children: [
//                     buildInfoTile(Icons.air, "Wind", "${current.windKph} kph"),
//                     buildInfoTile(Icons.opacity, "Humidity", "${current.humidity}%"),
//                     buildInfoTile(Icons.compress, "Pressure", "${current.pressureMb} mb"),
//                     buildInfoTile(Icons.thermostat, "Feels", "${current.feelslikeC}°C"),
//                     buildInfoTile(Icons.wb_sunny, "UV", "${current.uv}"),
//                     buildInfoTile(Icons.remove_red_eye, "Visibility", "${current.visKm} km"),
//                   ],
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Air Quality Section
//                 Card(
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                   elevation: 4,
//                   color: Colors.lightBlue,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text("Air Quality", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                         const SizedBox(height: 10),
//                         Wrap(
//                           spacing: 10,
//                           runSpacing: 10,
//                           children: [
//                             buildAirQualityChip("PM2.5", current.airQuality.pm2_5),
//                             buildAirQualityChip("PM10", current.airQuality.pm10),
//                             buildAirQualityChip("O₃", current.airQuality.o3),
//                             buildAirQualityChip("NO₂", current.airQuality.no2),
//                             buildAirQualityChip("CO", current.airQuality.co),
//                             buildAirQualityChip("SO₂", current.airQuality.so2),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget buildInfoTile(IconData icon, String label, String value) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width / 2 - 22, // padding + spacing
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.blue.shade100.withOpacity(0.9),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.blueGrey.shade200),
//         ),
//         padding: const EdgeInsets.all(12),
//         child: Row(
//           children: [
//             Icon(icon, color: Colors.blueGrey, size: 24),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
//                   Text(value, style: const TextStyle(fontSize: 16)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildAirQualityChip(String label, double value) {
//     return Chip(
//       label: Text('$label: ${value.toStringAsFixed(1)}'),
//       backgroundColor: Colors.blueGrey.shade100,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//     );
//   }
// }

