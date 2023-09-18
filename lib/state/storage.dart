import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;

class StoreData {
  Future<String> uploadImageStorage(String childName, File file) async{
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
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
}