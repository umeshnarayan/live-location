import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live location',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'New liva location'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

final GeolocatorPlatform _geolocatorPlatform =GeolocatorPlatform.instance;

var currentAddress='';
@override
  void initState () {

  final GeolocatorPlatform _geolocatorPlatform =GeolocatorPlatform.instance;
  getCurrentLastLong();

  super.initState();
    }

Future<void>getCurrentLastLong() async{
  final myPosition = await _geolocatorPlatform.getCurrentPosition();

  getAddress(myPosition).then((value) {
print(value);




setState(() {
  currentAddress=value;
});
  });
}

Future<String>getAddress(Position position)async{

  if(position.latitude!=null || position.longitude!=null){
try{
    var currentPlace =await placemarkFromCoordinates(position.latitude, position.longitude);

    if(currentPlace!=null && currentPlace.isNotEmpty){
      final Placemark place =currentPlace.first;

      return"  ${place.name},${place.thoroughfare},${place.subLocality},${place.locality},${place.administrativeArea},${place.postalCode},${place.country}";

  }

  }

  on Exception catch( exception){
  print("location exception"+exception.toString());
  return"${position.latitude},${position.latitude}";
}

  catch(e) {
    return "${position.latitude},${position.longitude}";
  }
  }
 else{
 return"vivek";
 }

 return"No address found";

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text("Your current location is: "),
Text(currentAddress)


          ]
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
