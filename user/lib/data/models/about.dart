class DataAppModel {
  String title='Pethouse';
  String background="""Kemajuan ilmu pengetahuan mendorong berbagai inovasi yang memicu perkembangan teknologi salah satunya adalah perkembangan aplikasi dari berbagai platform untuk membantu kebutuhan manusia. Hewan merupakan salah satu makhluk hidup yang sangat dekat dengan kehidupan manusia. Hal ini menimbulkan banyaknya niat manusia untuk memelihara hewan di sekitar. Proses pemeliharaan hewan tersebut tentu saja memerlukan banyak prosedur untuk menjaga hewan tetap sehat. Pemeliharaan Hewan dengan perawatan rutin merupakan hal yang kerap kali menyulitkan bagi para pecinta hewan untuk menjaga seluruh kebiasaan sesuai dengan jadwal. Dengan dibuatnya aplikasi ini diharapkan dapat memudahkan masyarakat yang khususnya pecinta hewan dapat memantau kondisi dan jadwal pemeliharaan hewan.""";
  String programming_leng = 'Dart';
  String framework='Flutter';
  String database='Firestore';
  String logo = 'assets/icons/pethouse_icon.svg';
  String description="Pethouse adalah aplikasi yang dapat membantu pecinta hewan untuk memantau kondisi terjadwal dari hewan peliharaan yang dimilikinya. Pethouse memiliki beberapa fitur unggulan yang dapat memudahkan pengguna, yakni menyediakan layanan Schedule & Plan Task yang dapat memantau kondisi dan perencanaan kegiatan hewan peliharaan, layanan Open Adopt yang dapat memudahkan pengguna dalam mengadopsi hewan, kemudian layanan Petrivia yang dapat memudahkan pengguna untuk menemukan berita seputar fakta - fakta hewan, layanan Pet Store yang dapat memudahkan dalam mencari kebutuhan hewan, dan layanan Pet Map yang dapat memudahkan pengguna untuk menemukan pengguna lain yang menggunakan aplikasi ini.";
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
  DataPackages(name: 'cloud_firestore', version: '3.1.17', link: 'https://pub.dev/packages/cloud_firestore'),

  //date_picker_timeline
  DataPackages(name: 'date_picker_timeline', version: '1.2.3', link: 'https://pub.dev/packages/date_picker_timeline'),

  //cupertino_icons
  DataPackages(name: 'cupertino_icons', version: '1.0.2', link: 'https://pub.dev/packages/cupertino_icons'),

  //convex_bottom_bar
  DataPackages(name: 'convex_bottom_bar', version: '3.0.0', link: 'https://pub.dev/packages/convex_bottom_bar'),

  //dotted_border
  DataPackages(name: 'dotted_border', version: '2.0.0+2', link: 'https://pub.dev/packages/dotted_border'),

  //carousel_slider
  DataPackages(name: 'carousel_slider', version: '4.1.1', link: 'https://pub.dev/packages/carousel_slider'),

  //table_calender
  DataPackages(name: 'table_calender', version: '3.0.5', link: 'https://pub.dev/packages/table_calendar'),

  //google_maps_flutter
  DataPackages(name: 'google_maps_flutter', version: '2.1.8', link: 'https://pub.dev/packages/google_maps_flutter'),

  //flutter_speed_dial
  DataPackages(name: 'flutter_speed_dial', version: '6.0.0', link: 'https://pub.dev/packages/flutter_speed_dial'),

  //iconify_flutter
  DataPackages(name: 'iconify_flutter', version: '0.0.4', link: 'https://pub.dev/packages/iconify_flutter'),

  //webview_flutter
  DataPackages(name: 'webview_flutter', version: '3.0.4', link: 'https://pub.dev/packages/webview_flutter'),

  //flutter_staggered_grid_view
  DataPackages(name: 'flutter_staggered_grid_view', version: '0.4.1', link: 'https://pub.dev/packages/flutter_staggered_grid_view'),

  //charts_flutter
  DataPackages(name: 'charts_flutter', version: '0.12.0', link: 'https://pub.dev/packages/charts_flutter'),

  //sqlflite
  DataPackages(name: 'sqlflite', version: '2.0.2+1', link: 'https://pub.dev/packages/sqflite'),

  //get_it
  DataPackages(name: 'et_it', version: '7.1.3', link: 'https://pub.dev/packages/get_it'),

  //flutter_bloc
  DataPackages(name: 'flutter_bloc', version: '8.0.1', link: 'https://pub.dev/packages/flutter_bloc'),

  //url_launcher
  DataPackages(name: 'url_launcher', version: '6.1.3', link: 'https://pub.dev/packages/url_launcher'),

  //firebase_auth
  DataPackages(name: 'firebase_auth', version: '3.3.19', link: 'https://pub.dev/packages/firebase_auth'),

  //firebase_storage
  DataPackages(name: 'firebase_storage', version: '10.2.17', link: 'https://pub.dev/packages/firebase_storage'),

  //file_picker
  DataPackages(name: 'file_picker', version: '4.6.1', link: 'https://pub.dev/packages/file_picker'),

  //shared_preferences
  DataPackages(name: 'shared_preferences', version: '2.0.15', link: 'https://pub.dev/packages/shared_preferences'),

  //flutter_local_notifications
  DataPackages(name: 'flutter_local_notifications', version: '9.6.0', link: 'https://pub.dev/packages/flutter_local_notifications'),

  //rxdart
  DataPackages(name: 'rxdart', version: '0.27.4', link: 'https://pub.dev/packages/rxdart'),

  //uuid
  DataPackages(name: 'uuid', version: '3.0.6', link: 'https://pub.dev/packages/uuid'),

  //convex_bottom_bar
  DataPackages(name: 'flutter_spinkit', version: '5.1.0', link: 'https://pub.dev/packages/flutter_spinkit'),

  //curved_navigation_bar
  DataPackages(name: 'curved_navigation_bar', version: '1.0.3', link: 'https://pub.dev/packages/curved_navigation_bar'),

  //android_alarm_manager_plus
  DataPackages(name: 'android_alarm_manager_plus', version: '2.0.5', link: 'https://pub.dev/packages/android_alarm_manager_plus'),

  //geolocator
  DataPackages(name: 'geolocator', version: '8.2.1', link: 'https://pub.dev/packages/geolocator'),

  //http
  DataPackages(name: 'http', version: '0.13.4', link: 'https://pub.dev/packages/http'),

  //html
  DataPackages(name: 'html', version: '0.15.0', link: 'https://pub.dev/packages/html'),

  //flutter_map
  DataPackages(name: 'flutter_map', version: '1.0.0', link: 'https://pub.dev/packages/flutter_map'),

  //latlong2
  DataPackages(name: 'latlong2', version: '0.8.1', link: 'https://pub.dev/packages/latlong2'),

  //cached_network_image
  DataPackages(name: 'cached_network_image', version: '3.2.1', link: 'https://pub.dev/packages?q=cached_network_image'),

  //intl
  DataPackages(name: 'intl', version: '0.17.0', link: 'https://pub.dev/packages/intl'),

  //timezone
  DataPackages(name: 'timezone', version: '0.8.0', link: 'https://pub.dev/packages/timezone'),

  //google_sign_in
  DataPackages(name: 'google_sign_in', version: '5.3.2', link: 'https://pub.dev/packages/google_sign_in'),

  //permission_handler
  DataPackages(name: 'permission_handler', version: '9.2.0', link: 'https://pub.dev/packages/permission_handler'),

  //awesome_dialog
  DataPackages(name: 'awesome_dialog', version: '2.2.1', link: 'https://pub.dev/packages/awesome_dialog'),

  //connectivity_plus
  DataPackages(name: 'connectivity_plus', version: '2.3.5', link: 'https://pub.dev/packages/connectivity_plus'),

  //shimmer
  DataPackages(name: 'shimmer', version: '2.0.0', link: 'https://pub.dev/packages/shimmer'),
];