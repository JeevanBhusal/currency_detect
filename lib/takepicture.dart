import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'displaypicture.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);
  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    //to display current output from camera creating controller for camera
    _controller = CameraController(
      //get specific camera from list of available camera
      widget.camera,
      //define resolution to use
      ResolutionPreset.medium,
    );

    //Next intialize the controller . this return future
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    //dispose the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //fill out this container in futhur steps
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Currency Detection'),
        ),
      ),
      //use CameraPreview to display the cameras feed

      body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              //if the future is complete display  preview
              return CameraPreview(_controller);
            } else {
              //otherwise preview a loading indicator
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),

      //take a picture from CameraController

      //for floating action button
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Container(
              height: 180.0,
              width: 180.0,
              child: FittedBox(
                child: FloatingActionButton(
                  //provide onpressed callback
                  onPressed: () async {
                    try {
                      //ensure camera is initialized
                      await _initializeControllerFuture;
                      //attempt to take a picture and log where its been saved
                      final image = await _controller.takePicture();
                      File imagefile = File(image.path);

                      //if the picture is displayed  wich was tsken
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DisplayPictureScreen(
                            imageFile: imagefile,
                          ),
                        ),
                      );
                    } catch (e) {
                      //if any error occur
                      print(e);
                    }
                  },
                  child: const Icon(Icons.camera_alt),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
