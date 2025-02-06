

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/edit_employee/edit_employee_bloc.dart';
import '../model/home/employee_model.dart';
import '../model/home/stateModal.dart';




class EditEmployeeDetails extends StatefulWidget {
  final EmployeeModal employee;
  final List<StateModal> statelist;

  const EditEmployeeDetails({super.key, required this.employee, required this.statelist});

  @override
  _EditEmployeeDetailsState createState() => _EditEmployeeDetailsState();
}

class _EditEmployeeDetailsState extends State<EditEmployeeDetails> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController employeeIdController;
  late TextEditingController companyController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController pincodeController;
  late TextEditingController emailController;
  late TextEditingController NameController;
  late TextEditingController CompanyIdController;
  late TextEditingController stateController;

  StateModal? selectedState;

  void postdata(BuildContext context, String employeeId, String companyId, String email, String address, String city, String pincode, String selectedStateId) {
    context.read<EmployeePostBloc>().add(EmployeePost(
      employeeId: employeeId,
      companyId: companyId,
      email: email,
      address: address,
      city: city,
      SelectedstateId: selectedStateId, pincode: pincode,
    ));
  }

  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;

  @override
  void initState() {
    super.initState();

    employeeIdController = TextEditingController(text: widget.employee.employeeId);
    NameController = TextEditingController(text: widget.employee.name);
    companyController = TextEditingController(text: widget.employee.companyName);
    addressController = TextEditingController(text: widget.employee.address);
    emailController = TextEditingController(text: widget.employee.email);
    stateController = TextEditingController(text: widget.employee.StateId);
    pincodeController = TextEditingController(text: widget.employee.pincode);
    cityController = TextEditingController(text: widget.employee.city);
    CompanyIdController = TextEditingController(text: widget.employee.companyId);

    selectedState = widget.statelist.firstWhere(
      (state) => state.stateId == widget.employee.StateId,
      orElse: () => widget.statelist.first, // Default to first if not found
    );

    // Initialize animation controllers and animations
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

    NameController.dispose();
    stateController.dispose();
    employeeIdController.dispose();
    companyController.dispose();
    addressController.dispose();
    emailController.dispose();
    pincodeController.dispose();
    cityController.dispose();
    CompanyIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmployeePostBloc, EmployeePostState>(
      listener: (context, state) {
        if (state is EmployeePostSuccess) {
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
                    color: Colors.green.shade900,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(Icons.check_circle, color: Colors.white, size: 50),
                      const SizedBox(height: 10),
                      const Text(
                        'Success!',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.message,
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade500),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          Navigator.pop(context); // Go back to the previous screen
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is EmployeePostFailure) {
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
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(Icons.error, color: Colors.white, size: 50),
                      const SizedBox(height: 10),
                      const Text(
                        'Error',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.message,
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
        title: const Text('Edit Employee Details'),
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
          child: ListView(
            children: [
              Card(
                elevation: 6.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildAnimatedTextFormField('Employee Name', NameController, Icons.person, readOnly: true, index: 0),
                      _buildAnimatedTextFormField('Employee Id', employeeIdController, Icons.badge, readOnly: true, index: 1),
                      _buildAnimatedTextFormField('Company', companyController, Icons.business, readOnly: true, index: 2),
                      _buildAnimatedTextFormField('Email Address', emailController, Icons.email, validator: _validateEmail, index: 3),
                      _buildAnimatedTextFormField('Address', addressController, Icons.home, validator: _validateAddress, index: 4),
                      _buildAnimatedStateDropdown(index: 5),
                      _buildAnimatedTextFormField('City', cityController, Icons.location_city, validator: _validateCity, index: 6),
                      _buildAnimatedTextFormField('Pincode', pincodeController, Icons.location_on, validator: _validatePincode, index: 7),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade900,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    _showConfirmationDialog();
                  },
                  child: const Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedTextFormField(
    String label,
    TextEditingController controller,
    IconData icon, {
    bool readOnly = false,
    String? Function(String?)? validator,
    required int index,
  }) {
    return SlideTransition(
      position: _animations[index],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.red.shade900),
            prefixIcon: Icon(icon, color: Colors.red.shade900),
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade900),
            ),
          ),
          controller: controller,
          readOnly: readOnly,
          validator: validator,
        ),
      ),
    );
  }

  Widget _buildAnimatedStateDropdown({required int index}) {
    return SlideTransition(
      position: _animations[index],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: DropdownButtonFormField<StateModal>(
          value: selectedState,
          decoration: InputDecoration(
            labelText: 'Select State',
            labelStyle: TextStyle(color: Colors.red.shade900),
            prefixIcon: Icon(Icons.location_on, color: Colors.red.shade900),
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade900),
            ),
          ),
          items: widget.statelist.map<DropdownMenuItem<StateModal>>((StateModal state) {
            return DropdownMenuItem<StateModal>(value: state, child: Text(state.stateName));
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedState = value;
            });
          },
          validator: (value) {
            if (value == null) {
              return 'Please select a state';
            }
            return null;
          },
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Email address';
    } else if (!value.contains('@')) {
      return 'Please enter a valid Email';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your address';
    }
    return null;
  }

  String? _validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your city';
    }
    return null;
  }

  String? _validatePincode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your pincode';
    } else if (value.length != 6) {
      return 'Pincode should be 6 digits';
    }
    return null;
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to update the details?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  postdata(
                    context,
                    employeeIdController.text,
                    CompanyIdController.text,
                    emailController.text,
                    addressController.text,
                    cityController.text,
                    pincodeController.text,
                    selectedState?.stateId ?? '',
                  );
                  Navigator.of(context).pop(); // Close dialog
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
