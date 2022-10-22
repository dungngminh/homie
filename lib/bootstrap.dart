// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:address/address.dart';
import 'package:auth/auth.dart';
import 'package:category/category.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/di/di.dart';
import 'package:post/post.dart';
import 'package:property/property.dart';
import 'package:user/user.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('onBlocCreate -- ${bloc.runtimeType}', name: '${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log(
      'onAddEvent -- ${bloc.runtimeType}, $event',
      name: '${bloc.runtimeType}',
    );
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log(
      'onStateChange -- ${bloc.runtimeType}, $change',
      name: '${bloc.runtimeType}',
    );
  }

  // @override
  // void onTransition(Bloc bloc, Transition transition) {
  //   super.onTransition(bloc, transition);
  //   log(
  //     'onStateTransition -- ${bloc.runtimeType}, $transition',
  //     name: '${bloc.runtimeType}',
  //   );
  // }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError -- ${bloc.runtimeType}, $error', name: '${bloc.runtimeType}');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('onBlocClose -- ${bloc.runtimeType}', name: '${bloc.runtimeType}');
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  Bloc.observer = AppBlocObserver();
  initDependences();
  await runZonedGuarded(
    () async => runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (_) => AddressRepository(addressDatasource: injector()),
          ),
          RepositoryProvider(
            create: (_) => CategoryRepository(categoryDatasource: injector()),
          ),
          RepositoryProvider(
            create: (_) => PropertyRepository(propertyDatasource: injector()),
          ),
          RepositoryProvider(
            create: (_) => AuthRepository(authDatasource: injector()),
          ),
          RepositoryProvider(
            create: (_) => UserRepository(userDatasource: injector()),
          ),
           RepositoryProvider(
            create: (_) => PostRepository(postDatasource: injector()),
          ),
        ],
        child: await builder(),
      ),
    ),
    (error, stackTrace) =>
        log(error.toString(), stackTrace: stackTrace, name: 'ERROR'),
  );
}
