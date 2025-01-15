import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(MoodTrackerApp());
}

class MoodTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '心情管理紀錄',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('主頁'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MoodRecordPage()),
                );
              },
              child: Text('心情紀錄'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
              },
              child: Text('歷史紀錄'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DataVisualizationPage()),
                );
              },
              child: Text('數據可視化'),
            ),
          ],
        ),
      ),
    );
  }
}

class MoodRecordPage extends StatefulWidget {
  @override
  _MoodRecordPageState createState() => _MoodRecordPageState();
}

class _MoodRecordPageState extends State<MoodRecordPage> {
  String? selectedMood;
  TextEditingController diaryController = TextEditingController();

  Future<void> saveMoodRecord() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> records = prefs.getStringList('moodRecords') ?? [];

    final record = {
      'date': DateTime.now().toIso8601String(),
      'mood': selectedMood,
      'diary': diaryController.text,
    };

    records.add(jsonEncode(record));
    await prefs.setStringList('moodRecords', records);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('已保存心情記錄')));
    diaryController.clear();
    setState(() {
      selectedMood = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('心情紀錄'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('今天的心情如何？', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedMood,
              items: ['開心', '平靜', '難過', '壓力大']
                  .map((mood) => DropdownMenuItem(
                value: mood,
                child: Text(mood),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedMood = value;
                });
              },
              decoration: InputDecoration(
                labelText: '選擇心情',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: diaryController,
              decoration: InputDecoration(
                labelText: '寫下你的日記...',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveMoodRecord,
              child: Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  Future<List<Map<String, dynamic>>> fetchMoodRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> records = prefs.getStringList('moodRecords') ?? [];
    return records.map((record) => jsonDecode(record)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('歷史紀錄'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchMoodRecords(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('尚無紀錄'));
          }
          final records = snapshot.data!;
          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              return ListTile(
                title: Text(record['mood'] ?? '未知心情'),
                subtitle: Text(record['diary'] ?? ''),
                trailing: Text(record['date'].toString().substring(0, 10)),
              );
            },
          );
        },
      ),
    );
  }
}

class DataVisualizationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('數據可視化'),
      ),
      body: Center(
        child: Text('圖表功能待實現...'),
      ),
    );
  }
}
