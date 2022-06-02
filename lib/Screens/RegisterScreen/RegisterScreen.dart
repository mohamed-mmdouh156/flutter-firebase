import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../LoginScreen/LoginScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  bool showPassword = true;
  var formKey = GlobalKey <FormState>();


  void userRegister({
    required String email,
    required String password,
    required String username,
    required String phone,
  })
  {
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
    .then((value) {
      print('register Success user id : ${value.user!.uid}');
      uploadUserImage(uId: value.user!.uid, username: username, email: email, phone: phone);
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return const LoginScreen();
      }));
    }).catchError((error){
      print('Error in Register Function : ${error.toString()}');
    });
  }

  ImageProvider profileImage = const NetworkImage('https://cdn-icons-png.flaticon.com/512/847/847969.png');
  String? imageUrl = 'https://cdn-icons-png.flaticon.com/512/847/847969.png';

  File? imagePath;

  void getImageFromGallery ()
  {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      if(value != null)
        {
          setState((){
            imagePath = File(value.path);
            profileImage = FileImage(imagePath!);
          });
        }
      else{
        print('no selected image');
      }
    });
  }

  String? fireImage;
  void uploadUserImage ({
    required String uId,
    required String username,
    required String email,
    required String phone,
  })
  {
    FirebaseStorage.instance.ref().child("usersImages/${imagePath!.uri.pathSegments.last}")
        .putFile(imagePath!).then((value) {
          value.ref.getDownloadURL().then((value) {
            fireImage = value;
            createUser(uId: uId, username: username, email: email, phone: phone, image: fireImage!);
          });
    });
  }

  void createUser ({
  required String uId,
    required String username,
    required String email,
    required String phone,
    required String image,
})
  {
    FirebaseFirestore.instance.collection('users')
        .doc(uId).set({
      'username' : username,
      'email' : email,
      'phone' : phone,
      'image' : image,
    }).then((value) {
      print('User profile created ');
    }).catchError((error){
      print('Error in create user funnction :${error.toString()}');
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
          'Sign Up',
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
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                          ),
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Text(
                              'Sign Up Now,',
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
                              'Sign up to can Communicate with other people.',
                              style: GoogleFonts.lato(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                          ),
                          Container(
                            height: 140,
                            width: 140,
                            child: Stack(
                              alignment: Alignment.center,
                              children:  [
                                const CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 62.0,
                                ),
                                CircleAvatar(
                                  backgroundImage: profileImage,
                                  radius: 60.0,
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 18.0 , bottom: 10.0),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children:  [
                                        const CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 18.0,
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.black,
                                          radius: 16.0,
                                          child: IconButton(
                                              onPressed: (){
                                                getImageFromGallery();
                                              },
                                              icon: const Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          TextFormField(
                            decoration:  InputDecoration(
                              labelText: 'Username',
                              labelStyle: GoogleFonts.lato(
                                color: Colors.black,
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
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
                            keyboardType: TextInputType.text,
                            controller: usernameController,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'You must enter an username!';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
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
                              labelText: 'Phone',
                              labelStyle: GoogleFonts.lato(
                                color: Colors.black,
                              ),
                              prefixIcon: const Icon(
                                Icons.phone,
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
                            keyboardType: TextInputType.phone,
                            controller: phoneController,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'You must enter a phone!';
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
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
                                    userRegister(email: emailController.text, password: passwordController.text , username: usernameController.text,
                                    phone: phoneController.text );
                                  }
                              },
                              child: Text(
                                'Sign Up',
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
                                'Already have an account',
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
                                    return const LoginScreen();
                                  }));
                                },
                                child: Text(
                                  'Sign In',
                                  style: GoogleFonts.lato(
                                    fontSize: 16.0,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
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
