import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:visiting_card_generator/widgets/app_bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  List<Map<String, String>> visitingCards = [];

  String name = "";
  String degree = "";
  String designation = "";
  String phone = "";
  String email = "";
  String address = "";


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
                            border: pw.Border.all(
                                        color: PdfColors.black, 
                                        width: 2,
                                      ),
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
                                                style: pw.TextStyle(
                                                  fontSize: 17, 
                                                  color: PdfColors.blue900
                                                ),
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


    await Printing.layoutPdf(
            onLayout: (PdfPageFormat format) async => pdf.save());
  }


  void _addCard() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        visitingCards.add({
          'name': name,
          'degree': degree,
          'designation': designation,
          'phone': phone,
          'email': email,
          'address': address,
        });
      });
    }
  }

  void _editCard(int index) {
    Map<String, String> card = visitingCards[index];
    TextEditingController nameController = TextEditingController(text: card['name']);
    TextEditingController degreeController = TextEditingController(text: card['degree']);
    TextEditingController designationController = TextEditingController(text: card['designation']);
    TextEditingController phoneController = TextEditingController(text: card['phone']);
    TextEditingController emailController = TextEditingController(text: card['email']);
    TextEditingController addressController = TextEditingController(text: card['address']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Information',
                  style: GoogleFonts.gabarito(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          ),
                ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController, 
              decoration: InputDecoration(labelText: 'Name')),
            TextField(
              controller: degreeController, 
              decoration: InputDecoration(labelText: 'Degree')),
            TextField(
              controller: designationController, 
              decoration: InputDecoration(labelText: 'Designation')),
            TextField(
              controller: phoneController, 
              decoration: InputDecoration(labelText: 'Phone')),
            TextField(
              controller: emailController, 
              decoration: InputDecoration(labelText: 'Email')),
            TextField(
              controller: addressController, 
              decoration: InputDecoration(labelText: 'Address')),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 255, 153, 1), 
            foregroundColor: Colors.white, 
            elevation: 2),
            onPressed: () {
              setState(() {
                visitingCards[index] = {
                  'name': nameController.text,
                  'degree': degreeController.text,
                  'designation': designationController.text,
                  'phone': phoneController.text,
                  'email': emailController.text,
                  'address': addressController.text,
                };
              });
              Navigator.pop(context);
            },
            child: Text('Update',
                    style: GoogleFonts.gabarito(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            ),
            ),
          ),

          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 255, 51, 1), 
              foregroundColor: Colors.white, 
              elevation: 2),
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
      ),
    );
  }


//
// New Card
//


  void _showGeneratedCard(Map<String, String> card) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: null,
        // Text('',
                    // style: GoogleFonts.gantari(
                    //                           fontSize: 25,
                    //                           fontWeight: FontWeight.w400,
                    //                           color: Colors.black,
                    //                         ),
                  // ),
        content: SizedBox(
            width: 300,
            height: 170,
            child: AspectRatio(
              aspectRatio: 15 / 3, // Adjust this ratio as needed (Width / Height)
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
                                card['name']?.toUpperCase() ?? '',
                                style: GoogleFonts.oswald(fontSize: 14, color: Colors.blue[900]),
                              ),
                            Padding(padding: EdgeInsets.only(top: 2)),
                            if (degree.isNotEmpty)
                              Text(
                                card['degree'] ?? '', 
                                style: GoogleFonts.jost(fontSize: 10, color: Colors.black)),
                            Padding(padding: EdgeInsets.only(top: 2)),
                            if (designation.isNotEmpty)
                              Text(
                                card['designation'] ?? '', 
                                style: GoogleFonts.jost(fontSize: 12, color: Colors.black)),
                          ],
                        ),
                      ),
                      VerticalDivider(color: const Color.fromARGB(100, 0, 0, 0)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(top: 10)),
                            if (phone.isNotEmpty)
                              Row(
                                children: [
                                  Icon(Icons.phone_android_rounded, size: 15),
                                  SizedBox(width: 4),
                                  Text(
                                    card['phone'] ?? '',
                                    style: GoogleFonts.nunito(fontSize: 8, color: Colors.black)),
                                ],
                              ),
                            Padding(padding: EdgeInsets.only(top: 7)),
                            if (email.isNotEmpty)
                              Row(
                                children: [
                                  Icon(Icons.email_rounded, size: 15),
                                  SizedBox(width: 4),
                                  Text(
                                    card['email'] ?? '', 
                                    style: GoogleFonts.nunito(fontSize: 8, color: Colors.black)),
                                ],
                              ),
                            Padding(padding: EdgeInsets.only(top: 7)),
                            if (address.isNotEmpty)
                              Row(
                                children: [
                                  Icon(Icons.location_city_rounded, size: 15),
                                  SizedBox(width: 4),
                                  Text(address, 
                                        style: GoogleFonts.nunito(fontSize: 8, 
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
            // Text('Unique ID: $uniqueId', style: GoogleFonts.abel(fontSize: 7, color: Color.fromARGB(101, 77, 76, 76))),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CC9F0), 
              foregroundColor: Colors.white, 
              elevation: 2),
              onPressed: _printCard,      // Print / Export as PDF
              // onPressed: null, //grayed button
              child: Text('Export',
                      style: GoogleFonts.gabarito(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF07167), 
              foregroundColor: Colors.white, 
              elevation: 2),
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
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),  //custom appBar
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    onChanged: (value) => name = value,
                    validator: (value) => value!.isEmpty ? 'Enter name' : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Degree'), 
                    onChanged: (value) => degree = value),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Designation'), 
                    onChanged: (value) => designation = value),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Phone'), 
                    keyboardType: TextInputType.phone, 
                    onChanged: (value) { 
                      if (RegExp(r'^[0-9+]+$').hasMatch(value)) {
                        phone = value; 
                        }
                      },
                    ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'), 
                    onChanged: (value) => email = value),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Address'), 
                    onChanged: (value) => address = value),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4EB09B), 
                    foregroundColor: Colors.white, 
                    elevation: 2),
                    onPressed: _addCard, 
                    child: Text('Create',
                              style: GoogleFonts.gabarito(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                    ),  
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: visitingCards.length,
                itemBuilder: (context, index) {
                  Map<String, String> card = visitingCards[index];
                  return GestureDetector(
                    onTap: () => _showGeneratedCard(card),
                    onDoubleTap: () => _editCard(index),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text('${(index + 1).toString().padLeft(2, '0')}. ${card['name']}'),
                        subtitle: Text(card['phone'] ?? ''),
                      ),
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