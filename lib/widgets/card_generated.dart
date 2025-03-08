// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:printing/printing.dart';
// import 'package:pdf/pdf.dart';
// import '';


//   void _showGeneratedCard(Map<String, String> card) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Visiting Card',
//                     style: GoogleFonts.gantari(
//                                               fontSize: 25,
//                                               fontWeight: FontWeight.w400,
//                                               color: Colors.black,
//                                             ),
//                   ),

//         content: SizedBox(
//             width: 300,
//             height: 170,
//             child: AspectRatio(
//               aspectRatio: 15 / 3, // Adjust this ratio as needed (Width / Height)
//               child: Card(
//                 elevation: 5,
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Padding(padding: EdgeInsets.only(top: 7)),
//                             if (name.isNotEmpty)
//                               Text(
//                                 card['name']?.toUpperCase() ?? '',
//                                 style: GoogleFonts.oswald(fontSize: 14, color: Colors.blue[900]),
//                               ),
//                             Padding(padding: EdgeInsets.only(top: 2)),
//                             if (degree.isNotEmpty)
//                               Text(
//                                 card['degree'] ?? '', 
//                                 style: GoogleFonts.jost(fontSize: 10, color: Colors.black)),
//                             Padding(padding: EdgeInsets.only(top: 2)),
//                             if (designation.isNotEmpty)
//                               Text(
//                                 card['designation'] ?? '', 
//                                 style: GoogleFonts.jost(fontSize: 12, color: Colors.black)),
//                           ],
//                         ),
//                       ),
//                       VerticalDivider(color: const Color.fromARGB(100, 0, 0, 0)),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(padding: EdgeInsets.only(top: 10)),
//                             if (phone.isNotEmpty)
//                               Row(
//                                 children: [
//                                   Icon(Icons.phone_android_rounded, size: 15),
//                                   SizedBox(width: 4),
//                                   Text(
//                                     card['phone'] ?? '',
//                                     style: GoogleFonts.nunito(fontSize: 8, color: Colors.black)),
//                                 ],
//                               ),
//                             Padding(padding: EdgeInsets.only(top: 7)),
//                             if (email.isNotEmpty)
//                               Row(
//                                 children: [
//                                   Icon(Icons.email_rounded, size: 15),
//                                   SizedBox(width: 4),
//                                   Text(
//                                     card['email'] ?? '', 
//                                     style: GoogleFonts.nunito(fontSize: 8, color: Colors.black)),
//                                 ],
//                               ),
//                             Padding(padding: EdgeInsets.only(top: 7)),
//                             if (address.isNotEmpty)
//                               Row(
//                                 children: [
//                                   Icon(Icons.location_city_rounded, size: 15),
//                                   SizedBox(width: 4),
//                                   Text(address, 
//                                         style: GoogleFonts.nunito(fontSize: 8, 
//                                         color: Colors.black,
//                                         // maxLines: 1,
//                                         // overflow: TextOverflow.ellipsis,
//                                         )
//                                     ),
//                                 ],
//                               ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//             ),
//           ),

//         actions: [
//             // Text('Unique ID: $uniqueId', style: GoogleFonts.abel(fontSize: 7, color: Color.fromARGB(101, 77, 76, 76))),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 0, 153, 255), 
//               foregroundColor: Colors.white, 
//               elevation: 2),
//               onPressed: _printCard,      // Print / Export as PDF
//               // onPressed: null, //grayed button
//               child: Text('Export',
//                           style: GoogleFonts.gabarito(
//                                               fontSize: 17,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                             ),
//               ),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 255, 51, 1), 
//               foregroundColor: Colors.white, 
//               elevation: 2),
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('Close',
//                           style: GoogleFonts.gabarito(
//                                               fontSize: 17,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                             ),
//                         ),
//             ),
//         ],
//       ),
//     );
//   }

