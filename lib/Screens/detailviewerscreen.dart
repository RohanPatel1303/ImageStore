import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagestore/Screens/imageupload.dart';
import 'package:imagestore/Screens/loginscreen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    List data=Get.arguments;
    List<String> details=["Email","Password","Dropdown 1","DropDown 2"];
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.6,
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: ListView.builder(
                    itemCount: details.length,
                    itemBuilder: (context,index){
                      return
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            tileColor: Colors.blue,
                            title: Text(details[index]),
                            subtitle:data[index]==null?Text("No Data"):Text(data[index]),
                          ),
                        );

                    },
                    padding: const EdgeInsets.all(20),

                  ),
                ),
              ),
              ElevatedButton(onPressed: ()=>{
                Get.to(ImageUploadScreen())
              }, child: const Text("Upload Images"))
            ],
          ),
        ),
      ),
    );
  }
}
