//
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModePage extends StatefulWidget {
  const ModePage({super.key});

  @override
  State<ModePage> createState() => _ModePageState();
}

class _ModePageState extends State<ModePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mode'.tr)),
      body: ListView(
          children: ListTile.divideTiles(context: context, tiles: [
        ListTile(
          leading: const Icon(Icons.mobile_friendly_outlined),
          title: Text(
            'TeamMode'.tr,
          ),
          onTap: () {
            
          },
        ),
        ListTile(
          leading: const Icon(Icons.light_mode_outlined),
          title: Text(
            'AgentMode'.tr,
          ),
          onTap: () {
            
          },
        ),
        ListTile(
          leading: const Icon(Icons.dark_mode_outlined),
          title: Text(
            'PersonalMode'.tr,
          ),
          onTap: () {
            
          },
        )
      ]).toList()),
    );
  }
}
