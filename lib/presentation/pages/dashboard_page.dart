import 'package:flutter/cupertino.dart';
import 'package:pethouse/presentation/widgets/dashboard_pet_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DashboardPetCard(),
    );
  }
}
