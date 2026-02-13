import 'package:flutter/material.dart';
import 'water_quality_details.dart';

class PondDashboardPage extends StatelessWidget {
  const PondDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A73E8), // App Background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              const SizedBox(height: 80),

              // 🔹 TOP SECTION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Pond A1",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "East-Side Stock",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    Image.asset(
                      'assets/kaveesha_logo.jpeg',
                      height: 40,
                    ),

                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 STATUS CARD
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.all(12), // Card Padding
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Status",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000000),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "ACTIVE",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "Fed At : 12:36 pm",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Color(0xFF000000),
                      ),
                    ),
                    const Text(
                      "Stocked 12 Aug 2024",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Color(0xFF000000),
                      ),
                    ),
                    const Text(
                      "Feed Type : Pellets",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Color(0xFF000000),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: const [
                        Icon(Icons.set_meal, size: 40),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tilapia",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000000),
                              ),
                            ),
                            Text(
                              "1500 Fish",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                color: Color(0xFF000000),
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

              // 🔹 EDIT DETAILS
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text(
                  "Edit Details",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 BUTTONS

              _buildButton(
                title: "View Live Feed",
                context: context,
                navigate: false,
              ),

              const SizedBox(height: 20),

              _buildButton(
                title: "View Water Quality",
                context: context,
                navigate: true,
              ),

              const SizedBox(height: 20),

              _buildButton(
                title: "View Feed Schedule",
                context: context,
                navigate: false,
              ),

              const SizedBox(height: 40),

              const Icon(
                Icons.keyboard_arrow_up,
                size: 40,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 BUTTON METHOD
  Widget _buildButton({
    required String title,
    required BuildContext context,
    required bool navigate,
  }) {
    return GestureDetector(
      onTap: () {
        if (navigate) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WaterQualityDetails(),
            ),
          );
        }
      },
      child: Container(
        width: 250,
        height: 55,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF000000),
          ),
        ),
      ),
    );
  }
}
