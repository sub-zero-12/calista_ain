import 'package:calista_ain/authentication/sign_in.dart';
import 'package:calista_ain/services/auth_service.dart';
import 'package:calista_ain/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic> userData = {};

  getUserData() async {
    userData = (await DatabaseService().getUserData())!;
    setState(() {});
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const CircleAvatar(
              child: Text('CA'),
            ),
            Text("Name: ${userData['name']}"),
            Text(
              "Email: ${userData['email']}",
              overflow: TextOverflow.ellipsis,
            ),
            Text("Mobile: ${userData['number']}"),
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
              onPressed: () async {
                Uri whatsapp = Uri.parse("https://wa.me/+8801773639437?text= ");
                await canLaunchUrl(whatsapp) ? launchUrl(whatsapp) : throw 'exception';
              },
              style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 40)),
              icon: Image.asset(
                'images/whatsapp.png',
                width: 40,
                height: 30,
              ),
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
              onPressed: () async {
                Uri url = Uri.parse("https://www.facebook.com/calistaain");
                await canLaunchUrl(url) ? launchUrl(url) : throw 'exception';
              },
              style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 40)),
              icon: Image.asset(
                'images/facebook.png',
                width: 30,
                height: 30,
              ),
              label: const Text('Facebook'),
            ),
            OutlinedButton.icon(
              onPressed: () async {
                Uri url = Uri.parse("https://www.instagram.com/calista.ain");
                await canLaunchUrl(url) ? launchUrl(url) : throw 'exception';
              },
              style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 40)),
              icon: Image.asset(
                'images/instagram.png',
                width: 30,
                height: 30,
              ),
              label: const Text('Instagram'),
            ),
          ],
        ),
      ),
    );
  }
}
