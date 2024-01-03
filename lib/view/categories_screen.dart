import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news/model/categories_news_model.dart';
import 'package:news/view_model/news_view_model.dart';

import 'home_screen.dart';
import 'news_details_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  NewsViewModel newsViewModel = NewsViewModel();
  Connectivity connectivity = Connectivity();
  final format = DateFormat("MMMM dd, yyyy");
  String categoriesName = 'general';
  List<String> listCategories = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology',
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Categories",style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: connectivity.onConnectivityChanged,
        builder: (context, snapshot) {
          return InternetConnectionWidget(
              snapshot: snapshot,
              widget: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.06,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: listCategories.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              categoriesName = listCategories[index];
                              setState(() {

                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: width * 0.03,top: width * 0.02),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: categoriesName == listCategories[index] ? Colors.black : Colors.grey,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                                  child: Center(child: Text(listCategories[index].toString(),style: GoogleFonts.poppins().copyWith(color: Colors.white),)),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder(
                        future: newsViewModel.fetchCategoriesNewsApi(categoriesName),
                        builder: (context,AsyncSnapshot<CategoriesNewsModel> snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Container(
                              child: Center(
                                child: SpinKitWave(
                                  color: Colors.black,
                                  size: 40,
                                ),
                              ),
                            );
                          }else{
                            return ListView.builder(
                              itemCount: snapshot.data!.articles!.length,
                              itemBuilder: (context, index) {
                                DateTime date = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                                return Padding(
                                  padding: EdgeInsets.only(top: height * 0.02),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return NewsDetailsScreen(
                                            newsTitle: snapshot.data!.articles![index].title.toString(),
                                            newsImage: snapshot.data!.articles![index].urlToImage.toString(),
                                            nwsContent: snapshot.data!.articles![index].content.toString(),
                                            newsSource: snapshot.data!.articles![index].source!.name.toString(),
                                            newsDescription: snapshot.data!.articles![index].description.toString(),
                                            newsAuthor: snapshot.data!.articles![index].author.toString(),
                                            newsDate: format.format(date));
                                      },));
                                    },
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            height: height * 0.2,
                                            width: width * 0.3,
                                            imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => spinKit,
                                            errorWidget: (context, url, error) => Icon(Icons.error_outline,color: Colors.red),
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                              height: height * .2,
                                              padding: EdgeInsets.only(left: width * 0.03),
                                              child: Column(
                                                children: [
                                                  Text(snapshot.data!.articles![index].title.toString(),
                                                      maxLines: 3,
                                                      style: GoogleFonts.poppins().copyWith(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 15)),
                                                  Spacer(),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(snapshot.data!.articles![index].source!.name.toString(),
                                                          style: GoogleFonts.poppins().copyWith(
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 14)),
                                                      Text(format.format(date),
                                                          style: GoogleFonts.poppins().copyWith(
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 15)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                        ),

                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
          );
        },
      )
    );
  }
}
