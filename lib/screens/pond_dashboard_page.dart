import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mobile_app/screens/Dashboard.dart';
import 'water_quality_details.dart';
import 'start_screen.dart';

class PondDashboardPage extends StatefulWidget {
  const PondDashboardPage({super.key});

  @override
  State<PondDashboardPage> createState() => _PondDashboardPageState();
}

//This screen is created as a stateful widget as sensor data updates in real time

class _PondDashboardPageState extends State<PondDashboardPage> {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref("sensorReadings/pond1"); //Reference to Firebase realtime database path for pond 1 sensor readings

  double temperature = 0.0;
  double pH = 0.0;
  String waterLevel = "Unknown";

  @override
  void initState() {
    super.initState();
    _listenToLatestReading();
  }

  void _listenToLatestReading() {
    _dbRef
        .orderByChild("epoch")
        .limitToLast(1)
        .onValue
        .listen((event) {
      if (event.snapshot.value != null) {
        final rawData = event.snapshot.value as Map;
        final data = rawData.map(
          (key, value) => MapEntry(key.toString(), Map<String, dynamic>.from(value)),
        );
        final latest = data.values.first;

        setState(() {
          temperature = (latest["temperature"] ?? 0).toDouble();
          pH = (latest["pH"] ?? 0).toDouble();
          waterLevel = (latest["waterLevel"] ?? "Unknown").toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      bottomNavigationBar: BottomAppBar(
        elevation: 8,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(context, Icons.home, "Home", () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardScreen(),
                  ),
                      (route) => false,
                );
              }),
              _navItem(context, Icons.notifications, "Alerts", () {
                // TODO: Navigate to Notifications
              }),
              _navItem(context, Icons.settings, "Settings", () {
                // TODO: Navigate to Settings
              }),
              _navItem(context, Icons.logout, "Logout", () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StartScreen(),
                  ),
                  (route) => false,
                );
              }),
            ],
          ),
        ),
      ),
      body: Column(
        children: [

          /// 🔵 BLUE HEADER SECTION
          Container(
            padding: const EdgeInsets.only(
                top: 60, left: 24, right: 24, bottom: 30),
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1565C0),
                  Color(0xFF1E88E5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Pond A1",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "East-Side Stock",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.circle,
                                size: 10,
                                color: Colors.greenAccent),
                            SizedBox(width: 6),
                            Text(
                              "Active",
                              style: TextStyle(
                                  color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// ⚪ WHITE CONTENT AREA
          Expanded(
            child: Container(
              width: double.infinity,
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
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    /// 🔹 STATUS CARD
                    _buildCard(
                      child: Column(
                        children: [
                          _infoRow(Icons.access_time,
                              "Last Fed", "12:36 pm"),
                          const SizedBox(height: 14),
                          _infoRow(Icons.calendar_today,
                              "Stocked On", "12 Aug 2024"),
                          const SizedBox(height: 14),
                          _infoRow(Icons.grass,
                              "Feed Type", "Pellets"),

                          const Divider(height: 30),

                          Row(
                            children: const [
                              Icon(Icons.set_meal,
                                  size: 48,
                                  color: Colors.blue),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tilapia",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "1500 Fish",
                                    style: TextStyle(
                                      color:
                                      Colors.black54,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// 🔹 WATER QUALITY
                    const Text(
                      "Water Quality",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        _MiniStatCard(
                            title: "Temperature",
                            value: "${temperature.toStringAsFixed(1)}°C",
                            icon: Icons.thermostat_outlined),
                        _MiniStatCard(
                            title: "pH Level",
                            value: pH.toStringAsFixed(1),
                            icon: Icons.water_drop),
                        const _MiniStatCard(
                            title: "Oxygen",
                            value: "5.6 mg/L",
                            icon: Icons.air),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: waterLevel.toLowerCase() == "low"
                            ? Colors.red.withOpacity(0.05)
                            : (waterLevel.toLowerCase() == "normal"
                                ? Colors.green.withOpacity(0.05)
                                : Colors.white),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.waves,
                            size: 36,
                            color: waterLevel.toLowerCase() == "low"
                                ? Colors.red
                                : (waterLevel.toLowerCase() == "normal"
                                    ? Colors.green
                                    : Colors.grey),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Water Level",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                waterLevel.toLowerCase() == "low"
                                    ? "Low Level"
                                    : (waterLevel.toLowerCase() == "normal"
                                        ? "Normal Level"
                                        : waterLevel),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: waterLevel.toLowerCase() == "low"
                                      ? Colors.red
                                      : (waterLevel.toLowerCase() == "normal"
                                          ? Colors.green
                                          : Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 35),

                    /// 🔹 QUICK ACTIONS
                    const Text(
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    _actionTile(
                      context,
                      icon: Icons.videocam,
                      title: "Live Camera",
                      subtitle:
                      "Monitor pond in real-time",
                      navigate: false,
                    ),

                    const SizedBox(height: 15),

                    _actionTile(
                      context,
                      icon: Icons.water,
                      title: "Water Quality",
                      subtitle:
                      "Check detailed parameters",
                      navigate: true,
                    ),

                    const SizedBox(height: 15),

                    _actionTile(
                      context,
                      icon: Icons.schedule,
                      title: "Feed Schedule",
                      subtitle: "View & manage",
                      navigate: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 CARD STYLE (Prototype Matching)
  Widget _buildCard({required Widget child}) {
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
      child: child,
    );
  }

  Widget _infoRow(
      IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon,
            color: Colors.blue.shade600, size: 20),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
                color: Colors.black54),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _actionTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required bool navigate,
      }) {
    return GestureDetector(
      onTap: () {
        if (navigate) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const WaterQualityDetails(),
            ),
          );
        }
      },
      child: _buildCard(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon,
                  color: Colors.blue.shade700),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                        color: Colors.black54),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.grey.shade700),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _MiniStatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon,
              color: Colors.blue.shade600),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54)),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}