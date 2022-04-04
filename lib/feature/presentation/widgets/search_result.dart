import 'package:app/feature/domain/enities/person_entity.dart';
import 'package:app/feature/presentation/pages/person_detail_screen.dart';
import 'package:app/feature/presentation/widgets/person_cache_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  final PersonEntity personResult;

  SearchResult({required this.personResult});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PersonDetailPage(person: personResult)));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: PersonCacheImage(imageUrl: personResult.image, width: double.infinity,height: 300,),
            ),
            Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  personResult.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                )),
            Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  personResult.location.name,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }
}
