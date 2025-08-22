import 'package:flutter/material.dart';

void main() {
  runApp(StudentInfoManagerApp());
}

class StudentInfoManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Info Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int studentCount = 0; // counter for enrolled students
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Profile Picture URL
  final String profileUrl =
      "https://i.pravatar.cc/200"; // sample online profile pic

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Info Manager")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            /// (a) Welcome Dashboard
            Text(
              "Name: John Doe",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text("Course: BSc Computer Science",
                style: TextStyle(fontSize: 18)),
            Text("University: XYZ University",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),

            /// (b) Interactive Notification
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Hello, John Doe! Welcome to the Student Info Manager.",
                    ),
                  ),
                );
              },
              child: Text("Show Alert"),
            ),
            SizedBox(height: 20),

            /// (c) Student Counter
            Text(
              "Students Enrolled: $studentCount",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      studentCount++;
                    });
                  },
                  child: Text("+"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (studentCount > 0) {
                      setState(() {
                        studentCount--;
                      });
                    }
                  },
                  child: Text("-"),
                ),
              ],
            ),
            SizedBox(height: 30),

            /// (d) Student Login Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("Student Login",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Email"),
                    validator: (value) {
                      if (value == null || !value.contains("@")) {
                        return "Enter a valid email with @";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Password"),
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text("Login Successful for ${emailController.text}")),
                        );
                      }
                    },
                    child: Text("Login"),
                  )
                ],
              ),
            ),
            SizedBox(height: 30),

            /// (e) Profile Picture Display
            Text("Profile Picture:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                profileUrl,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}