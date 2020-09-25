import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final kGoogleApiKey = "YOUR API KEY";

  String pickedAddress = 'null';

  Future<void> _getPlace() async {
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      mode: Mode.overlay, // Mode.fullscreen
      language: "en",
      // For Filtering by country.
      // components: [new Component(Component.country, "in")]
    );
    _getLatLng(p);
  }

  Future<void> _getLatLng(Prediction prediction) async {
    GoogleMapsPlaces _places = new GoogleMapsPlaces(
        apiKey:
            'YOUR API KEY'); //Same API_KEY as above
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(prediction.placeId);
    double latitude = detail.result.geometry.location.lat;
    double longitude = detail.result.geometry.location.lng;
    String address = prediction.description;

    //print('$latitude \n $longitude \n $address');
    setState(() {
      pickedAddress = 'Latitude: $latitude \n Longitude: $longitude \n Address: $address';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AutoComplete Places'),
      ),
      body: Container(
        color: Colors.blueGrey[50],
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: _getPlace,
              child: Text('Pick place',
                  style: GoogleFonts.roboto(color: Colors.white)),
              color: Colors.blue,
            ),
            SizedBox(height: 15),
            Card(
              margin: EdgeInsets.all(10),
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(pickedAddress,
                      style: GoogleFonts.roboto(color: Colors.black), textAlign: TextAlign.center,)),
            ),
          ],
        ),
      ),
    );
  }
}
