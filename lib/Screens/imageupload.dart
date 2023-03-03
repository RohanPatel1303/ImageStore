import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagestore/Services/mongodbservices.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({Key? key}) : super(key: key);

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final List<XFile> imglist=[];
  List<String> imglistbase64=[];
  ClickImages()async{
    final XFile? selected_img=await ImagePicker().pickImage(source: ImageSource.camera);
    if(selected_img!=null)
    {
      imglist.add(selected_img);
      setState(() {
      });
    }else{
      Get.dialog(
          AlertDialog(
            title: const Text("No Image Selected"),
            actions: [
              GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("Okay",style: TextStyle(fontWeight: FontWeight.bold)),
                  )
              )
            ],
            alignment: Alignment.center,
          )
      );
    }
  }
  UploadImages()async{

    if(imglist.isNotEmpty){
      Get.dialog(
          Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          ),
          barrierDismissible: false
      );
      imglistbase64=[];
      imglistbase64.toList(growable: true);
      imglist.forEach((element) async{
        Uint8List temp_byte=await element.readAsBytes();
        String temp_base64=base64Encode(temp_byte);
        imglistbase64.add(temp_base64.toString());
      });
      print(imglistbase64.length);
      print(imglistbase64);
      MongoServices().connectDb();
      MongoServices().insertDb(<String,dynamic>{"images":imglistbase64,"time":DateTime.now(),"imgcount":imglistbase64.length+1});
    }
   else{
      Get.dialog(
        barrierDismissible: true,
          AlertDialog(
            title: const Text("Please click a image before you proceed further."),
            actions: [
              GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("Okay",style: TextStyle(fontWeight: FontWeight.bold)),
                  )
              )
            ],
            alignment: Alignment.center,
          )
      );
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Image Select Screen"),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(flex: 3,
              child: GridView.builder(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 40),
                  itemCount: imglist.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return
                      Stack(
                        children: [
                          Image.file(File(imglist[index].path),fit: BoxFit.fill,),
                          Positioned(
                            right: 30,
                            child: GestureDetector(

                              child: const Icon(Icons.cancel_rounded,color: Colors.red),
                              onTap: ()=>{
                                imglist.toList(growable: true),
                                imglist.removeAt(index),
                                // itemList.removeAt(0),
                                setState(() {
                                })
                              },
                            ),
                          )
                        ],
                      );
                  }),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  ElevatedButton(onPressed: ()=>{
                    ClickImages()
                  },
                    child:const Text("Click Image"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(onPressed: ()=>{
                    UploadImages()
                  },
                      child: const Text("Upload Image"))
                ],
              ),
            )
          ],
        )
    );
  }
}
