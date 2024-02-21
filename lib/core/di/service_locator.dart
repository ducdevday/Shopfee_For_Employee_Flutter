import 'package:get_it/get_it.dart';
import 'package:shopfeeforemployee/features/change_password/data/datasources/change_password_service.dart';
import 'package:shopfeeforemployee/features/change_password/data/repositories/change_password_repository_impl.dart';
import 'package:shopfeeforemployee/features/change_password/domain/repositories/change_password_repository.dart';
import 'package:shopfeeforemployee/features/change_password/domain/usecase/change_password_usecase.dart';
import 'package:shopfeeforemployee/features/change_password/presentation/change_password.dart';
import 'package:shopfeeforemployee/features/employee/data/datasources/employee_service.dart';
import 'package:shopfeeforemployee/features/employee/data/repositories/employee_repository_impl.dart';
import 'package:shopfeeforemployee/features/employee/domain/repositories/employee_repository.dart';
import 'package:shopfeeforemployee/features/employee/domain/usecase/employee_usecase.dart';
import 'package:shopfeeforemployee/features/employee/presentation/employee.dart';
import 'package:shopfeeforemployee/features/history/data/datasources/history_service.dart';
import 'package:shopfeeforemployee/features/history/data/repositories/history_repository_impl.dart';
import 'package:shopfeeforemployee/features/history/domain/repositories/history_repository.dart';
import 'package:shopfeeforemployee/features/history/domain/usecase/history_usecase.dart';
import 'package:shopfeeforemployee/features/login/data/datasources/login_service.dart';
import 'package:shopfeeforemployee/features/login/data/repositories/login_repository_impl.dart';
import 'package:shopfeeforemployee/features/login/domain/repositories/login_repository.dart';
import 'package:shopfeeforemployee/features/login/domain/usecase/login_usecase.dart';
import 'package:shopfeeforemployee/features/login/presentation/login.dart';
import 'package:shopfeeforemployee/features/order_detail/data/datasources/order_detail_service.dart';
import 'package:shopfeeforemployee/features/order_detail/data/datasources/order_notify_service.dart';
import 'package:shopfeeforemployee/features/order_detail/data/repositories/order_detail_repository_impl.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/repositories/order_detail_repository.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/usecase/order_detail_usecase.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/order_detail.dart';
import 'package:shopfeeforemployee/features/personal_information/data/datasources/personal_information_service.dart';
import 'package:shopfeeforemployee/features/personal_information/data/repositories/personal_information_repository_impl.dart';
import 'package:shopfeeforemployee/features/personal_information/domain/repositories/personnal_information_repository.dart';
import 'package:shopfeeforemployee/features/personal_information/domain/usecase/personnal_information_usecase.dart';
import 'package:shopfeeforemployee/features/personal_information/presentation/personal_information.dart';
import 'package:shopfeeforemployee/features/shipping_order/data/datasources/shipping_order_service.dart';
import 'package:shopfeeforemployee/features/shipping_order/data/repositories/shipping_order_repository_impl.dart';
import 'package:shopfeeforemployee/features/shipping_order/domain/repositories/shipping_order_repository.dart';
import 'package:shopfeeforemployee/features/shipping_order/domain/usecase/shipping_order_usecase.dart';
import 'package:shopfeeforemployee/features/shipping_order/presentation/shipping_order.dart';

import '../../features/history/presentation/history.dart';

class ServiceLocator {
  static final sl = GetIt.instance;

  Future<void> init() async {
    _loginFeature();
    _employeeFeature();
    _personalInformationFeature();
    _changePasswordFeature();
    _shippingOrderFeature();
    _orderDetailFeature();
    _historyDetailFeature();
  }

  void _loginFeature() {
    //DataSource
    sl.registerLazySingleton(() => LoginService());
    //Repository
    sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl()));
    //Usecase
    sl.registerLazySingleton<LoginUseCase>(() => LoginUseCaseImpl(sl()));
    //Cubit/Bloc
    sl.registerFactory<LoginCubit>(() => LoginCubit(sl()));
  }

  void _personalInformationFeature() {
    sl.registerLazySingleton(() => PersonalInformationService());
    sl.registerLazySingleton<PersonalInformationRepository>(
        () => PersonalInformationRepositoryImpl(sl()));
    sl.registerLazySingleton<PersonalInformationUseCase>(
        () => PersonalInformationUseCaseImpl(sl()));
    sl.registerFactory<PersonalInformationCubit>(
        () => PersonalInformationCubit(sl()));
  }

  void _changePasswordFeature() {
    sl.registerLazySingleton(() => ChangePasswordService());
    sl.registerLazySingleton<ChangePasswordRepository>(
        () => ChangePasswordRepositoryImpl(sl()));
    sl.registerLazySingleton<ChangePasswordUseCase>(
        () => ChangePasswordUseCaseImpl(sl()));
    sl.registerFactory<ChangePasswordCubit>(() => ChangePasswordCubit(sl()));
  }

  void _shippingOrderFeature() {
    sl.registerLazySingleton(() => ShippingOrderService());
    sl.registerLazySingleton<ShippingOrderRepository>(
        () => ShippingOrderRepositoryImpl(sl()));
    sl.registerLazySingleton<ShippingOrderUseCase>(
        () => ShippingOrderUseCaseImpl(sl()));
    sl.registerFactory<ShippingOrderBloc>(() => ShippingOrderBloc(sl()));
  }

  void _orderDetailFeature() {
    sl.registerLazySingleton(() => OrderDetailService());
    sl.registerLazySingleton(() => OrderNotifyService());
    sl.registerLazySingleton<OrderDetailRepository>(
        () => OrderDetailRepositoryImpl(sl(), sl()));
    sl.registerLazySingleton<OrderDetailUseCase>(
        () => OrderDetailUseCaseImpl(sl()));
    sl.registerFactory<OrderDetailBloc>(() => OrderDetailBloc(sl()));
  }

  void _historyDetailFeature() {
    sl.registerLazySingleton(() => HistoryService());
    sl.registerLazySingleton<HistoryRepository>(
        () => HistoryRepositoryImpl(sl()));
    sl.registerLazySingleton<HistoryUseCase>(() => HistoryUseCaseImpl(sl()));
    sl.registerFactory<HistoryBloc>(() => HistoryBloc(sl()));
  }

  void _employeeFeature() {
    sl.registerLazySingleton(() => EmployeeService());
    sl.registerLazySingleton<EmployeeRepository>(
        () => EmployeeRepositoryImpl(sl()));
    sl.registerLazySingleton<EmployeeUseCase>(() => EmployeeUseCaseImpl(sl()));
    sl.registerFactory(() => EmployeeBloc(sl()));
  }
}
