import 'package:equatable/equatable.dart';
import 'package:wanalearn/core/resources/media.dart';

class PageContent extends Equatable {
  const PageContent({
    required this.image,
    required this.title,
    required this.description,
  });

  const PageContent.first()
      : this(
          image: Media.casualReading,
          title: 'Brand new curriculum',
          description: 'This is the first online education platform designed'
              " the world's top professors",
        );

  const PageContent.second()
      : this(
          image: Media.casualLife,
          title: 'Brand a fun atmosphere',
          description: 'This is the first online education platform designed'
              " the world's top professors",
        );  

  const PageContent.third()
      : this(
          image: Media.casualMeditationScience,
          title: 'Easy to join the lesson',
          description: 'This is the first online education platform designed'
              " the world's top professors",
        );    

  final String image;
  final String title;
  final String description;

  @override
  List<Object?> get props => [image, title, description];
}
