import 'package:flutter/material.dart';

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

class MoodRecordPage extends StatelessWidget {
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
              items: ['開心', '平靜', '難過', '壓力大']
                  .map((mood) => DropdownMenuItem(
                value: mood,
                child: Text(mood),
              ))
                  .toList(),
              onChanged: (value) {},
              decoration: InputDecoration(
                labelText: '選擇心情',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: '寫下你的日記...',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Save mood and diary entry logic
              },
              child: Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('歷史紀錄'),
      ),
      body: Center(
        child: Text('這裡將顯示用戶的歷史心情記錄'),
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
        child: Text('這裡將顯示心情數據的圖表'),
      ),
    );
  }
}