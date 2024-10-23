import 'package:flutter/material.dart';
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

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      height: MediaQuery.of(context).size.height * 0.95,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Input Fields
              buildTextField("Full Name", fullNameController),
              buildTextField("Roll Number", rollNumberController),
              buildTextField("School Code", schoolCodeController),
              buildTextField("Password", passwordController, isPassword: true),

              const SizedBox(height: 20),

              // Sign In Button
              ElevatedButton(
                onPressed: () {
                  loginNotifier.login(
                    fullNameController.text,
                    rollNumberController.text,
                    schoolCodeController.text,
                    passwordController.text,
                  );
                },
                child: const Text("Sign In"),
              ),

              const SizedBox(height: 20),

              // Loading Indicator or Error Message
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
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
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
    );
  }
}
