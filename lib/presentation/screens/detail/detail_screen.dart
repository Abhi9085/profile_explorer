import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/user_model.dart';
import '../../providers/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailScreen extends StatefulWidget {
  final UserModel user;
  const DetailScreen({super.key, required this.user});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double _dragOffset = 0;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: screenWidth * 0.07),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white, size: screenWidth * 0.07),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Hero image
          Hero(
            tag: widget.user.imageUrl,
            child: CachedNetworkImage(
              imageUrl: widget.user.imageUrl,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              width: screenWidth,
              height: screenHeight,
            ),
          ),

          // Bottom detail panel with drag gesture
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  _dragOffset = (_dragOffset + details.delta.dy).clamp(0.0, double.infinity);
                });
              },
              onVerticalDragEnd: (details) {
                if (_dragOffset > screenHeight * 0.2 || details.primaryVelocity! > 500) {
                  Navigator.pop(context);
                } else {
                  setState(() {
                    _dragOffset = 0;
                  });
                }
              },
              child: Transform.translate(
                offset: Offset(0, _dragOffset),
                child: Container(
                  width: screenWidth,
                  padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.05,
                    screenHeight * 0.02,
                    screenWidth * 0.05,
                    screenHeight * 0.04,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(screenWidth * 0.07),
                      topRight: Radius.circular(screenWidth * 0.07),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle bar
                      Center(
                        child: Container(
                          width: screenWidth * 0.09,
                          height: 5,
                          margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300.withOpacity(0.6),
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Name & Age
                      Text(
                        '${widget.user.name}, ${widget.user.age}',
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // Location label
                      Text(
                        'Location',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),

                      // City + Country
                      Text(
                        '${widget.user.city}, ${widget.user.country}',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Floating heart button
          Positioned(
            bottom: screenHeight * 0.08,
            right: screenWidth * 0.05,
            child: GestureDetector(
                      onTap: () => provider.toggleLike(widget.user),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, anim) =>
                            ScaleTransition(scale: anim, child: child),
                        child: Icon(
                          widget.user.isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          key: ValueKey(widget.user.isLiked),
                          color: widget.user.isLiked ? Colors.redAccent : Colors.black,
                          size: screenWidth * 0.065, // responsive icon size
                        ),
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}
