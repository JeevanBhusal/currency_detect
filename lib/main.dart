import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'takepicture.dart';

//get a list of the available cameras
int total = 0;
Future<void> main() async {
  //ensure that plugin services are intialized so that availableCameras() can be called
  WidgetsFlutterBinding.ensureInitialized();
  //obtsain a list of available cameras
  final cameras = await availableCameras();
  //get a specific camera from list of available camersas
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: TakePictureScreen(
        //pass the appropriate camera to the TakePictureScreen widget
        camera: firstCamera,
      ),
    ),
  );
}

//create and intialize the CameraController

// class TakePictureScreen extends StatefulWidget {
//   final CameraDescription camera;
//   const TakePictureScreen({
//     Key? key,
//     required this.camera,
//   }) : super(key: key);

//   @override
//   _TakePictureScreenState createState() => _TakePictureScreenState();
// }

// class _TakePictureScreenState extends State<TakePictureScreen> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     //to display current output from camera creating controller for camera
//     _controller = CameraController(
//       //get specific camera from list of available camera
//       widget.camera,
//       //define resolution to use
//       ResolutionPreset.medium,
//     );

//     //Next intialize the controller . this return future
//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     //dispose the controller when the widget is disposed
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //fill out this container in futhur steps
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text('Currency Detection'),
//         ),
//       ),

// //use CameraPreview to display the cameras feed

//       body: FutureBuilder<void>(
//           future: _initializeControllerFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               //if the future is complete display  preview
//               return CameraPreview(_controller);
//             } else {
//               //otherwise preview a loading indicator
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           }),

//       //take a picture from CameraController

//       //for floating action button
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Center(
//             child: Container(
//               height: 180.0,
//               width: 180.0,
//               child: FittedBox(
//                 child: FloatingActionButton(
//                   //provide onpressed callback
//                   onPressed: () async {
//                     try {
//                       //ensure camera is initialized
//                       await _initializeControllerFuture;
//                       //construct the path where image is saved
//                       final path = join(
//                         //store the image in temp directory
//                         //find the temp directory using the pathprovider
//                         (await getTemporaryDirectory()).path,
//                         //'${DateTime.now()}.png',
//                       );
//                       //attempt to take a picture and log where its been saved
//                       await _controller.takePicture();
//                       //if the picture is displayed  wich was tsken
//                       await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => DisplayPictureScreen(path),
//                         ),
//                       );
//                     } catch (e) {
//                       //if any error occur
//                       print(e);
//                     }
//                   },
//                   child: const Icon(Icons.camera_alt),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// //a widget that displays the picture taken by user

// class DisplayPictureScreen extends StatefulWidget {
//   final String imagePath;
//   DisplayPictureScreen(this.imagePath);
//   @override
//   _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
// }

// class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
//   late List op;
//   late Image img;

//   @override
//   void initState() {
//     super.initState();
//     loadModel().then((value) {
//       setState(() {});
//       img = Image.file(File(widget.imagePath));
//       classifyImage(widget.imagePath, total);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Display the picture')),
//       body: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Expanded(child: Center(child: img)),
//             SizedBox(
//               height: 20,
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> runTextToSpeech(String outputMoney, int totalMoney) async {
//     FlutterTts flutterTts;
//     //creating an instance of flutterTts
//     flutterTts = new FlutterTts();

//     if (outputMoney == "five") {
//       String tot = totalMoney.toString();
//       print(tot);

//       String speakString = "Five Rupees, your total money is , $tot";
//       await flutterTts.setSpeechRate(0.8);
//       await flutterTts.awaitSpeakCompletion(true);
//       await flutterTts.speak(speakString);
//     }
//     if (outputMoney == "ten") {
//       String tot = totalMoney.toString();
//       print(tot);

//       String speakString = "ten Rupees, your total money is , $tot";
//       await flutterTts.setSpeechRate(0.8);
//       await flutterTts.awaitSpeakCompletion(true);
//       await flutterTts.speak(speakString);
//     }

//     if (outputMoney == "twenty") {
//       String tot = totalMoney.toString();
//       print(tot);

//       String speakString = "Twenty Rupees, your total money is , $tot";
//       await flutterTts.setSpeechRate(0.8);
//       await flutterTts.awaitSpeakCompletion(true);
//       await flutterTts.speak(speakString);
//     }
//     if (outputMoney == "fifty") {
//       String tot = totalMoney.toString();
//       print(tot);

//       String speakString = "Fifty Rupees, your total money is , $tot";
//       await flutterTts.setSpeechRate(0.8);
//       await flutterTts.awaitSpeakCompletion(true);
//       await flutterTts.speak(speakString);
//     }
//     if (outputMoney == "hundred") {
//       String tot = totalMoney.toString();
//       print(tot);

//       String speakString = "Hundred Rupees, your total money is , $tot";
//       await flutterTts.setSpeechRate(0.8);
//       await flutterTts.awaitSpeakCompletion(true);
//       await flutterTts.speak(speakString);
//     }
//     if (outputMoney == "fivehundred") {
//       String tot = totalMoney.toString();
//       print(tot);

//       String speakString = "Fivehundred Rupees, your total money is , $tot";
//       await flutterTts.setSpeechRate(0.8);
//       await flutterTts.awaitSpeakCompletion(true);
//       await flutterTts.speak(speakString);
//     }
//     if (outputMoney == "thousand") {
//       String tot = totalMoney.toString();
//       print(tot);

//       String speakString = "Thousand Rupees, your total money is , $tot";
//       await flutterTts.setSpeechRate(0.8);
//       await flutterTts.awaitSpeakCompletion(true);
//       await flutterTts.speak(speakString);
//     }
//   }

//   classifyImage(String image, int total) async {
//     var output = await Tflite.runModelOnImage(
//       path: image,
//       numResults: 5,
//       threshold: 0.5,
//       imageMean: 127.5,
//       imageStd: 127.5,
//     );
//     op = output!;
//     if (op != null) {
//       if (op[0]["label"] == "five") {
//         total += 5;
//         runTextToSpeech("five", total);
//       }
//       if (op[0]["label"] == "ten") {
//         total += 5;
//         runTextToSpeech("ten", total);
//       }
//       if (op[0]["label"] == "twenty") {
//         total += 5;
//         runTextToSpeech("twenty", total);
//       }
//       if (op[0]["label"] == "fifty") {
//         total += 5;
//         runTextToSpeech("fifty", total);
//       }
//       if (op[0]["label"] == "hundred") {
//         total += 5;
//         runTextToSpeech("hundred", total);
//       }
//       if (op[0]["label"] == "fivehundred") {
//         total += 5;
//         runTextToSpeech("fivehundred", total);
//       }
//       if (op[0]["label"] == "thousand") {
//         total += 5;
//         runTextToSpeech("thousand", total);
//       }
//     } else {
//       runTextToSpeech("not found", total);
//     }
//   }

//   loadModel() async {
//     await Tflite.loadModel(
//       model: "assets/model_unquant.tflite",
//       labels: "assets/labels.txt",
//     );
//   }

//   @override
//   void dispose() {
//     Tflite.close();
//     super.dispose();
//   }
// }
