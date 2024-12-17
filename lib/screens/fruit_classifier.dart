import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imgTools; // Import image library
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class FruitsClassifier extends StatefulWidget {
  const FruitsClassifier({super.key});

  @override
  _FruitsClassifierState createState() => _FruitsClassifierState();
}

class _FruitsClassifierState extends State<FruitsClassifier> {
  File? _image;
  String _predictedLabel = "No prediction yet";
  bool _loading = false;

  late Interpreter _interpreter; // Interpréteur TFLite pour la classification

  // Liste des labels
  final List<String> _labels = ["apple", "banana","grape","kiwi","orange","pear","pineapple","pomegranate","strawberry","watermelon"];

  @override
  void initState() { // Initialisation du widget et chargement du modèle
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      // Charger le modèle depuis les assets
      _interpreter = await Interpreter.fromAsset('assets/models/bmodel.tflite');
      print("Modèle chargé avec succès.");
    } catch (e) {
      print("Erreur lors du chargement du modèle : $e");
    }
  }

  /// Prétraitement de l'image : redimensionner et convertir en tableau normalisé
  Float32List _processImage(File imageFile) {
    // Charger l'image
    final originalImage = imgTools.decodeImage(imageFile.readAsBytesSync())!;
    
    // Redimensionner l'image
    final resizedImage = imgTools.copyResize(originalImage, width: 32, height: 32);

    // Lire chaque pixel et normaliser
    Float32List tensor = Float32List(32 * 32 * 3); // Chaque pixel a trois composantes RGB

   for (int y = 0; y < 32; y++) {
    for (int x = 0; x < 32; x++) {
      // Récupérer la couleur du pixel à (x, y)
      imgTools.Pixel pixel = resizedImage.getPixel(x, y);

      // Normaliser les composantes RGB dans la plage [0, 1]
      tensor[(y * 32 + x) * 3] = pixel.r.toDouble(); // Composante rouge
      tensor[(y * 32 + x) * 3 + 1] = pixel.g.toDouble(); // Composante verte
      tensor[(y * 32 + x) * 3 + 2] = pixel.b.toDouble(); // Composante bleue
    }
  }

    return tensor;
  }

  /// Fonction pour trouver l'indice de la probabilité maximale
  int findIndex(List<double> outputs) {
    double maxOutput = double.negativeInfinity; // Initialiser la valeur maximale à -∞
    int maxIndex = -1;

    for (int i = 0; i < outputs.length; i++) {
      if (outputs[i] > maxOutput) {
        maxOutput = outputs[i];
        maxIndex = i;
      }
    }
    return maxIndex;
  }

  Future<void> _predictImage(File image) async { // Fonction pour effectuer une prédiction
    setState(() {
      _loading = true;
    });

    try {
      // Prétraiter l'image
      final input = _processImage(image);

      var inputBatch = input.reshape([1, 32, 32, 3]); // Ajouter une dimension pour le batch

      // Créer un buffer pour les résultats
      var output = List.filled(_labels.length, 0.0).reshape([1, _labels.length]);

      // Effectuer une prédiction
      _interpreter.run(inputBatch, output);

      // Trouver le label avec la probabilité maximale
      final predictedIndex = findIndex(output[0]);

      setState(() {
        _predictedLabel = _labels[predictedIndex];
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _predictedLabel = "Erreur : $e";
        _loading = false;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async { // Fonction pour choisir une image
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      setState(() {
        _image = imageFile;
      });
      await _predictImage(imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruits Classifier'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _image != null
              ? Image.file(
                  _image!,
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                )
              : const Icon(
                  Icons.image,
                  size: 100,
                  color: Colors.grey,
                ),
          const SizedBox(height: 20),
          Text(
            _predictedLabel,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _loading
              ? const CircularProgressIndicator()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Camera'),
                      onPressed: () => _pickImage(ImageSource.camera),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.photo),
                      label: const Text('Gallery'),
                      onPressed: () => _pickImage(ImageSource.gallery),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
