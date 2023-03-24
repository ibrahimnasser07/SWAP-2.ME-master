import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_cubit.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_state.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  static const String routeName = 'NotificationScreen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SwapCubit, SwapStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView(
          children: [
            Slidable(
              key: const ValueKey(0),
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                extentRatio: 0.2,
                closeThreshold: 0.3,
                children: [
                  Expanded(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black12,
                      ),
                      child: IconButton(
                        icon:
                            const Icon(Icons.delete_forever_rounded, size: 30),
                        onPressed: () {
                          Slidable.of(context)?.dismiss(
                            ResizeRequest(Duration.zero, () {}),
                          );
                        },
                        color: Colors.red,
                        iconSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              child: const Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: ListTile(
                  title:
                      Text('شكرا لك لاستخدامك التطبيق, اتمني لكم تجربة ممنعة'),
                  subtitle: Text(
                    ' منذ 5 دقائق',
                    style: TextStyle(color: Colors.black26),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
