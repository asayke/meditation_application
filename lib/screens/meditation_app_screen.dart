import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meditation_application/models/item_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MeditationAppScreen extends StatefulWidget {
  const MeditationAppScreen({super.key});

  @override
  State<MeditationAppScreen> createState() => _MeditationAppScreenState();
}

class _MeditationAppScreenState extends State<MeditationAppScreen> {

  final List<Item> items = [
    Item(audioPath: "meditations_audios/forest.mp3", imagePath: "meditations_images/forest.jpeg", name: "Forest"),
    Item(audioPath: "meditations_audios/night.mp3", imagePath: "meditations_images/night.jpeg", name: "Night"),
    Item(audioPath: "meditations_audios/ocean.mp3", imagePath: "meditations_images/ocean.jpeg", name: "Ocean"),
    Item(audioPath: "meditations_audios/waterfall.mp3", imagePath: "meditations_images/waterfall.jpeg", name: "Waterfall"),
    Item(audioPath: "meditations_audios/wind.mp3", imagePath: "meditations_images/wind.jpeg", name: "Wind")
  ];

  final AudioPlayer audioPlayer = AudioPlayer();
  int? playingIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(items[index].imagePath)) 
                  ),
                child: ListTile(
                title: Text(items[index].name),
                leading: IconButton(
                  icon: playingIndex == index ? const FaIcon(FontAwesomeIcons.stop) : const FaIcon(FontAwesomeIcons.play),
                  onPressed:() async {
                    if(playingIndex == index) {
                      audioPlayer.stop();

                      setState(() {
                        playingIndex = null;
                    });
                    }
                    else {
                      await audioPlayer.setAsset(items[index].audioPath).catchError((onError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red.withOpacity(0.5),
                          content: const Text("An error has occured")));
                      });
                      audioPlayer.play();
                    
                      setState(() {
                        playingIndex = index;
                    });
                    }
                  } ,
                  ),
                ),
              ),
            ); 
          },
          ),
        ),
    );
  }
}