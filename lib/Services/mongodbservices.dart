import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';
class MongoServices{
connectDb()async{
  // final mongodb=await Db.create("mongodb+srv://admin:flutter123456@fluttercluster.pjrgqfl.mongodb.net/test");
  // mongodb.open();
}
insertDb(documents)async {
  print(documents);
  final mongodb = await Db.create(
      "mongodb+srv://admin:flutter123456@fluttercluster.pjrgqfl.mongodb.net/ImageStore");
  await mongodb.open();
  var ret = await mongodb.collection("Images").insertOne(documents);
  if(!ret.isSuccess)
    {
      print("Errror ");
      Fluttertoast.showToast(
        msg: "There Was Some Error Please Try Again"
      );

    }
  else{
    Fluttertoast.showToast(
        msg: "The Images Were Uploaded Successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      textColor: Colors.black,

    );

    print("Hurray");
  }
  Get.back();
  await mongodb.close();
}
}