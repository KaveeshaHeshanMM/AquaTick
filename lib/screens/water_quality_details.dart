import 'package:flutter/material.dart';
import '../widgets/app_gradient_background.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';

class WaterQualityDetails extends StatefulWidget { // created as a stateful widget because readings update in real-time
  const WaterQualityDetails({super.key});

  @override
  State<WaterQualityDetails> createState() => _WaterQualityDetailsState();
}

class _WaterQualityDetailsState extends State<WaterQualityDetails> {

  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref("sensorReadings/pond1"); // connects to firebase and reads data from sensorReadings/pond1
                                                              // hardcoded to pond1 for MVP

  double currentTemp = 0;   // stores latest temperature value
  double currentPH = 0;     // stores latest pH value

  List<FlSpot> tempSpots = []; // store graph data points for last 5 readings
  List<FlSpot> phSpots = [];

  @override
  void initState() {

    // called when screen is loaded
    // initiates loading of historical sensor readings

    super.initState();
    _loadHistory();
  }

  void _loadHistory() {
    _dbRef

        // retrieves last 5 sensor readings ordered by timestamp
        // listens to real time updates from firebase

        .orderByChild("epoch")
        .limitToLast(5)
        .onValue
        .listen((event) {
      if (event.snapshot.value != null) {

        // converts Firebase snapshot into a usable Map structure

        final raw = event.snapshot.value as Map;
        final data = raw.map((key, value) =>
            MapEntry(key.toString(), Map<String, dynamic>.from(value)));

        List<FlSpot> tempList = [];
        List<FlSpot> phList = [];

        for (var reading in data.values) {

          // iterates through each reading and extracts temperature and pH values
          // converts them into FlSpot points for graph plotting

          final t = (reading["temperature"] ?? 0).toDouble();
          final p = (reading["pH"] ?? 0).toDouble();
          final epoch = (reading["epoch"] ?? 0).toDouble();

          tempList.add(FlSpot(epoch, t));
          phList.add(FlSpot(epoch, p));
        }

        tempList.sort((a, b) => a.x.compareTo(b.x));  // sorts temp readings chronologically based on timestamp
        phList.sort((a, b) => a.x.compareTo(b.x));    // sorts pH readings chronologically based on timestamp

        List<FlSpot> normalizedTemp = [];
        List<FlSpot> normalizedPH = [];

        for (int i = 0; i < tempList.length; i++) {
          normalizedTemp.add(FlSpot(i.toDouble(), tempList[i].y)); // normalizes X-axis values to 0-4 for cleaner graph display
        }

        for (int i = 0; i < phList.length; i++) {
          normalizedPH.add(FlSpot(i.toDouble(), phList[i].y));
        }

        setState(() {

          // updates UI with latest graph data and current parameter values

          tempSpots = normalizedTemp;
          phSpots = normalizedPH;

          if (tempList.isNotEmpty) {
            currentTemp = tempList.last.y;
          }
          if (phList.isNotEmpty) {
            currentPH = phList.last.y;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      body: Column(
        children: [
          Container(

            // header section with blue gradient

            width: double.infinity,
            padding: const EdgeInsets.only(
                top: 60, left: 24, right: 24, bottom: 40),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1565C0),
                  Color(0xFF1E88E5),
                ],
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back,
                      color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Water Quality Details",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFF8FAFC),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    _parameterCard(
                      title: "Temperature",
                      value: "${currentTemp.toStringAsFixed(1)}°C",
                      spots: tempSpots,
                      color: Colors.red,
                    ),

                    const SizedBox(height: 25),

                    _parameterCard(
                      title: "pH Level",
                      value: currentPH.toStringAsFixed(1),
                      spots: phSpots,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _parameterCard({

    // reusable widget for title, current value and the line graph

    required String title,
    required String value,
    required List<FlSpot> spots,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: color),
          ),
          const SizedBox(height: 20),
          spots.isEmpty
              ? const SizedBox(
                  height: 180,
                  child: Center(child: Text("No data available")),
                )
              : SizedBox(
                  height: 180,
                  child: LineChart(

                    // this configures the axis ranges, axis titles, grid lines, border and line style
                    
                    LineChartData(
                      minX: 0,
                      maxX: 4,
                      minY: title == "Temperature" ? 0 : 0,
                      maxY: title == "Temperature" ? 50 : 14,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                      ),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              if (value < 0 || value > 4) {
                                return const SizedBox();
                              }
                              return Text(
                                'R${value.toInt() + 1}',
                                style: const TextStyle(fontSize: 10),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            interval: title == "Temperature" ? 5 : 1,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toStringAsFixed(0),
                                style: const TextStyle(fontSize: 10),
                              );
                            },
                          ),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: const Border(
                          left: BorderSide(),
                          bottom: BorderSide(),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: false,
                          color: color,
                          barWidth: 3,
                          dotData: FlDotData(show: true),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}