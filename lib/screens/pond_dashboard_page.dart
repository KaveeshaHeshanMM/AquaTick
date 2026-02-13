import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'water_quality_details.dart';
import '../widgets/app_gradient_background.dart';

class PondDashboardPage extends StatelessWidget {
  const PondDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppGradientBackground(
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
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "East-Side Stock",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [

                        Image.asset(
                          'assets/aquatick_logo2.png',
                          color: Colors.white,
                          height: 40,
                        ),

                        const SizedBox(width: 15),

                        IconButton(
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            final confirm = await showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Confirm Logout"),
                                content: const Text(
                                    "Are you sure you want to log out?"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text("Logout"),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await FirebaseAuth.instance.signOut();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 STATUS CARD
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green.shade400,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "ACTIVE",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 15),

                    const Text("Fed At : 12:36 pm"),
                    const Text("Stocked 12 Aug 2024"),
                    const Text("Feed Type : Pellets"),

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
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("1500 Fish"),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 30),

              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text(
                  "Edit Details",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 20),

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
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}