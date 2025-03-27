import 'package:flutter/material.dart';
import 'package:sundial/routes/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sundial/utils/global_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  final _currentUser = FirebaseAuth.instance.currentUser;

  void _logout() async {
    try {
      EasyLoading.show(status: 'Logging out...');
      if (_currentUser != null) {
        await FirebaseAuth.instance.signOut();
      }

      GoogleSignIn googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }

      GlobalKeys.navigatorKey.currentState!.pushNamedAndRemoveUntil(
        Routes.LOGIN,
        (_) => false,
      );
    } catch (e) {
      debugPrint("Logout Error: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              // Profile Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Name & Email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentUser?.displayName ?? 'NA',
                          style: GoogleFonts.bonaNova(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _currentUser?.email ?? 'NA',
                          style: GoogleFonts.bonaNova(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),

                    // Profile Icon
                    const Icon(
                      Icons.person_outline_rounded,
                      size: 40,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _logout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
