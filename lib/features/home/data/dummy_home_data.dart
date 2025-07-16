import '../domain/entities/destination_entity.dart';

class DummyHomeData {
  static List<DestinationEntity> fetchRecommendedDestinations() => [
    DestinationEntity(
      id: 'dest-1',
      title: '제주도',
      imageUrl: 'assets/flags/jeonju.png',
    ),
    DestinationEntity(
      id: 'dest-2',
      title: '스페인',
      imageUrl: 'assets/flags/spain.png',
    ),
    DestinationEntity(
      id: 'dest-3',
      title: '발리',
      imageUrl: 'assets/flags/bali.png',
    ),
    DestinationEntity(
      id: 'dest-4',
      title: '스위스',
      imageUrl: 'assets/flags/switzerland.png',
    ),
  ];
}
