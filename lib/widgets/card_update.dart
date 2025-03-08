import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:visiting_card_generator/screens/home_page.dart';



Future<void> showEditCardDialog(
    BuildContext context,
    int index,
    List<Map<String, String>> visitingCards,
    Function(int, Map<String, String>) onUpdate) {
  
  Map<String, String> card = visitingCards[index];
  TextEditingController nameController = TextEditingController(text: card['name']);
  TextEditingController degreeController = TextEditingController(text: card['degree']);
  TextEditingController designationController = TextEditingController(text: card['designation']);
  TextEditingController phoneController = TextEditingController(text: card['phone']);
  TextEditingController emailController = TextEditingController(text: card['email']);
  TextEditingController addressController = TextEditingController(text: card['address']);

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Update Information',
        style: GoogleFonts.gabarito(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
          TextField(controller: degreeController, decoration: InputDecoration(labelText: 'Degree')),
          TextField(controller: designationController, decoration: InputDecoration(labelText: 'Designation')),
          TextField(controller: phoneController, decoration: InputDecoration(labelText: 'Phone')),
          TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
          TextField(controller: addressController, decoration: InputDecoration(labelText: 'Address')),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 153, 1),
              foregroundColor: Colors.white,
              elevation: 2),
          onPressed: () {
            onUpdate(index, {
              'name': nameController.text,
              'degree': degreeController.text,
              'designation': designationController.text,
              'phone': phoneController.text,
              'email': emailController.text,
              'address': addressController.text,
            });
            Navigator.pop(context);
          },
          child: Text(
            'Update',
            style: GoogleFonts.gabarito(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 51, 1),
              foregroundColor: Colors.white,
              elevation: 2),
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Close',
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
