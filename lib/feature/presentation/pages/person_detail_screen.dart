import 'package:app/common/app_colors.dart';
import 'package:app/feature/domain/enities/person_entity.dart';
import 'package:app/feature/presentation/widgets/person_cache_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonDetailPage extends StatelessWidget {
  PersonEntity person;
  PersonDetailPage({required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Character"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 24,),
            Text(person.name,style: TextStyle(fontSize: 28,color: Colors.white, fontWeight: FontWeight.w800),),
            SizedBox(height: 12,),
            Container(
              child: PersonCacheImage(imageUrl: person.image, height: 260, width: 260),
            ),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: person.status == 'Alive' ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(8)
                  ),
                ),
                SizedBox(width: 8,),
                Text(person.status,style: TextStyle(color: Colors.white,fontSize: 16),maxLines: 1,),

              ],
            ),
            SizedBox(height: 16,),
            if(person.type.isNotEmpty)  ..._buildText("Type:", person.type),
            ..._buildText("Gender:", person.gender),
            ..._buildText("Number of episodes:", person.episode.length.toString()),
            ..._buildText("Species:", person.species),
            ..._buildText("Last known locatiton:", person.location.name),
            ..._buildText("Origin:", person.origin.name),
            ..._buildText("Was Created:", person.created.toString())


          ],
        ),
      ),
    );
  }

  List<Widget> _buildText(String text,String value) {
    return [
      Text(text,style: TextStyle(color: AppColors.greyColor),),
      SizedBox(height: 4,),
      Text(value,style: TextStyle(color: Colors.white),),
      SizedBox(height: 12,),
    ];

  }
}
