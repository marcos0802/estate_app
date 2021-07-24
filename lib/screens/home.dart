import 'package:estate_app/data/data.dart';
import 'package:estate_app/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EstateApp extends StatefulWidget {
  const EstateApp({Key? key}) : super(key: key);

  @override
  _EstateAppState createState() => _EstateAppState();
}

class _EstateAppState extends State<EstateApp> {
  List<Property> properties = getPropertyList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      // SEARCH INPUT FIELD

      Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 20.0),
        child: TextField(
          style: TextStyle(
              fontSize: 20.0, height: 1.0, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
              // prefix: Icon(Icons.menu, size: 28, color: Colors.grey[400]!),
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.grey[400]!, fontSize: 20.0),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              suffixIcon: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Icon(
                  Icons.search,
                  size: 28,
                  color: Colors.grey[400]!,
                ),
              )),
        ),
      ),

      //FILTER WIDGET

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Container(
                height: 40.0,
                child: Stack(
                  children: [
                    ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildFilter("Home"),
                        _buildFilter("Bedrooms"),
                        _buildFilter("Security"),
                        _buildFilter("Parking"),
                        _buildFilter("Swimming Pool"),
                        _buildFilter("Price")
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 20,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                stops: [
                              0.0,
                              1.0
                            ],
                                colors: [
                              Theme.of(context).scaffoldBackgroundColor,
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.0)
                            ])),
                      ),
                    )
                  ],
                ),
              )),
              Text(
                'Filter',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),

      SizedBox(height: 20.0),

      Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: buildProperties())))
    ]));
  }

  Widget _buildFilter(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  List<Widget> buildProperties() {
    List<Widget> list = [];
    for (var i = 0; i < properties.length; i++) {
      list.add(Hero(
        tag: properties[i].frontImage,
        child: buildProperty(properties[i], i),
      ));
    }
    return list;
  }

  Widget buildProperty(Property property, int index) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (_) => Details(
                    property: property,
                  ))),
      child: Card(
        margin: EdgeInsets.only(bottom: 24.0),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Container(
          height: 210.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(property.frontImage), fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                  0.5,
                  1.0
                ],
                    colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7)
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 40,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.yellow[700]!,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Center(
                      child: Text(
                    property.label,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0),
                  )),
                ),
                Expanded(child: Container()),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 5.0, left: 12.0, right: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(property.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(r"$" + property.price,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20.0, left: 12.0, right: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDescription(Icons.location_on, Colors.white,
                              property.location),
                          _buildDescription(Icons.zoom_out_map, Colors.white,
                              property.sqm + "/sqm"),
                          _buildDescription(Icons.star, Colors.yellow[700]!,
                              property.review + "Review")
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDescription(IconData icon, Color color, String description) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        Text(
          description,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
