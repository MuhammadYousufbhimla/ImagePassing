import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:image_picker/image_picker.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
    ),
  );
}

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
    XFile? image;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
 Future getImagefromcamera() async {
    image = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      image = image;
    });
  }

  Future getImagefromGallery() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      image = image;
    });
  }
  @override
  void initState() {
    super.initState();
 
    _controller = CameraController(
    
      widget.camera,
   
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
     
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
   
            return CameraPreview(_controller);
          } else {
        
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: ExpandableFab(
  distance: 112.0,
  children: [
    FloatingActionButton.small(
        child: const Icon(Icons.camera),
        onPressed: () {},
      ),
    
   FloatingActionButton.small(
        child: const Icon(Icons.browse_gallery),
        onPressed: () {},
      ),
  ],
)

  //     floatingActionButton: FloatingActionButton(
      
  //       onPressed: () async {
    
  //         selectedPhoto(context);
  //         try {
  //           await _initializeControllerFuture;
  // image = await ImagePicker().pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     image = image;
  //   });
  //           // final image = await _controller.takePicture();

  //           if (!mounted) return;

         
  //           await Navigator.of(context).push(
  //             MaterialPageRoute(
  //               builder: (context) => DisplayPictureScreen(
  //                 imagePath: image!.path,
  //               ),
  //             ),
  //           );
  //         } catch (e) {
          
  //           print(e);
  //         }
  //       },
  //       child: const Icon(Icons.camera_alt),
  //     ),
    
    );
  }
}

 void selectedPhoto(BuildContext context) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Center(
                  child: Text(
         "",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              )),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () async {
                            // Navigator.of(context).pop();
                            // getImagefromGallery();
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => GeneratePage()
                            //     ));
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.05,
                                left: MediaQuery.of(context).size.width * 0.05),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.upload_file,
                                  color: Color(0xff3f3754),
                                  size: 40,
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0xff8440fa).withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Upload file',
                                  style: TextStyle(
                                      color: Color(0xff3f3754),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            // Navigator.of(context).pop();
                            // getImagefromcamera();
                            //  Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => GeneratePage()
                            //     ));

                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.05,
                                left: MediaQuery.of(context).size.width * 0.05),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  color: Color(0xff3f3754),
                                  size: 40,
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0xff8440fa).withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Camera",
                                  style: TextStyle(
                                      color: Color(0xff3f3754),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ]));
 });
    
      





// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Container(
        margin: EdgeInsets.all(30),
        color: Colors.blue,
        height: 100,
        child:  (Image!=null)
        ? Container(
                            height: MediaQuery.of(context).size.height * 0.28,
                            width: MediaQuery.of(context).size.width * 0.75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(
                                image: FileImage(File(imagePath)),
                              
                                fit: BoxFit.fill,
                              ),
                            ))
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.27,
                            width: MediaQuery.of(context).size.width * 0.77,
                            decoration: BoxDecoration(
                              color: Color(0xff8440fa),
                              borderRadius: BorderRadius.circular(25),
                            )
                        
                            
                        )
        

      ),
      
   
    );
  }

}