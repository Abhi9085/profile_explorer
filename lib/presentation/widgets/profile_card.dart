// import 'package:flutter/material.dart';
// import 'package:profile_explorer/presentation/providers/user_provider.dart';
// import 'package:provider/provider.dart';
// import '../../../data/models/user_model.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class ProfileCard extends StatelessWidget {
//   final UserModel user;
//   const ProfileCard({super.key, required this.user});

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.read<UserProvider>();

//     return ClipRRect(
//       borderRadius: BorderRadius.circular(16),
//       child: Stack(
//         children: [
//           CachedNetworkImage(
//             imageUrl: user.imageUrl,
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//             placeholder: (context, url) =>
//                 Container(color: Colors.grey.shade300),
//           ),
//           Positioned(
//             left: 8,
//             bottom: 8,
//             right: 8,
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.black54,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     user.name,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   Text(
//                     user.city,
//                     style: const TextStyle(
//                       color: Colors.white70,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: 8,
//             right: 8,
//             child: GestureDetector(
//               onTap: () => provider.toggleLike(user),
//               child: AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 300),
//                 transitionBuilder: (child, anim) =>
//                     ScaleTransition(scale: anim, child: child),
//                 child: Icon(
//                   user.isLiked ? Icons.favorite : Icons.favorite_border,
//                   key: ValueKey(user.isLiked),
//                   color: user.isLiked ? Colors.redAccent : Colors.white,
//                   size: 26,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/user_model.dart';
import '../../presentation/providers/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileCard extends StatelessWidget {
  final UserModel user;
  const ProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<UserProvider>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: BorderRadius.circular(screenWidth * 0.04), // responsive radius
      child: Stack(
        children: [
          // Profile image
          CachedNetworkImage(
            imageUrl: user.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            placeholder: (context, url) =>
                Container(color: Colors.grey.shade300),
          ),

          // Bottom overlay with name, city, and heart
          Positioned(
            left: screenWidth * 0.02,
            bottom: screenHeight * 0.02,
            right: screenWidth * 0.02,
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.02), // responsive padding
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
              child: Stack(
                children: [
                  // Name and city
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.045, // responsive font
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        user.city,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: screenWidth * 0.035, // responsive font
                        ),
                      ),
                    ],
                  ),

                  // Heart icon positioned at bottom-right
                  Positioned(
                    bottom: 20,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => provider.toggleLike(user),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, anim) =>
                            ScaleTransition(scale: anim, child: child),
                        child: Icon(
                          user.isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          key: ValueKey(user.isLiked),
                          color: user.isLiked ? Colors.redAccent : Colors.white,
                          size: screenWidth * 0.065, // responsive icon size
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
