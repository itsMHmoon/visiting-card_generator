import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String degree = "";
  String designation = "";
  String phone = "";
  String email = "";
  String address = "";
  int uniqueId = 1;

  Future<void> _printCard() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Container(
            padding: pw.EdgeInsets.all(16.0),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black, width: 2),
              borderRadius: pw.BorderRadius.circular(10),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (name.isNotEmpty) pw.Text('Name: $name'),
                if (degree.isNotEmpty) pw.Text('Degree: $degree'),
                if (designation.isNotEmpty) pw.Text('Designation: $designation'),
                if (phone.isNotEmpty) pw.Text('Phone: $phone'),
                if (email.isNotEmpty) pw.Text('Email: $email'),
                if (address.isNotEmpty) pw.Text('Address: $address'),
              ],
            ),
          ),
        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visiting Card Generator"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Logo Upload Placeholder
                Container(
                  height: 100,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text("Company Logo"),
                  ),
                ),
                SizedBox(height: 20),

                // Name Input
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  style: GoogleFonts.oswald(fontSize: 16, color: Colors.blue[900]),
                  onChanged: (value) => name = value,
                  validator: (value) => value!.isEmpty ? 'Please enter name' : null,
                ),

                // Degree Input
                TextFormField(
                  decoration: InputDecoration(labelText: 'Degree or Title'),
                  onChanged: (value) => degree = value,
                ),

                // Designation Input
                TextFormField(
                  decoration: InputDecoration(labelText: 'Designation'),
                  onChanged: (value) => designation = value,
                ),

                // Phone Input
                TextFormField(
                  decoration: InputDecoration(labelText: 'Phone Number with Country Code'),
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => phone = value,
                  validator: (value) => value!.isEmpty ? 'Please enter phone number' : null,
                ),

                // Email Input
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => email = value,
                  validator: (value) => value!.isEmpty ? 'Please enter email' : null,
                ),

                // Address Input
                TextFormField(
                  decoration: InputDecoration(labelText: 'Address (Street, Region, Country)'),
                  onChanged: (value) => address = value,
                ),

                SizedBox(height: 10),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, elevation: 2),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        uniqueId = DateTime.now().millisecondsSinceEpoch; // Temporary unique ID
                      });
                    }
                  },
                  child: Text('Generate Visiting Card'),
                ),

                SizedBox(height: 20),

                if (uniqueId > 0) Text('Unique ID: $uniqueId', style: GoogleFonts.abel(fontSize: 7, color: const Color.fromARGB(101, 77, 76, 76))),

                // Display Visiting Card

                if (uniqueId > 0)
                    SizedBox(
                      width: 300,
                      height: 170,
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (name.isNotEmpty) Text(
                                            name,
                                              style: GoogleFonts.oswald(fontSize: 17, color: Colors.blue[900]),
                                          ),
                                    if (degree.isNotEmpty) Text(degree),
                                    if (designation.isNotEmpty) Text(designation),

                                  ],
                                ),
                              ),
                              VerticalDivider(color: const Color.fromARGB(255, 3, 3, 3)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (phone.isNotEmpty) Text('Phone: $phone'),
                                    if (email.isNotEmpty) Text('Email: $email'),
                                    if (address.isNotEmpty) Text('Address: $address'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white, elevation: 2),
                  onPressed: _printCard,
                  child: Text('Print / Export as PDF'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
