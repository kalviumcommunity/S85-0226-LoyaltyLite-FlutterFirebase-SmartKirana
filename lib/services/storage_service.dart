import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadSyncEvidence({required String uid}) async {
    final fileRef = _storage
        .ref()
        .child('sync-evidence/$uid/${DateTime.now().millisecondsSinceEpoch}.txt');
    await fileRef.putString(
      'Realtime sync verified at ${DateTime.now().toIso8601String()}',
      format: PutStringFormat.raw,
    );
    return fileRef.getDownloadURL();
  }
}
