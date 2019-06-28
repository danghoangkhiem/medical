import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/synchronization/synchronization.dart';
import 'package:medical/src/blocs/authentication/authentication.dart';
import 'package:medical/src/blocs/home/home.dart';

import 'package:medical/src/models/user_model.dart';

import 'package:medical/src/ui/pages/med_rep/med_rep_page.dart';

import 'package:medical/src/utils.dart';

import 'package:medical/src/ui/pages/authentication/authentication_failure_page.dart';
import 'package:medical/src/ui/pages/change_password/change_password_page.dart';
import 'package:medical/src/ui/pages/synchronization/synchronization_page.dart';
import 'package:medical/src/ui/pages/check_in/check_in_page.dart';
import 'package:medical/src/ui/pages/invoice/invoice_page.dart';
import 'package:medical/src/ui/pages/customer/customer_manager_page.dart';
import 'package:medical/src/ui/pages/inventories/inventories_page.dart';
import 'package:medical/src/ui/pages/report_kpi/report_kpi_page.dart';
import 'package:medical/src/ui/pages/schedule_work/schedule_work_page.dart';
import 'package:medical/src/ui/pages/schedule_coaching/schedule_coaching_page.dart';

import 'package:medical/src/ui/widgets/loading_indicator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel _currentUser;
  HomeBloc _homeBloc;
  SynchronizationBloc _synchronizationBloc;

  @override
  void initState() {
    _synchronizationBloc = BlocProvider.of<SynchronizationBloc>(context);
    _homeBloc = HomeBloc(synchronizationBloc: _synchronizationBloc);
    _homeBloc.dispatch(UserIdentifier());
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc?.dispose();
    super.dispose();
  }

  void _logout(BuildContext context) async {
    final bool accepted = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Xác nhận'),
            content:
                Text('Bạn sẽ đăng xuất khỏi tài khoản này?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Hủy'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('Đăng xuất'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
    if (accepted is bool && accepted) {
      final AuthenticationBloc bloc =
          BlocProvider.of<AuthenticationBloc>(context);
      bloc.dispatch(AuthenticationEvent.loggedOut());
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder(
            bloc: _homeBloc,
            builder: (BuildContext context, HomeState state) {
              if (state is Loading) {
                return LoadingIndicator(opacity: 0);
              }
              if (state is Loaded) {
                return Container(
                  height: double.infinity,
                  color: Colors.grey[300],
                  child: Column(
                    children: <Widget>[
                      _buildUserInfo(_currentUser = state.user),
                      _buildSelectionItemBox()
                    ],
                  ),
                );
              }
              if (state is Failure) {
                return AuthenticationFailurePage(
                    errorMessage: state.errorMessage);
              }
              return Container();
            }),
      ),
    );
  }

  Widget _buildUserInfo(UserModel user) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 50,
      color: Colors.blueAccent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.verified_user,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            user.name.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            '/',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            user.code.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionItem({
    IconData icon,
    String label,
    Function onPressed,
    bool isNoticed = false,
    List<UserRoleType> required = const [],
  }) {
    if (_currentUser == null ||
        required.isNotEmpty && required.indexOf(_currentUser.role) < 0) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
      ),
      height: 55,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(7),
          onTap: () {
            onPressed();
          },
          child: ListTile(
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                isNoticed
                    ? Icon(
                        Icons.info,
                        color: Colors.redAccent,
                      )
                    : SizedBox()
              ],
            ),
            leading: Icon(
              icon,
              size: 35,
              color: Colors.blueAccent,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionItemBox() {
    final _syncBloc = BlocProvider.of<SynchronizationBloc>(context);
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: <Widget>[
            _buildSelectionItem(
              icon: Icons.access_alarm,
              label: 'Chấm công',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => CheckInPage()));
              },
              required: [
                UserRoleType.MedicalNutritionRepresentative,
              ],
            ),

            _buildSelectionItem(
              icon: Icons.people,
              label: 'Quản lý khách hàng',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => CustomerManagePage()));
              },
              required: [
                UserRoleType.MedicalNutritionRepresentative,
              ],
            ),
            _buildSelectionItem(
              icon: Icons.access_alarm,
              label: 'Thống kê KPI',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ReportKpiPage()));
              },
              required: [
                UserRoleType.MedicalRepresentative,
                UserRoleType.MedicalSupervisor,
              ],
            ),
//            _buildSelectionItem(
//              icon: Icons.access_alarm,
//              label: 'Danh sách Med Rep của Med Sup',
//              onPressed: () {
//                Navigator.of(context).push(MaterialPageRoute(
//                    builder: (BuildContext context) => MedRepPage()));
//              },
//              required: [
//                UserRoleType.MedicalSupervisor,
//              ],
//            ),
            _buildSelectionItem(
              icon: Icons.shopping_cart,
              label: 'Quản lý xuất nhập tồn',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Inventories()));
              },
              required: [
                UserRoleType.MedicalNutritionRepresentative,
              ],
            ),
            _buildSelectionItem(
              icon: Icons.assessment,
              label: 'Phiếu xuất nhập hàng',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => InvoicePage()));
              },
              required: [
                UserRoleType.MedicalNutritionRepresentative,
              ],
            ),
            _buildSelectionItem(
              icon: Icons.schedule,
              label: 'Lập kế hoạch làm việc',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    settings: RouteSettings(name: '/schedule_work_page'),
                    builder: (BuildContext context) => ScheduleWorkPage()));
              },
              required: [
                UserRoleType.MedicalRepresentative,
                UserRoleType.MedicalSupervisor,
              ],
            ),
            _buildSelectionItem(
              icon: Icons.alarm,
              label: 'Lập kế hoạch coaching',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    settings: RouteSettings(name: '/schedule_coaching_page'),
                    builder: (BuildContext context) => ScheduleCoachingPage()));
              },
              required: [
                UserRoleType.MedicalSupervisor,
              ],
            ),
            BlocBuilder(
              bloc: _syncBloc,
              builder: (BuildContext context, SynchronizationState state) {
                return _buildSelectionItem(
                  icon: Icons.cloud_upload,
                  label: 'Đồng bộ dữ liệu',
                  isNoticed: !state.isSynchronized,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            SynchronizationPage(user: _currentUser)));
                  },
                  required: [
                    UserRoleType.MedicalNutritionRepresentative,
                  ],
                );
              },
            ),
            _buildSelectionItem(
                icon: Icons.lock_outline,
                label: 'Đổi mật khẩu',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ChangePasswordPage()));
                }),
            _buildSelectionItem(
                icon: Icons.lock_open,
                label: 'Đăng xuất',
                onPressed: () {
                  _logout(context);
                }),
            _buildSelectionItem(
                icon: Icons.exit_to_app,
                label: 'Thoát ứng dụng',
                onPressed: () => exitApp(context))
          ],
        ),
      ),
    );
  }
}
