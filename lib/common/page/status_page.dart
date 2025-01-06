//
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Status'.tr)),
      body: ListView(
          children: ListTile.divideTiles(context: context, tiles: [
        ListTile(
          leading: const Icon(Icons.mobile_friendly_outlined),
          title: Text(
            'OnlineStatus'.tr,
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.light_mode_outlined),
          title: Text(
            'BusyStatus'.tr,
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.dark_mode_outlined),
          title: Text(
            'OfflineStatus'.tr,
          ),
          onTap: () {},
        )
      ]).toList()),
    );
  }
}
