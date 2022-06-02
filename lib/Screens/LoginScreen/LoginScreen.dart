import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_firestore/Screens/ProfileScreen/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../RegisterScreen/RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool showPassword = true;
  var formKey = GlobalKey <FormState>();


  void userLogin ({
    required String email,
    required String password,})
  {
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('Login Success, user id : ${value.user!.uid}');
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return ProfileScreen(uId: value.user!.uid,);
      }));
    }).catchError((error){
      print('Error in login Function : ${error.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffcb2f),
      appBar: AppBar(
        backgroundColor: const Color(0xFFffcb2f),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
            size: 30.0,
          ),
        ),
        title: Text(
          'Sign In',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w900,
            fontSize: 26.0,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 30.0,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 1,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Text(
                              'Welcome Back,',
                               style: GoogleFonts.lato(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Text(
                              'Login to Communicate with other people.',
                              style: GoogleFonts.lato(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          TextFormField(
                            decoration:  InputDecoration(
                              labelText: 'Email',
                              labelStyle: GoogleFonts.lato(
                                color: Colors.black,
                              ),
                              prefixIcon: const Icon(
                                Icons.mail,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2.0,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1.0,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1.0,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1.0,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'You must enter an Email!';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            decoration:  InputDecoration(
                              labelText: 'Password',
                              labelStyle: GoogleFonts.lato(
                                color: Colors.black,
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              suffixIcon: IconButton(
                                onPressed: (){
                                  setState((){
                                    showPassword =! showPassword;
                                  });
                                },
                                icon: Icon(
                                  showPassword ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.black,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2.0,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1.0,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1.0,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1.0,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            obscureText: showPassword,
                            controller: passwordController,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'You must enter a password!';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: InkWell(
                              onTap: (){},
                              child: Text(
                                'Forget password ?',
                                style: GoogleFonts.lato(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: MaterialButton(
                              onPressed: (){
                                if(formKey.currentState!.validate())
                                {
                                  userLogin(email: emailController.text, password: passwordController.text);
                                }
                              },
                              child: Text(
                                'Sign In',
                                style: GoogleFonts.lato(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: GoogleFonts.lato(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return const RegisterScreen();
                                  }));
                                },
                                child: Text(
                                  'Sign Up',
                                  style: GoogleFonts.lato(
                                    fontSize: 16.0,
                                    color: Colors.blue,
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }

}
