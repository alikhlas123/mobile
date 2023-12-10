import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendor_banjari/service/FirebaseAuth.dart';
import 'package:vendor_banjari/Login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _alamatController.dispose();
    _noHpController.dispose();
    super.dispose();
  }

  void register() async {
    String nama = _namaController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String alamat = _alamatController.text;
    String noHp = _noHpController.text;

    User? user = await _authService.signUpWithEmailandPassword(
      email,
      password,
      nama,
      alamat,
      noHp,
      context,
    );

    if (user != null) {
      // Store user details in Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'username':
            email, // You can replace this with the actual username logic
        'nama': nama,
        'alamat': alamat,
        'noHp': noHp,
        'profileImageUrl': '', // Initialize with an empty string or default URL
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User is Successfully created"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Can not create user"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/rob-simmons-yYh5hf9atNw-unsplash.webp'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 90.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Register",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    _buildTextField(_namaController, Icons.person, "Nama"),
                    const SizedBox(
                      height: 12.0,
                    ),
                    _buildTextField(
                        _emailController, Icons.email, "Email Address"),
                    const SizedBox(
                      height: 12.0,
                    ),
                    _buildTextField(_passwordController, Icons.lock, "Password",
                        obscureText: true),
                    const SizedBox(
                      height: 12.0,
                    ),
                    _buildTextField(
                        _alamatController, Icons.location_on, "Alamat"),
                    const SizedBox(
                      height: 12.0,
                    ),
                    _buildTextField(
                        _noHpController, Icons.phone_android, "No.HP"),
                    const SizedBox(
                      height: 20.0,
                    ),
                    _buildElevatedButton("Sign up", Colors.amber, () {
                      register();
                    }),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 8.0),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                          },
                          child: const Text(
                            "Login.",
                            style: TextStyle(color: Colors.amber, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, IconData icon, String hintText,
      {bool obscureText = false}) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildElevatedButton(
      String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      height: 55,
      width: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
