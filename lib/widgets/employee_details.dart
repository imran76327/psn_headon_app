import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headon/widgets/edit_bank_details.dart';
import '../bloc/employee/employee_bloc.dart';
import 'edit_employee_details.dart';


class EmployeeDetailsScreen extends StatelessWidget {
  final String employeeId;
  final String companyId;

  const EmployeeDetailsScreen({super.key, required this.employeeId, required this.companyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
      title: const Text('Employee Details'),
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
      body: BlocProvider(
        create: (context) => EmployeeBloc()..add(EmployeeFetch(employeeId, companyId)),
        child: BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            if (state is EmployeeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EmployeeSuccess) {
              final employee = state.employee;
              final statelist = state.statelist;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Personal Information Section
                      buildSectionHeader('Personal Information'),
                      buildInfoCard([
                        buildInfoRow(Icons.person, 'Name', employee.name),
                        buildInfoRow(Icons.badge, 'ID', employee.employeeId.toString()),
                        buildInfoRow(Icons.transgender, 'Gender', employee.gender),
                        buildInfoRow(Icons.phone, 'Mobile Number', employee.mobileNumber),
                        buildInfoRow(Icons.email, 'Email', employee.email),
                        buildInfoRow(Icons.location_on, 'Address', employee.address),
                        buildInfoRow(Icons.work, 'Employment Status', employee.employementStatus),
                        buildInfoRow(Icons.location_city, 'City', employee.city),
                        buildInfoRow(Icons.map, 'State', employee.state),
                        buildInfoRow(Icons.pin_drop, 'Pincode', employee.pincode),
                      ]),

                      // Company Information Section
                      buildSectionHeader('Company Information'),
                      buildInfoCard([
                        buildInfoRow(Icons.business, 'Company Name', employee.companyName),
                      ]),

                      // Bank Details Section
                      buildSectionHeader('Bank Details'),
                      buildInfoCard([
                        buildInfoRow(Icons.account_balance, 'Acc Name', employee.accountHolderName),
                        buildInfoRow(Icons.account_balance_wallet, 'Account Number', employee.accountNo),
                        buildInfoRow(Icons.account_balance, 'Bank Name', employee.bankName),
                        buildInfoRow(Icons.location_city, 'Branch Name', employee.branchName),
                        buildInfoRow(Icons.credit_card, 'IFSC Code', employee.ifscCode),
                      ]),

                      // Other Information Section
                      buildSectionHeader('Other Information'),
                      buildInfoCard([
                        buildInfoRow(Icons.assignment_ind, 'ESIC Number', employee.esic),
                        buildInfoRow(Icons.numbers, 'PF Number', employee.pfNumber),
                        buildInfoRow(Icons.account_box, 'UAN Number', employee.uanNumber),
                      ]),

                      // Edit Buttons at the bottom
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildEditButton(context, 'Edit Personal Details', Colors.red.shade900, employee, statelist),
                          const SizedBox(height: 16), // Space between buttons
                          _buildEditButton1(context, 'Edit Bank Details', Colors.grey.shade700, employee),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is EmployeeError) {
              return const Center(child: Text('Failed to load employee details'));
            } else {
              return const Center(child: Text('No employee data available'));
            }
          },
        ),
      ),
    );
  }

  // Helper method to build section headers
  Widget buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.red.shade900, // Section header color
        ),
      ),
    );
  }

  // Helper method to build an info card with a list of widgets
  // Helper method to build an info card with a list of widgets
// Helper method to build an info card with a list of widgets
Widget buildInfoCard(List<Widget> children) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15), // Border radius for the card
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2), // Shadow color
          offset: const Offset(5, 5), // Shadow on right and bottom
          blurRadius: 20.0, // Blur effect for soft shadow
        ),
      ],
    ),
    child: Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners for the card
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    ),
  );
}



  // Helper method to create a row with an icon, label, and value
  Widget buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.red.shade900), // Icon before text
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Edit Button with dynamic styles
  Widget _buildEditButton(BuildContext context, String text, Color color, var employee, var statelist) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditEmployeeDetails(
              employee: employee,
              statelist: statelist,
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50), // Makes the button bigger
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        backgroundColor: color, // Using deepPurpleAccent color for the button
        elevation: 5, // Adds shadow
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

Widget _buildEditButton1(BuildContext context, String text, Color color, var employee) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditBankDetails(
              employee: employee,
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50), // Makes the button bigger
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        backgroundColor: color, // Using deepPurpleAccent color for the button
        elevation: 5, // Adds shadow
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}

