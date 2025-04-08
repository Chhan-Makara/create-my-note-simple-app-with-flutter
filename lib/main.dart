import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeView(), debugShowCheckedModeBanner: false);
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var lstItem = [];
  var txtNote = TextEditingController();

  void _showDeleteConfirmation(int index, String item) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Are you sure?"),
            content: Text("Do you really want to delete '$item'?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Cancel
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    lstItem.removeAt(index);
                  });
                  Navigator.pop(context); // Close the dialog
                },
                child: Text("Delete", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Note")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: txtNote,
              decoration: InputDecoration(
                labelText: 'Enter your note',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (txtNote.text.isEmpty) {
                    // Show an alert if text is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter some text")),
                    );
                    return;
                  }
                  setState(() {
                    lstItem.add(txtNote.text);
                    txtNote.clear();
                  });
                },
                child: Text("Add"),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: lstItem.length,
                itemBuilder: (context, index) {
                  final item = lstItem[index];
                  return ListTile(
                    title: Text(item),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          _showDeleteConfirmation(index, item);
                        });
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
