import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController rollNumberController = TextEditingController();
  final TextEditingController schoolCodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Diagonal background
          Positioned.fill(
            child: ClipPath(
              clipper: DiagonalClipper(),
              child: Container(
                color: Colors.green,
              ),
            ),
          ),
          // Centered login form
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: LoginForm(
                fullNameController: fullNameController,
                rollNumberController: rollNumberController,
                schoolCodeController: schoolCodeController,
                passwordController: passwordController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController rollNumberController;
  final TextEditingController schoolCodeController;
  final TextEditingController passwordController;

  const LoginForm({
    Key? key,
    required this.fullNameController,
    required this.rollNumberController,
    required this.schoolCodeController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              // Image
              Container(
                width: 280,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/login_upper_image.png'),
                    fit: BoxFit.cover, // Adjust image fit
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Welcome Text
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Welcome ",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E1E1E), // Color for "Welcome"
                      ),
                    ),
                    TextSpan(
                      text: "Student",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF00A455), // Color for "Student"
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                "Please enter your sign in details.",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, // Medium
                  fontSize: 18, // Font size
                  color:
                      const Color(0xFF979797), // Text color (hex for #F4F4F7)
                ),
              ),
              const SizedBox(height: 20),

              // Input Fields
              buildTextField("Full Name", fullNameController),
              buildTextField("Roll Number", rollNumberController),
              buildTextField("School Code", schoolCodeController),
              buildTextField("Password", passwordController, isPassword: true),

              const SizedBox(height: 20),

              // Sign In Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardPage()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Text(
                    "Sign In",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, // Semibold
                      fontSize: 17, // Font size
                      color: const Color(
                          0xFFF4F4F7), // Text color (hex for #F4F4F7)
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF052652), // Button color
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),

              const SizedBox(height: 20),

              // Footer Text
              Text(
                "Get ready to test your skills!",
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.italic, // Italic style
                  fontWeight: FontWeight.bold, // Bold style
                  fontSize: 30, // Font size 30
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable text field widget
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
          suffixIcon: isPassword
              ? const Icon(Icons.visibility_off) // Hide/show password icon
              : null,
        ),
      ),
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
