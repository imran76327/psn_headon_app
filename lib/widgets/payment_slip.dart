import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headon/widgets/payslippdfdownload.dart';


import '../bloc/payment_slip/payment_slip_bloc.dart';


class PaymentSlipSample extends StatefulWidget {
  final String employeeId;
  final int slotId;

  const PaymentSlipSample({
    super.key,
    required this.employeeId,
    required this.slotId,
  });

  @override
  State<PaymentSlipSample> createState() => _PaymentSlipSampleState();
}

class _PaymentSlipSampleState extends State<PaymentSlipSample> {
  late final PaymentSlipBloc _paymentSlipBloc;

  @override
  void initState() {
    super.initState();
    // Initialize the Bloc
    _paymentSlipBloc = PaymentSlipBloc();

    // Fetch payment slip data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _paymentSlipBloc.add(FetchPaymentSlip(widget.employeeId, widget.slotId));
    });
  }

  @override
  void dispose() {
    _paymentSlipBloc.close();
    super.dispose();
  }

 @override
Widget build(BuildContext context) {
  return BlocProvider(
    create: (_) => _paymentSlipBloc,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Payment Slip'),
      ),
      body: BlocBuilder<PaymentSlipBloc, PaymentSlipState>(
        builder: (context, state) {
          if (state is PaymentSlipLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PaymentSlipError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is PaymentSlipLoaded) {
            return SingleChildScrollView(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the PDF generation screen with the PaySlip data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PaymentSlipPdfScreen(
                          paymentSlip: state.paymentSlip,
                        ),
                      ),
                    );
                  },
                  child: const Text('Download Payslip'),
                ),
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    ),
  );
}

}
