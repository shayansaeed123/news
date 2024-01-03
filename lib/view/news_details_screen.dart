import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDetailsScreen extends StatefulWidget {
  const NewsDetailsScreen({super.key,
    required this.newsTitle,
    required this.newsImage,
    required this.nwsContent,
    required this.newsSource,
    required this.newsDescription,
    required this.newsAuthor,
    required this.newsDate});

  final String newsTitle, newsImage,nwsContent,newsSource,newsDescription,newsAuthor,newsDate;

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  Connectivity connectivity = Connectivity();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text("News Details",style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: height * .45,
              width: width,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.newsImage,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
            Container(
              height: height * .6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                )
              ),
              margin: EdgeInsets.only(top: height * .4),
              padding: EdgeInsets.all(height * 0.05),
              child: ListView(
                children: [
                  Text(widget.newsTitle,
                    style: GoogleFonts.poppins()
                        .copyWith(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500)
                  ),
                  SizedBox(height: height * 0.03,),
                  Row(
                    children: [
                      Expanded(
                        child: Text(widget.newsSource,
                            style: GoogleFonts.poppins()
                                .copyWith(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                      Text(widget.newsDate,
                          style: GoogleFonts.poppins()
                              .copyWith(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w300)
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.03,),
                  Text(widget.newsDescription,
                      style: GoogleFonts.poppins()
                          .copyWith(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)
                  ),
                  SizedBox(height: height * 0.03,),
                  Text(widget.nwsContent,
                      style: GoogleFonts.poppins()
                          .copyWith(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w400)
                  ),
                  SizedBox(height: height * 0.03,),
                  Center(
                    child: Text(widget.newsAuthor,
                        style: GoogleFonts.poppins()
                            .copyWith(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
