import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yoyo/components/my_button.dart';
import 'package:yoyo/components/my_textfield.dart';
// import 'package:yoyo/components/square_title.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  // sign user up method
  void signUserUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try creating the user
    try {
      if (passwordController.text == confirmpasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        showErrorMessage("Passwords don't match!");
      }
      // pop the loading circle
      if (mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      // print(e.code);
      // pop the loading circle
      if (mounted) {
        Navigator.pop(context);
        // show error message
        showErrorMessage(e.code);
      }
    }
  }

  // error message popup
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  // wrong password message popup
  // void wrongPasswordMessage({String? message}){
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return  AlertDialog(
  //         title: Text( message ??'Incorrect Password'),
  //        );
  //      },
  //    );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 0), // Reduced top spacing
                
                //logo - made smaller to match login page
                const Icon(
                  Icons.lock,
                  size: 70, // Matches login page size
                ),

                const SizedBox(height: 25), // Matches login page spacing
                
                Text(
                  'Let\'s create an account!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 15), // Reduced spacing to match login page
                
                // email text field
                MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                //password textfield
                MyTextfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                // confirm password textfield
                const SizedBox(height: 10),
                MyTextfield(
                  controller: confirmpasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                // const SizedBox(height: 10),

                // // forget password? (hidden in register page but keeping structure)
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text(
                //         '',
                //         style: TextStyle(color: Colors.grey[600]),
                //       ),
                //     ],
                //   ),
                // ),

                const SizedBox(height: 15), // Reduced spacing to match login page

                // sign up button - made smaller with oval shape to match login page
                SizedBox(
                  width: 150, // Smaller width for oval shape
                  height: 50, // Smaller height
                  child: MyButton(
                    text: "Sign Up",
                    onTap: signUserUp,
                  ),
                ),

                // const SizedBox(height: 50),

                // or continue with
                //   Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //     child: Row(
                //        children: [
                //         Expanded(
                //           child: Divider(
                //             thickness: 0.5,
                //             color: Colors.grey[400],
                //           ),
                //         ),
                //
                //         Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //           child: Text(
                //             'Or continue with',
                //             style: TextStyle(color: Colors.grey[700],
                //           ),
                //         ),
                //       ),
                //
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[400],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // const SizedBox(height: 50),

                // google + apple sign in buttons
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: const [
                //   SquareTitle(imagePath: 'lib/images/google.png'),
                //
                //   SizedBox(width: 25),
                //
                //   SquareTitle(imagePath: 'lib/images/apple.png'),
                // ],
                // ),

                const SizedBox(height: 25), // Reduced spacing to match login page

                // login redirect
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25), // Reduced bottom spacing to match login page
              ],
            ),
          ),
        ),
      ),
    );
  }
}