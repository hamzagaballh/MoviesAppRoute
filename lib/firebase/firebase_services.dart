import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/user_model.dart';

class FirebaseServices {
  static CollectionReference<MovieModel> getCollection() => getUserCollection()
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('watchList')
      .withConverter<MovieModel>(
          fromFirestore: (snapshot, _) =>
              MovieModel.fromJson(snapshot.data() ?? {}),
          toFirestore: (value, _) => value.toJson());
  static CollectionReference<UserModel> getUserCollection() =>
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
          fromFirestore: (snapshot, _) =>
              UserModel.fromJson(snapshot.data() ?? {}),
          toFirestore: (value, _) => value.toJson());
  static Stream<List<MovieModel>> getWatchList() async* {
    CollectionReference<MovieModel> collection = getCollection();
    Stream<QuerySnapshot<MovieModel>> query = collection.snapshots();
    Stream<List<MovieModel>> data =
        query.map((event) => event.docs.map((e) => e.data()).toList());
    yield* data;
  }

  static Future<void> addMovieWatchList(MovieModel movie) async {
    final collection = getCollection();
    if (!await existMovie(movie.results.id.toString())) {
      await collection.doc(movie.results.id.toString()).set(movie);
    }
  }

  static Future<bool> existMovie(String id) async {
    final collection = getCollection();
    final movieId = id;
    final existingMovie = await collection.doc(movieId.toString()).get();
    if (existingMovie.exists) {
      return true;
    }
    return false;
  }

  static Future<void> deleteMovieWatchList(MovieModel movie) {
    CollectionReference<MovieModel> collection = getCollection();
    return collection.doc(movie.results.id.toString()).delete();
  }

  static Future<UserModel?> login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return getUser();
  }

  static Future<UserModel> signup(UserModel userModel, String password) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: userModel.email!, password: password);
    userModel.id = credential.user?.uid;
    await createUser(userModel);
    return userModel;
  }

  static Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<UserModel?> getUser() async {
    DocumentSnapshot<UserModel> documentSnapshot = await getUserCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return documentSnapshot.data();
  }

  static Future<void> createUser(UserModel userModel) async {
    return await getUserCollection().doc(userModel.id).set(userModel);
  }
}
