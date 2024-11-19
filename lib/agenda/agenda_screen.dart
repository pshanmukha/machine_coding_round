import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:machine_code/agenda/agenda_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'agenda_model.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  String? accessToken;
  late final Future<List<Datum>> agendaFuture;

  @override
  void initState() {
    agendaFuture = fetchAgenda();
    super.initState();
  }



  Future<List<Datum>> fetchAgenda() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    accessToken = token;
    debugPrint("token - $token");
    final response = await http.get(
        Uri.parse('https://api.viva365.com/api/v1/conference/getagenda/219'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    debugPrint("response statusCode - ${response.statusCode.toString()}");
    debugPrint("-------------------------------");
    log("response body - ${response.body.toString()}");
    if (response.statusCode == 200) {
      final agendaJson = Agenda.fromJson(jsonDecode(response.body));
      return agendaJson.data;
    } else {
      throw Exception('Failed to load agenda');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Agenda')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
              future: agendaFuture,
              builder: (BuildContext context, AsyncSnapshot<List<Datum>> snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator(),);
                } else if (snapshot.hasError){
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Scrollbar(
                    thumbVisibility: true,
                    child: ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return AgendaItemWidget(
                          datum: snapshot.data![index],
                          accessToken: accessToken!,
                        );
                      },
                    ),
                  );
                }
              }),
        ));
  }
}
