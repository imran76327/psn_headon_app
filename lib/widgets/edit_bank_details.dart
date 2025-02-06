import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bank/bank_bloc.dart';
import '../model/home/employee_model.dart';

class EditBankDetails extends StatefulWidget {
  final EmployeeModal employee;

  const EditBankDetails({super.key, required this.employee});

  @override
  EditBankDetailsState createState() => EditBankDetailsState();
}

class EditBankDetailsState extends State<EditBankDetails>  with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController employeeIdController;
  late TextEditingController companyController;
  late TextEditingController bankNameController;
  late TextEditingController ifscController;
  late TextEditingController accountHolderNameController;
  late TextEditingController accountNoController;
  late TextEditingController branchNameController;
  late TextEditingController companyIdController;
  late TextEditingController phoneController;

   void postdata(BuildContext context, String employeeId, String companyId, String accountHolderName, String accountNo, String bankName, String branchName, String ifsc, String phone) {
    context.read<BankPostBloc>().add(BankPost(
      employeeId: employeeId,
      companyId: companyId,
      accountHolderName: accountHolderName,
      accountNo: accountNo,
      bankName: bankName,
      branchName: branchName,
      ifsc: ifsc,
      phone: phone,
    ));
  }
  
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;


  @override
  void initState() {
    super.initState();

    employeeIdController = TextEditingController(text: widget.employee.employeeId);
    companyController = TextEditingController(text: widget.employee.companyName);
    accountHolderNameController = TextEditingController(text: widget.employee.accountHolderName);
    accountNoController = TextEditingController(text: widget.employee.accountNo);
    bankNameController = TextEditingController(text: widget.employee.bankName);
    branchNameController = TextEditingController(text: widget.employee.branchName);
    ifscController = TextEditingController(text: widget.employee.ifscCode);
    companyIdController = TextEditingController(text: widget.employee.companyId);
    phoneController = TextEditingController(text: widget.employee.mobileNumber);
  

    _controllers = List.generate(8, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      );
    });

    _animations = List.generate(8, (index) {
      return Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.easeOut,
      ));
    });

    _startAnimation();
  }


  void _startAnimation() async {
    // Start animations with 0.1 second delay between each field.
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(Duration(milliseconds: 100 * i));
      _controllers[i].forward();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    employeeIdController.dispose();
    companyController.dispose();
    accountHolderNameController.dispose();
    accountNoController.dispose();
    bankNameController.dispose();
    branchNameController.dispose();
    ifscController.dispose();
    companyIdController.dispose();
    phoneController.dispose();
    super.dispose();
  }

 
  @override
Widget build(BuildContext context) {
  return BlocListener<BankPostBloc, BankPostState>(
    listener: (context, state) {
      if (state is BankPostSuccess) {
        _showDialog(context, 'Success!', state.message, Colors.green.shade500, Icons.check_circle);
      } else if (state is BankPostFailure) {
        _showDialog(context, 'Error!', state.message, Colors.red, Icons.error);
      }
    },
    child: Scaffold(
      appBar: AppBar(
          title: const Text('Edit Bank Details'),
          backgroundColor: Colors.red.shade900, // Header color as red.shade900
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context); // Go back to the previous screen
            },
            child: Transform.scale(
              scale: 0.5, // Scale the image down
              child: Image.asset(
                'assets/images/undo.png', // Your image for back button
                color: Colors.black, // Set image color to white
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      body: Form(
        key: _formKey,
        child: Card(
          elevation: 6.0,
          margin: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                _buildAnimatedTextFormField(
                  label: 'Employee Id',
                  controller: employeeIdController,
                  icon: Icons.badge,
                  readOnly: true,
                  index: 0,
                ),
                _buildAnimatedTextFormField(
                  label: 'Company',
                  controller: companyController,
                  icon: Icons.business,
                  readOnly: true,
                  index: 1,
                ),
                _buildAnimatedTextFormField(
                  label: 'Phone',
                  controller: phoneController,
                  icon: Icons.phone,
                  readOnly: true,
                  index: 2,
                ),
                _buildAnimatedTextFormField(
                  label: 'Account Holder Name',
                  controller: accountHolderNameController,
                  icon: Icons.person,
                  readOnly: false,
                  index: 3,
                ),
                _buildAnimatedTextFormField(
                  label: 'Account Number',
                  controller: accountNoController,
                  icon: Icons.account_balance_wallet,
                  readOnly: false,
                  index: 4,
                ),
                _buildAnimatedTextFormField(
                  label: 'Bank Name',
                  controller: bankNameController,
                  icon: Icons.account_balance,
                  readOnly: false,
                  index: 5,
                ),
                _buildAnimatedTextFormField(
                  label: 'Branch Name',
                  controller: branchNameController,
                  icon: Icons.location_city,
                  readOnly: false,
                  index: 6,
                ),
                _buildAnimatedTextFormField(
                  label: 'IFSC Code',
                  controller: ifscController,
                  icon: Icons.code,
                  readOnly: false,
                  index: 7,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter IFSC code';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade900,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                  onPressed: () => _showConfirmationDialog(context),
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildAnimatedTextFormField({
  required String label,
  required TextEditingController controller,
  required IconData icon,
  bool readOnly = false,
  String? Function(String?)? validator,
  required int index,
}) {
  return SlideTransition(
    position: _animations[index],
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.red.shade900),
          prefixIcon: Icon(icon, color: Colors.red.shade900),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade900),
          ),
        ),
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $label';
              }
              return null;
            },
      ),
    ),
  );
}



  void _showDialog(BuildContext context, String title, String message, Color color, IconData icon) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(icon, color: Colors.white, size: 50),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: color),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to update this data?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final employeeId = employeeIdController.text.trim();
                  final companyId = companyIdController.text.trim();
                  final accountHolderName = accountHolderNameController.text.trim();
                  final accountNo = accountNoController.text.trim();
                  final bankName = bankNameController.text.trim();
                  final branchName = branchNameController.text.trim();
                  final ifsc = ifscController.text.trim();
                  final phone = phoneController.text.trim();
                  postdata(context, employeeId, companyId, accountHolderName, accountNo, bankName, branchName, ifsc, phone);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}


