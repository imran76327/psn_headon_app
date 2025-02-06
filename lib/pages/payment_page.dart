import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headon/bloc/payment/payment_bloc.dart';
import '../entry/entry_point.dart';
import '../widgets/pay_list.dart';
import '../widgets/payment_slip.dart';

class PaymentPage extends StatelessWidget {
  final String? employeeId;
  const PaymentPage({super.key, this.employeeId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => PaymentBloc()..add(PaymentFetch(employeeId!)),
      child: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const Center(child: Text('Please wait...'));
          } else if (state is PaymentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PaymentSuccess) {
            return Column(
              children: [
                Container(
                  // margin: EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  height: size.height,
                  width: size.width,
                  child: ListView.builder(
                    itemCount: state.paymentRecords.length,
                    itemBuilder: (context1, index1) {
                    final record = state.paymentRecords[index1];
                    // final userslotlist = widget.home.user_slot_list;
                      if (state.paymentRecords.length - 1 != index1) {
                        return PayList(
                          record: record,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EntryScreen(
                                    body: PaymentSlipSample(employeeId: record.employeeId, slotId: record.slotId )),
                              ),
                            );
                          },
                        ); // Create a new today_work widget for each item
                      } else {
                        return Column(
                          children: [
                            PayList(
                              record: record,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EntryScreen(
                                          body: PaymentSlipSample(employeeId: record.employeeId,slotId: record.slotId )),                           
                                  ),
                                );
                              }, 
                            ),
                            Container(height: 300)
                          ],
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 300,
                ),
              ],
            );
          } else if (state is PaymentError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
