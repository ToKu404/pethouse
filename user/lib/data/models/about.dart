class DataAppModel {
  String title='Pethouse';
  String description="""Kemajuan ilmu pengetahuan mendorong berbagai inovasi yang memicu perkembangan teknologi salah satunya adalah perkembangan aplikasi dari berbagai platform untuk membantu kebutuhan manusia. Hewan merupakan salah satu makhluk hidup yang sangat dekat dengan kehidupan manusia. Hal ini menimbulkan banyaknya niat manusia untuk memelihara hewan di sekitar. Proses pemeliharaan hewan tersebut tentu saja memerlukan banyak prosedur untuk menjaga hewan tetap sehat. Pemeliharaan Hewan dengan perawatan rutin merupakan hal yang kerap kali menyulitkan bagi para pecinta hewan untuk menjaga seluruh kebiasaan sesuai dengan jadwal. Dengan dibuatnya aplikasi ini diharapkan dapat memudahkan masyarakat yang khususnya pecinta hewan dapat memantau kondisi dan jadwal pemeliharaan hewan.""";
  String programming_leng = 'Dart';
  String framework='Flutter';
  String database='Firestore';
  String logo = 'assets/icons/pethouse_icon.svg';

}

class DataAssets {
  String name;
  String link;

  DataAssets({required this.name, required this.link});
}
class DataPackages {
  String name;
  String link;
  String version;

  DataPackages({required this.name,required this.version, required this.link});
}



var dataAssetsList = [
  //FREEPIK
  DataAssets(name: 'Freepik', link: 'https://www.freepikcompany.com/')
];

var dataPackagesList = [
  //Google Fonts
  DataPackages(name: 'google_fonts', version: '2.0.3', link: 'https://pub.dev/packages/google_fonts'),

  //Flutter SVG
  DataPackages(name: 'flutter_svg', version: '1.0.3', link: 'https://pub.dev/packages/flutter_svg'),

  //font_awesome_flutter
  DataPackages(name: 'font_awesome_flutter', version: '10.1.0', link: 'https://pub.dev/packages/font_awesome_flutter'),

  //percent_indicator
  DataPackages(name: 'percent_indicator', version: '4.2.2', link: 'https://pub.dev/packages/percent_indicator'),

  //firebase_core
  DataPackages(name: 'firebase_core', version: '1.17.1', link: 'https://pub.dev/packages/firebase_core'),

  //cloud_firestore
  DataPackages(name: 'cloud_firestore', version: '3.1.17', link: 'https://pub.dev/packages/cloud_firestoree'),

  //date_picker_timeline
  DataPackages(name: 'date_picker_timeline', version: '1.2.3', link: 'https://pub.dev/packages/date_picker_timeline'),

];