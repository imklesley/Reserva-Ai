import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:reservaai/controllers/stores/register_store.dart';
import 'package:reservaai/views/_shared/responsive_layout.dart';
import 'package:reservaai/views/register/components/form/page_four_form.dart';
import 'package:reservaai/views/register/components/form/page_one_form.dart';
import 'package:reservaai/views/register/components/form/page_three_form.dart';
import 'package:reservaai/views/register/components/form/page_two_form.dart';


class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {


  @override
  Widget build(BuildContext context) {


    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isTablet = ResponsiveLayout.isTablet(context);

    final Size _size = MediaQuery.of(context).size;

    //Controla a passagem entra as telas do form
    final PageController _pageController = PageController();

    //Pra n ter que ficar abrindo a imagem em várias partes do app
    final logoReservaAi = Image.asset('assets/images/logo/laranja-azul.png',
        fit: BoxFit.cover,
        height: isMobile
            ? 50
            : isTablet
                ? 60
                : 70);




    //Páginas do formulário de registro
    final PageOneForm pageOne = PageOneForm(
      logoReservaAi: logoReservaAi,
      size: _size,
      pageController: _pageController,
    );
    final PageTwoForm pageTwo = PageTwoForm(
      logoReservaAi: logoReservaAi,
      size: _size,
      pageController: _pageController,
    );
    final PageThreeForm pageThree = PageThreeForm(
      logoReservaAi: logoReservaAi,
      size: _size,
      pageController: _pageController,
    );
    final PageFourForm pageFour = PageFourForm(
      logoReservaAi: logoReservaAi,
      size: _size,
      pageController: _pageController,
    );


    return Provider(
      create: (_) => RegisterStore(),
      child: SizedBox(
        height: isMobile
            ? 490
            : isTablet
                ? 600
                : 650,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [pageOne, pageTwo, pageThree, pageFour],
        ),
      ),
    );
  }
}
