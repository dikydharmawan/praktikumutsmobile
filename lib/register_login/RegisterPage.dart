import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'User_model.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height, // Ensure full height
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: _buildInputDecoration('Nama Depan'),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Nama depan harus diisi';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: _buildInputDecoration('Nama Belakang'),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Nama belakang harus diisi';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: _buildInputDecoration('Email'),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Email harus diisi';
                      }
                      if (!UserAuth.isEmailValid(value!)) {
                        return 'Format email tidak valid';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: _buildInputDecoration('Password'),
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Password harus diisi';
                      }
                      if (!UserAuth.isPasswordValid(value!)) {
                        return 'Password minimal 8 karakter, mengandung huruf besar, huruf kecil, dan angka';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                    ),
                    onPressed: _handleRegister,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person_add, color: Colors.white),
                        SizedBox(width: 10),
                        Text('Daftar',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                 RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(text: 'Sudah punya akun '),
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.pushReplacementNamed(context, '/register');
                        },
                      ),
                    ],
                  ),
                ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white),
      filled: true,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40.0),
        borderSide: BorderSide(color: Colors.white54, width: 2.0),
      ),
    );
  }

  void _handleRegister() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final newUser = UserModel(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );
        
        UserAuth.registerUser(newUser);
        
        // Show success dialog
        _showSuccessDialog();
        
        // Wait for the dialog to close before navigating
        await Future.delayed(Duration(seconds: 2)); // Optional delay for user to see the dialog
        Navigator.pushReplacementNamed(context, '/');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 20),
              Text('Registrasi berhasil! Silakan login',
                  textAlign: TextAlign.center),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
