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
                      if (phone.isNotEmpty) pw.Text(phone),
                      if (email.isNotEmpty) pw.Row(children: [pw.Icon (Icons.phone_android_rounded as pw.IconData, size: 17,), pw.SizedBox(width: 3), pw.Text(email)]),
                      if (address.isNotEmpty) pw.Row(children: [pw.Icon(pw.IconData(0xe0c8)), pw.SizedBox(width: 3), pw.Text(address)]),
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Generated Visiting Card:'),
          content: SizedBox(
            width: 300,
            height: 170,
            child: AspectRatio(
              aspectRatio: 9 / 3, // Adjust this ratio as needed (Width / Height)
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
                            Padding(padding: EdgeInsets.only(top: 7)),
                            if (name.isNotEmpty)
                              Text(
                                name.toUpperCase(),
                                style: GoogleFonts.oswald(fontSize: 18, color: Colors.blue[900]),
                              ),
                            Padding(padding: EdgeInsets.only(top: 2)),
                            if (degree.isNotEmpty)
                              Text(degree, style: GoogleFonts.jost(fontSize: 14, color: Colors.black)),
                            Padding(padding: EdgeInsets.only(top: 2)),
                            if (designation.isNotEmpty)
                              Text(designation, style: GoogleFonts.jost(fontSize: 16, color: Colors.black)),
                          ],
                        ),
                      ),
                      VerticalDivider(color: Colors.black),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(top: 10)),
                            if (phone.isNotEmpty)
                              Row(
                                children: [
                                  Icon(Icons.phone_android_rounded, size: 17),
                                  SizedBox(width: 4),
                                  Text(phone, style: GoogleFonts.nunito(fontSize: 10, color: Colors.black)),
                                ],
                              ),
                            Padding(padding: EdgeInsets.only(top: 7)),
                            if (email.isNotEmpty)
                              Row(
                                children: [
                                  Icon(Icons.email_rounded, size: 17),
                                  SizedBox(width: 4),
                                  Text(email, style: GoogleFonts.nunito(fontSize: 10, color: Colors.black)),
                                ],
                              ),
                            Padding(padding: EdgeInsets.only(top: 7)),
                            if (address.isNotEmpty)
                              Row(
                                children: [
                                  Icon(Icons.location_city_rounded, size: 17),
                                  SizedBox(width: 4),
                                  Text(address, 
                                        style: GoogleFonts.nunito(fontSize: 10, 
                                        color: Colors.black,
                                        // maxLines: 1,
                                        // overflow: TextOverflow.ellipsis,
                                        )
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ),
          ),
          actions: [
            Text('Unique ID: $uniqueId', style: GoogleFonts.abel(fontSize: 7, color: Color.fromARGB(101, 77, 76, 76))),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 0, 153, 255), foregroundColor: Colors.white, elevation: 2),
              onPressed: _printCard,
              child: Text('Export',
                          style: GoogleFonts.gabarito(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 255, 51, 1), foregroundColor: Colors.white, elevation: 2),
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close',
                          style: GoogleFonts.gabarito(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                        ),
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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onChanged: (value) => name = value.toUpperCase(),
                  validator: (value) => value!.isEmpty ? 'Please enter name' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Degree or Title'),
                  onChanged: (value) => degree = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Designation'),
                  onChanged: (value) => designation = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Phone Number with Country Code'),
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => phone = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => email = value.toLowerCase(),
                ),
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
                        uniqueId = DateTime.now().millisecondsSinceEpoch;
                      });
                      _showGeneratedCard();
                    }
                  },
                  child: Text('Generate'),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
