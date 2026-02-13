import 'package:flutter/material.dart';
import '../widgets/app_gradient_background.dart';

class WaterQualityDetails extends StatelessWidget {
  const WaterQualityDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppGradientBackground(
        child: Stack(
          children: [

            // 🔹 Decorative Purple Shape
            Positioned(
              top: 240,
              left: -70,
              child: Container(
                width: 260,
                height: 300,
                decoration: BoxDecoration(
                  color: const Color(0xFF5E6DD1).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),

            SingleChildScrollView(
              child: Column(
                children: [

                  const SizedBox(height: 40),

                  // 🔹 TOP SECTION
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // Back Button
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Back",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Water Quality",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Pond A1",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),

                            Image.asset(
                              'assets/aquatick_logo2.png',
                              color: Colors.white,
                              height: 50,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // 🔹 Temperature + PH Cards
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        Expanded(
                          child: _smallCard(
                            value: "28°C",
                            icon: Icons.thermostat,
                            iconColor: Colors.red,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _smallCard(
                            value: "7.5",
                            icon: Icons.science,
                            iconColor: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔹 Oxygen Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: _oxygenCard(),
                  ),

                  const SizedBox(height: 30),

                  // 🔹 Sensor Status
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Sensor Status",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Padding(
                    padding: EdgeInsets.only(left: 55),
                    child: Text(
                      "Temperature\npH\nDissolved Oxygen",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        height: 1.8,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 🔹 Recent Readings Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [

                          Text(
                            "Recent Readings",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 15),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Temp 28°C | pH 7.5\nDO: 6.6 mg/L",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Text("10:45 AM"),
                            ],
                          ),

                          SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Temp 25°C | pH 7.5\nDO: 7.1 mg/L",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Text("10:30 AM"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  const Icon(
                    Icons.keyboard_arrow_up,
                    size: 40,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _smallCard({
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: iconColor),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text("NORMAL"),
          ),
        ],
      ),
    );
  }

  Widget _oxygenCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.bubble_chart, size: 35, color: Colors.blue),
              SizedBox(width: 15),
              Text(
                "6.6 mg / L",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Center(
            child: Container(
              padding:
              EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFFF4C542),
                borderRadius:
                BorderRadius.all(Radius.circular(20)),
              ),
              child: Text("NORMAL"),
            ),
          ),
        ],
      ),
    );
  }
}