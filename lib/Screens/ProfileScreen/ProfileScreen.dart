import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_firestore/Screens/EditProfile/EditProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  final String uId;
  const ProfileScreen({Key? key , required this.uId}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState(uId: uId);
}


class _ProfileScreenState extends State<ProfileScreen> {
  final String uId;
  _ProfileScreenState({required this.uId});

  Map? userData;
  bool loading = false;
  void getUserData ()
  {
    FirebaseFirestore.instance.collection('users').doc(uId)
        .get().then((value) {
          userData = value.data();
          setState((){
            loading = true;
          });
          print('user data : ${value.data().toString()}');
    }).catchError((error){
      print('Error in get user function : ${error.toString()}');
    });
  }

  @override
  void initState(){
    super.initState();
    getUserData();
    print('user id : ${uId}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffcb2f),
      appBar: AppBar(
        backgroundColor: const Color(0xFFffcb2f),
      ),
      body: loading == true ?Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome,',
                    style: GoogleFonts.lato(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      '${userData!['username']}',
                      style: GoogleFonts.lato(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
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
                                backgroundImage: NetworkImage('${userData!['image']}'),
                                radius: 60.0,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        Text(
                          '${userData!['username']}',
                          style: GoogleFonts.lato(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.phone_android,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '${userData!['phone']}',
                              style: GoogleFonts.lato(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.mail,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '${userData!['email']}',
                              style: GoogleFonts.lato(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
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
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return const EditProfileScreen();
                              }));
                            },
                            child: Text(
                              'Edit Profile',
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
      ) : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
