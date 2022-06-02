import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  bool showPassword = true;
  var formKey = GlobalKey <FormState>();



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
          'Update your profile',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w900,
            fontSize: 24.0,
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
                            height: MediaQuery.of(context).size.height * 0.05,
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
                                const CircleAvatar(
                                  backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/847/847969.png'),
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
                                            onPressed: (){},
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

                                }
                              },
                              child: Text(
                                'Update',
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
