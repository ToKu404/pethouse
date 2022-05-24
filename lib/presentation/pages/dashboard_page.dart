import 'package:flutter/cupertino.dart';
import 'package:pethouse/presentation/pages/check_internet_page.dart';
import 'package:pethouse/presentation/widgets/dashboard_pet_card.dart';
import 'package:pethouse/presentation/widgets/gredient_button.dart';


class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DashboardPetCard(),
          SizedBox(
            height: 19,
          ),
          GradientButton(
            width: 100,
            height: 52,
            text: 'Check Internet',
            onTap: (){
              Navigator.pushNamed(context, CheckInternetPage.ROUTE_NAME);
            },
          ),
        ],
      ),
    );
  }
}
