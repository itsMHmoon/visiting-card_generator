import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: 
        Text('Visiting Card Generator',
                style: GoogleFonts.notoSans(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF227C9D),
                ),
              ),
      backgroundColor: const Color(0xFFFFD3B6),
      actions: [ 
        IconButton(
          icon: const Icon(Symbols.build_circle_rounded, color: Color(0xFFFAAA8D), size: 30),
          onPressed: () {
            Navigator.pushNamed(context, '/test');
          },
        ),

//
// To add user icon and stuffs
//

        // InkWell(
        //   onTap: () {
        //     Navigator.pushNamed(context, '/test');
        //   },
        //   borderRadius: BorderRadius.circular(50),
        //   child: const CircleAvatar(
        //     backgroundImage: AssetImage('image/male.png'), // User image
        //   ),
        // ),
        // const SizedBox(width: 15),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
