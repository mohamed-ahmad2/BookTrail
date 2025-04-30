import 'package:book_trail/views/home_screen.dart';
import 'package:flutter/material.dart';

class LoginGuestTextbutton extends StatefulWidget {
  const LoginGuestTextbutton({super.key});

  @override
  State<LoginGuestTextbutton> createState() => _LoginGuestTextbuttonState();
}

class _LoginGuestTextbuttonState extends State<LoginGuestTextbutton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Open a custom animated dialog
        showGeneralDialog(
          context: context,
          barrierDismissible:
              true, // Allow dismissing the dialog by tapping outside
          barrierLabel:
              'GuestLogin', // Label for the barrier (not critical here)

          pageBuilder: (context, animation, secondaryAnimation) {
            // We must return a widget here even if it's empty
            return const SizedBox();
          },

          transitionBuilder: (context, animation, secondaryAnimation, child) {
            // Create a smooth curved animation
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut, // Smooth start and end
            );
            // Combine FadeTransition and SlideTransition for the dialog appearance
            return FadeTransition(
              opacity: curvedAnimation, // Control opacity (fade in)
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.3), // Start slightly from above
                  end: Offset.zero, // End at the normal position
                ).animate(curvedAnimation),
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  backgroundColor: const Color.fromARGB(255, 230, 229, 229),
                  title: Column(
                    children: [
                      Icon(
                        Icons.help_outline, // Question mark icon
                        color: Colors.blueAccent,
                        size: 50,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Confirmation', // Dialog title
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  content: const Text(
                    'Are you sure you want to continue as a guest?', // Dialog message
                    textAlign: TextAlign.center,
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    // "No" button
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                    // "Yes" button
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              tabController: TabController(length: 4, vsync: Navigator.of(context)),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          transitionDuration: const Duration(
            milliseconds: 400,
          ), // Animation duration
        );
      },
      child: Text(
        'Continue as Guest',
        style: TextStyle(
          color: Colors.blueAccent,
          fontSize: 16,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
