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
      home: VisitingCardForm(),
    );
  }
}

class VisitingCardForm extends StatefulWidget {
  const VisitingCardForm({super.key});

  @override
  _VisitingCardFormState createState() => _VisitingCardFormState();
}

class _VisitingCardFormState extends State<VisitingCardForm> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String degree = "";
  String designation = "";
  String phone = "";
  String email = "";
  String address = "";
  int uniqueId = 0;
  List<Map<String, String>> previousCards = [];

  Future<void> _printCard() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Container(
            width: 300,
            height: 170,
            padding: pw.EdgeInsets.all(16.0),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black, width: 2),
              borderRadius: pw.BorderRadius.circular(10),
            ),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      if (name.isNotEmpty)
                        pw.Text(
                          name,
                          style: pw.TextStyle(fontSize: 17, color: PdfColors.blue900),
                        ),
                      if (degree.isNotEmpty) pw.Text(degree),
                      if (designation.isNotEmpty) pw.Text(designation),
                    ],
                  ),
                ),
                pw.Container(
                  width: 1,
                  color: PdfColors.black,
                  margin: pw.EdgeInsets.symmetric(horizontal: 8.0),
                ),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      if (phone.isNotEmpty) pw.Row(children: [pw.Text("📞 "), pw.Text(phone)]),
                      if (email.isNotEmpty) pw.Row(children: [pw.Text("✉ "), pw.Text(email)]),
                      if (address.isNotEmpty) pw.Row(children: [pw.Text("📍 "), pw.Text(address)]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  void _showGeneratedCard() {
    setState(() {
      previousCards.insert(0, {
        "name": name,
        "degree": degree,
        "designation": designation,
        "phone": phone,
        "email": email,
        "address": address,
      });
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Generated Visiting Card:'),
          content: SingleChildScrollView(
            child: Center(
              child: SizedBox(
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
                              if (name.isNotEmpty)
                                Text(
                                  name,
                                  style: GoogleFonts.oswald(fontSize: 18, color: Colors.blue[900]),
                                ),
                              if (degree.isNotEmpty) Text(degree, style: GoogleFonts.jost(fontSize: 14)),
                              if (designation.isNotEmpty) Text(designation, style: GoogleFonts.jost(fontSize: 16)),
                            ],
                          ),
                        ),
                        VerticalDivider(color: Colors.black),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (phone.isNotEmpty) Row(children: [Icon(Icons.phone, size: 17), SizedBox(width: 4), Text(phone)]),
                              if (email.isNotEmpty) Row(children: [Icon(Icons.email, size: 17), SizedBox(width: 4), Text(email)]),
                              if (address.isNotEmpty) Row(children: [Icon(Icons.location_on, size: 17), SizedBox(width: 4), Text(address)]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: _printCard,
              child: Text('Print / Export as PDF'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
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
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: previousCards.length,
                itemBuilder: (context, index) {
                  final card = previousCards[index];
                  return GestureDetector(
                    onTap: _showGeneratedCard,
                    onDoubleTap: () {},
                    child: Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: Text("${(index + 1).toString().padLeft(2, '0')}"),
                        title: Text(card["name"] ?? ""),
                        subtitle: Text(card["phone"] ?? ""),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _showGeneratedCard,
              child: Text('Generate'),
            ),
          ],
        ),
      ),
    );
  }
}
