import 'dart:convert';
import 'package:client_serverflutter/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatelessWidget {
  final User user;

  const DetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name ?? "Detail")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name: ${user.name ?? ''}",
              style: const TextStyle(fontSize: 18),
            ),
            Text("Username: ${user.username ?? ''}"),
            Text("Email: ${user.email ?? ''}"),
            Text("Phone: ${user.phone ?? ''}"),
            Text("Website: ${user.website ?? ''}"),
            Text("City: ${user.address?.city ?? ''}"),
            Text("Company: ${user.company?.name ?? ''}"),
            Text("Street: ${user.address?.street ?? ''}"),
            Text("Zipcode: ${user.address?.zipcode ?? ''}"),
            Text("Suite: ${user.address?.suite ?? ''}"),
            Text("Latitude: ${user.address?.geo?.lat ?? ''}"),
            Text("Longitude: ${user.address?.geo?.lng ?? ''}"),
          ],
        ),
      ),
    );
  }
}
