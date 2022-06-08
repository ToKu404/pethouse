import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user_entity.dart';
import '../../blocs/auth_cubit/auth_cubit.dart';
import '../../blocs/user_db_bloc/user_db_bloc.dart';
import '../../widgets/gradient_button.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserDbBloc>(context).add(GetUserFromDb(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is UnAuthenticated) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LOGIN_ROUTE_NAME, (route) => false);
              }
            },
          ),
          BlocListener<UserDbBloc, UserDbState>(
            listener: (context, state) {
              if (state is SuccessDeleteUser) {
                context.read<AuthCubit>().loggedOut();
              }
            },
          ),
        ],
        child: BlocBuilder<UserDbBloc, UserDbState>(
          builder: (context, state) {
            if (state is UserDbLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SuccessGetData) {
              return _BuildProfile(user: state.user);
            } else if (state is UserDbFailure) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class _BuildProfile extends StatelessWidget {
  final UserEntity user;
  const _BuildProfile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            (user.imageUrl != '' && user.imageUrl != null)
                ? Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 5, color: kGreyTransparant),
                      image: DecorationImage(
                          image: NetworkImage(user.imageUrl ?? ''),
                          fit: BoxFit.cover),
                    ),
                  )
                : Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kGrey,
                      border: Border.all(width: 5, color: kGreyTransparant),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: kWhite,
                      size: 80,
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  user.name ?? "YourName",
                  style: kTextTheme.headline6?.copyWith(color: kDarkBrown),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  user.email ?? "Your Email",
                  style: kTextTheme.bodyText1,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 20,
            ),
            GradientButton(
              height: 34,
              width: 200,
              text: 'Edit Profile',
              onTap: () {
                Navigator.pushNamed(context, EDIT_PROFILE_ROUTE_NAME,
                    arguments: user.uid);
              },
              isClicked: false,
            ),
            const SizedBox(
              height: 20,
            ),
            CardProfile(
                title: 'Activity Status',
                trailingAction: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 16,
                ),
                leadingAction: const Icon(Icons.timelapse, color: kDarkBrown),
                onTap: () {
                  Navigator.pushNamed(context, ACTIVITY_STATUS_ROUT_NAME);
                }),
            CardProfile(
                title: 'Account',
                trailingAction: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 16,
                ),
                leadingAction: const Icon(Icons.lock, color: kDarkBrown),
                onTap: () {}),
            const NotificationCard(),
            CardProfile(
                title: 'About',
                trailingAction:
                    const Icon(Icons.arrow_forward_ios_sharp, size: 16),
                leadingAction: const Icon(Icons.info, color: kDarkBrown),
                onTap: () {}),
            CardProfile(
                title: 'Log Out',
                trailingAction:
                    const Icon(Icons.arrow_forward_ios_sharp, size: 16),
                leadingAction: const Icon(Icons.exit_to_app, color: kDarkBrown),
                onTap: () async {
                  context.read<AuthCubit>().loggedOut();
                })
          ],
        ),
      ),
    );
  }
}

class CardProfile extends StatelessWidget {
  final String title;
  final Widget trailingAction;
  final Widget leadingAction;
  final VoidCallback? onTap;
  const CardProfile({
    super.key,
    required this.title,
    required this.trailingAction,
    required this.leadingAction,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: double.infinity,
        child: ListTile(
          leading: leadingAction,
          title: Text(title),
          trailing: trailingAction,
          onTap: onTap,
        ),
      ),
    );
  }
}

class NotificationCard extends StatefulWidget {
  const NotificationCard({Key? key}) : super(key: key);

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool statusSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: double.infinity,
        child: ListTile(
          leading: const Icon(
            Icons.notifications_sharp,
            color: kDarkBrown,
          ),
          title: const Text('Notification'),
          trailing: Switch.adaptive(
              activeColor: kPrimaryColor,
              value: statusSwitch,
              onChanged: (value) =>
                  setState(() => statusSwitch = !statusSwitch)),
          onTap: () {},
        ),
      ),
    );
  }
}
