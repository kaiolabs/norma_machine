import 'package:flutter_modular/flutter_modular.dart';

import 'controller/home_controller.dart';
import 'views/home_view.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => HomeController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const HomeView()),
      ];
}
