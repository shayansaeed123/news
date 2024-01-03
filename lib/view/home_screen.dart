import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news/model/news_channel_headlines_model.dart';
import 'package:news/res/component/filter_list.dart';
import 'package:news/utils/routes/routes_names.dart';
import 'package:news/view/news_details_screen.dart';
import 'package:news/view_model/news_view_model.dart';

import '../model/categories_news_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  NewsViewModel newsViewModel = NewsViewModel();
  Connectivity connectivity = Connectivity();
  FilterList? selectedItem;
  final  dateFormat = DateFormat("MMMM dd, yyyy");
  String name = 'bbc-news';
  String categoriesName = 'Sports';
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      appBar: AppBar(
        title: Text("News", style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.pushNamed(context, RoutesNames.categories);
          },
          icon: Image.asset(
              'assets/images/category_icon.png',
            height: 35,
            width: 35,
          ),
        ),
        actions: [
          PopupMenuButton<FilterList>(
            icon: Icon(Icons.more_vert,color: Colors.black),
              initialValue: selectedItem,
              onSelected: (FilterList item){
              if(FilterList.bbcNews.name == item.name){
                name = 'bbc-news';
              }
              if(FilterList.aryNews.name == item.name){
                name = 'ary-news';
              }
              if(FilterList.cnnNews.name == item.name){
                name = 'cnn';
              }
              if(FilterList.argaamNews.name == item.name){
                name = 'argaam';
              }
              if(FilterList.bbcSportNews.name == item.name){
                name = 'bbc-sport';
              }
              if(FilterList.alJazeeraNews.name == item.name){
                name = 'al-jazeera-english';
              }
              // newsViewModel.fetchNewsChannelHeadlineApi();
              setState(() {
                selectedItem = item;
              });
              },
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<FilterList>>[
                  PopupMenuItem<FilterList>(
                    child: Text("BBC News", style: TextStyle(color: Colors.black),),
                    value: FilterList.bbcNews,
                  ),
                  PopupMenuItem<FilterList>(
                    child: Text("Ary News", style: TextStyle(color: Colors.black),),
                    value: FilterList.aryNews,
                  ),
                  PopupMenuItem<FilterList>(
                    child: Text("CNN News", style: TextStyle(color: Colors.black),),
                    value: FilterList.cnnNews,
                  ),PopupMenuItem<FilterList>(
                    child: Text("Argaam News", style: TextStyle(color: Colors.black),),
                    value: FilterList.argaamNews,
                  ),PopupMenuItem<FilterList>(
                    child: Text("BBC Sport News", style: TextStyle(color: Colors.black),),
                    value: FilterList.bbcSportNews,
                  ),
                  PopupMenuItem<FilterList>(
                    child: Text("al-jazeera English", style: TextStyle(color: Colors.black),),
                    value: FilterList.alJazeeraNews,
                  ),


                ];
              },
          )
        ],
      ),
      body: StreamBuilder<ConnectivityResult>(
        stream: connectivity.onConnectivityChanged,
        builder: (context, snapshot) {
          return InternetConnectionWidget(
              snapshot: snapshot,
              widget: ListView(
                children: [
                  SizedBox(
                    height: height * .50,
                    child: FutureBuilder(
                      future: newsViewModel.fetchNewsChannelHeadlineApi(name),
                      builder: (context,AsyncSnapshot<NewsChannelHeadlinesModel> snapshot) {
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
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.articles!.length,
                            itemBuilder: (context, index) {
                              DateTime date = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return NewsDetailsScreen(
                                        newsTitle: snapshot.data!.articles![index].title.toString(),
                                        newsImage: snapshot.data!.articles![index].urlToImage.toString(),
                                        nwsContent: snapshot.data!.articles![index].content.toString(),
                                        newsSource: snapshot.data!.articles![index].source!.name.toString(),
                                        newsDescription: snapshot.data!.articles![index].description.toString(),
                                        newsAuthor: snapshot.data!.articles![index].author.toString(),
                                        newsDate: dateFormat.format(date));
                                  },));
                                },
                                child: SizedBox(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: height * 0.6,
                                        width: width * 0.9,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: height * .02
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => spinKit,
                                            errorWidget: (context, url, error) => Icon(Icons.error_outline,color: Colors.red),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(11),
                                          ),
                                          child: Container(
                                            alignment: Alignment.bottomCenter,
                                            height: height * .22,
                                            padding: EdgeInsets.all(width*.03),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: width * 0.7,
                                                  child: Text(
                                                    snapshot.data!.articles![index].title.toString(),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(fontSize: 17,fontWeight: FontWeight.w700, color: Colors.black),
                                                  ),
                                                ),
                                                Spacer(),
                                                Container(
                                                  width: width * 0.7,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        snapshot.data!.articles![index].source!.name.toString(),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w600, color: Colors.black),
                                                      ),
                                                      Text(
                                                        dateFormat.format(date),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w500, color: Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
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
                  Padding(
                    padding: EdgeInsets.all(20),
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
                            primary: false,
                            shrinkWrap: true,
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
                                          newsDate: dateFormat.format(date));
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
                                                    Text(dateFormat.format(date),
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
          );
        },
      )
    );
  }
}
class InternetConnectionWidget extends StatelessWidget {
  final AsyncSnapshot<ConnectivityResult> snapshot;
  final Widget widget;
  const InternetConnectionWidget({super.key, required this.snapshot, required this.widget});

  @override
  Widget build(BuildContext context) {
    switch(snapshot.connectionState){
      case ConnectionState.active:
        final state = snapshot.data!;
        switch(state){
          case ConnectivityResult.none:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.signal_wifi_connected_no_internet_4_outlined, size: 50,),
                  SizedBox(height: 10,),
                  Text("No Internet Connection", style: TextStyle(color: Colors.black,fontSize: 30),)
                ],
              ),
            );
          default:
            return widget;
        }
      default:
        return Container();
    }
  }
}

const spinKit = SpinKitWave(
  color: Colors.black,
  size: 25,
);