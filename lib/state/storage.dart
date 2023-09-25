import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;

class StoreData {
  Future<String> uploadImageStorage(String childName, String uniqueFileName, File file) async{
    String downloadUrl = "";

    Reference referenceDirImage = _storage.ref().child(childName);
    Reference referenceImageToUpload = referenceDirImage.child(uniqueFileName);

    UploadTask uploadTask = referenceImageToUpload.putFile(file);

    try {
      TaskSnapshot snapshot = await uploadTask;
      downloadUrl = await snapshot.ref.getDownloadURL();
    } catch (e) {
      print(e.toString());
    }
    
    return downloadUrl;
  }

  Future<void> deleteImageStorage(String childName, String uniqueFileName) async {
    Reference referenceDirImage = _storage.ref().child(childName).child(uniqueFileName);
    referenceDirImage.delete();
  }

  Future<void> deleteImageFromUrl(String url) async {
    Reference referenceDirImage = _storage.refFromURL(url);
    referenceDirImage.delete();
  }
}