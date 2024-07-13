import 'package:calista_ain/authentication/sign_in.dart';
import 'package:calista_ain/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const CircleAvatar(
              child: Text('C'),
            ),
            const Text("Name: Calista Ain"),
            const Text("Email: CalistaAin@gmail.com"),
            const Text("Mobile: 01758426060"),
            ElevatedButton(
              onPressed: () async {
                await AuthServices().logout();
                Get.offAll(() => const SignInPage());
              },
              child: const Text('Logout'),
            ),
            const Spacer(),

            const Text("Contact Us"),
            OutlinedButton.icon(
              onPressed: () {},
              style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 40)),
              icon: Image.asset('images/whatsapp.png',width: 40, height: 30,),
              label: const Text('WhatsApp'),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 40)),
              icon: const Icon(Icons.phone),
              label: const Text('Call Us'),
            ),

            const Text("Follow Us"),
            OutlinedButton.icon(
              onPressed: () {},
              style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 40)),
              icon: Image.asset('images/facebook.png',width: 30, height: 30,),
              label: const Text('Facebook'),
            ),

            OutlinedButton.icon(
              onPressed: () {},
              style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 40)),
              icon: Image.asset('images/instagram.png', width: 30, height: 30,),
              label: const Text('Instagram'),
            ),
          ],
        ),
      ),
    );
  }
}
