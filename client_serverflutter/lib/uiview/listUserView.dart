import 'dart:convert';
import 'package:client_serverflutter/model/user.dart';
import 'package:client_serverflutter/uiview/detailPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListUserView extends StatefulWidget {
  const ListUserView({super.key});

  @override
  State<ListUserView> createState() => _ListUserViewState();
}

class _ListUserViewState extends State<ListUserView> {
  bool isLoading = true;
  List<User> listUser = [];

  Future getUser() async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response res = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/users"),
      );
      List<dynamic> data = jsonDecode(
        res.body,
      ); // Perbaikan: jsonDecode, bukan jsonEncode

      setState(() {
        listUser =
            data
                .map((item) => User.fromJson(item))
                .toList(); // Perbaikan: iterasi yang benar
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount:
                    listUser.length, // Perbaikan: hapus tanda titik dua ekstra
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                    ), // Perbaikan: EdgeInsets
                    child: Card(
                      child: ListTile(
                        // Perbaikan: gunakan ListTile
                        title: Text(
                          listUser[index].name ?? "",
                          style: const TextStyle(
                            fontSize: 18, // Perbaikan: hapus duplikasi fontSize
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Email: ${listUser[index].email ?? ''}"),
                            Text("Username: ${listUser[index].username ?? ''}"),
                            Text(
                              "City: ${listUser[index].address?.city ?? ''}",
                            ),
                            Text("Phone: ${listUser[index].phone ?? ''}"),
                            Text("Website: ${listUser[index].website ?? ''}"),
                            Text(
                              "Company: ${listUser[index].company?.name ?? ''}",
                            ),
                            Text(
                              "Street: ${listUser[index].address?.street ?? ''}",
                            ),
                            Text(
                              "Zipcode: ${listUser[index].address?.zipcode ?? ''}",
                            ),
                            Text(
                              "Suite: ${listUser[index].address?.suite ?? ''}",
                            ),
                            Text(
                              "Lat: ${listUser[index].address?.geo?.lat ?? ''}",
                            ),
                            Text(
                              "Lng: ${listUser[index].address?.geo?.lng ?? ''}",
                            ),
                            Text(
                              "CatchPhrase: ${listUser[index].company?.catchPhrase ?? ''}",
                            ),
                            Text("Bs: ${listUser[index].company?.bs ?? ''}"),

                            Text(
                              "Name: ${listUser[index].company?.name ?? ''}",
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      DetailPage(user: listUser[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
