import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../state_management/login_notifier.dart';
import '../state_management/login_state.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginNotifier = Provider.of<LoginNotifier>(context);

    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController rollNumberController = TextEditingController();
    final TextEditingController schoolCodeController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF00A651),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.30,
          height: MediaQuery.of(context).size.height * 0.96,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 50,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 195,
                    width: 344,
                    child: Image.asset(
                      'assets/login.png', // Replace with your logo
                      fit: BoxFit.contain,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Welcome ",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E1E1E),
                          ),
                        ),
                        TextSpan(
                          text: "Student",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF00A455),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Please enter your sign in details.",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: const Color(0xFF979797),
                    ),
                  ),
                  const SizedBox(height: 5),
                  buildTextField("Full Name", fullNameController),
                  buildTextField("Roll Number", rollNumberController),
                  buildTextField("School Code", schoolCodeController),
                  buildTextField("Password", passwordController,
                      isPassword: true),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      loginNotifier.login(
                        fullNameController.text,
                        rollNumberController.text,
                        schoolCodeController.text,
                        passwordController.text,
                        context,
                      );
                    },
                    child: const Text("Sign In"),
                  ),
                  const SizedBox(height: 20),
                  if (loginNotifier.state is LoginLoading)
                    const CircularProgressIndicator(),
                  if (loginNotifier.state is LoginFailure)
                    Text(
                      (loginNotifier.state as LoginFailure).error,
                      style: const TextStyle(color: Colors.red),
                    ),
                  if (loginNotifier.state is LoginSuccess)
                    Text(
                      (loginNotifier.state as LoginSuccess).message,
                      style: const TextStyle(color: Colors.green),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: 303,
        child: TextFormField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: isPassword ? const Icon(Icons.visibility_off) : null,
          ),
        ),
      ),
    );
  }
}
