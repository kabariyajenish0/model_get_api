import 'package:flutter/material.dart';
import 'package:model_get_api/Model/product_model.dart';

import 'package:model_get_api/Services/get_products.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.black,
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        title: Text(
          "Product",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Icon(
            Icons.search,
            color: Colors.white,
          )
        ],
      ),
      //  backgroundColor: Colors.deepPurple.shade100,
      body: FutureBuilder(
        future: ProductServices.getProducts(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final products = snapshot.data![index];
                return Container(
                  height: 100,
                  width: 365,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellow),
                      boxShadow: [
                        BoxShadow(color: Colors.black54, blurRadius: 3)
                      ],
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue,
                          image: DecorationImage(
                              image: NetworkImage(products.image.toString()),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: "Title :",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                  children: [
                                    TextSpan(
                                        text: "${products.title.toString()}",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15))
                                  ]),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                  text: "Price :",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                  children: [
                                    TextSpan(
                                        text:
                                            " \u{20B9} ${products.price * 82.round().toDouble()}",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15))
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
