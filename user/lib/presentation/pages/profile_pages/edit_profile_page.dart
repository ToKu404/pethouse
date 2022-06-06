import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/presentation/widgets/gradient_button.dart';

import '../../blocs/user_db_bloc/user_db_bloc.dart';
import '../../blocs/user_profile_bloc/user_profile_bloc.dart';

class EditProfilePage extends StatefulWidget {
  final String uid;
  const EditProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserDbBloc>(context).add(GetUserFromDb(widget.uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: kGrey),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: kWhite,
              ),
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Edit Profile',
          style: kTextTheme.headline5,
        ),
        elevation: 1,
        shadowColor: kGrey,
      ),
      body: const SafeArea(child: _FormEditProfile()),
    );
  }
}

class _FormEditProfile extends StatelessWidget {
  const _FormEditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDbBloc, UserDbState>(builder: ((context, state) {
      if (state is UserDbLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is SuccessGetData) {
        BlocProvider.of<UserProfileBloc>(context).add(UserProfileInit(
            imageUrl: state.user.imageUrl ?? '',
            name: state.user.name ?? '',
            email: state.user.email ?? ''));
        return SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  _ImageSection(
                    userId: state.user.uid ?? 'uid',
                    imageUrl: state.user.imageUrl ?? '',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _NameField(
                    name: state.user.name ?? '',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _EmailField(email: state.user.email ?? ''),
                  const SizedBox(
                    height: 30,
                  ),
                  GradientButton(
                      height: 50,
                      width: double.infinity,
                      onTap: () {
                        context
                            .read<UserProfileBloc>()
                            .add(SubmitUpdate(state.user.uid ?? 'uid'));
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.pop(context);
                        });
                      },
                      isClicked: false,
                      text: 'Save Update')
                ],
              ),
            ),
          ),
        );
      } else {
        return const Center();
      }
    }));
  }
}

class _ImageSection extends StatelessWidget {
  final String userId;
  final String imageUrl;
  const _ImageSection({Key? key, required this.userId, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<UserProfileBloc, UserProfileValidate>(
          builder: ((context, state) {
            if (state.isLoading) {
              return const SizedBox(
                height: 120,
                width: 120,
                child: CircularProgressIndicator(),
              );
            } else {
              if (state.imageIsUpload || imageUrl != '') {
                return Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: Colors.grey),
                    image: DecorationImage(
                        image: NetworkImage(
                            state.imageIsUpload ? state.imageUrl : imageUrl),
                        fit: BoxFit.cover),
                  ),
                );
              } else {
                return Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: Colors.grey),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 80,
                  ),
                );
              }
            }
          }),
        ),
        const SizedBox(
          height: 10,
        ),
        GradientButton(
            height: 40,
            width: 200,
            onTap: () async {
              context
                  .read<UserProfileBloc>()
                  .add(ImageUploaded(userId, imageUrl));
            },
            isClicked: false,
            text: "Upload Image"),
      ],
    );
  }
}

class _EmailField extends StatelessWidget {
  final String email;
  const _EmailField({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileValidate>(
      builder: (context, state) {
        return TextFormField(
          initialValue: email,
          onChanged: (value) {
            context.read<UserProfileBloc>().add(EmailChanged(value));
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            helperText: 'A complete, valid email e.g. joe@gmail.com',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorText: !state.isEmailValid
                ? 'Please ensure the email entered is valid'
                : null,
            labelText: 'Email',
          ),
        );
      },
    );
  }
}

class _NameField extends StatelessWidget {
  final String name;
  const _NameField({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileValidate>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) {
            context.read<UserProfileBloc>().add(NameChanged(value));
          },
          initialValue: name,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            helperText: 'This field should be fill',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorText: !state.isNameValid
                ? 'Please ensure the name entered is valid'
                : null,
            labelText: 'Name',
          ),
        );
      },
    );
  }
}
