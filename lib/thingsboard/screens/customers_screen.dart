

import '../commons.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  CustomersState createState() => CustomersState();
}

class CustomersState extends State<Customers> {
  List<Map<String, dynamic>> customers = [];
  bool isLoading = false;

  // Fetch customers
  Future<void> fetchCustomers() async {
    if (token.isEmpty) return;

    setState(() => isLoading = true);
    try {
      final pageData =
          await tbClient.getCustomerService().getCustomers(PageLink(10));
      setState(() {
        customers = pageData.data.map((customer) {
          return {
            'id': customer.id?.id,
            'title': customer.title,
            'additionalInfo': customer.additionalInfo,
          };
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      print('Error fetching customers: $e');
    }
  }

  // Add a new customer
  Future<void> addCustomerWithUser(String customerName, String userEmail, String userPassword) async {
    try {
      // Step 1: Add the Customer
      final customer = Customer(customerName);
      final createdCustomer = await tbClient.getCustomerService().saveCustomer(customer);

      if (createdCustomer.id?.id != null) {
        print('Customer created successfully: ${createdCustomer.id?.id}');

        // Step 2: Add the User for the Customer
        final user = User(userEmail, Authority.CUSTOMER_USER);

        // Associate the user with the customer
        user.customerId = createdCustomer.id;

        await tbClient.getUserService().saveUser(user);
        print('User added successfully for customer: ${createdCustomer.title}');
      }
    } catch (e) {
      print('Failed to add customer or user: $e');
    }
  }


  // Show dialog to add a new customer
  void showAddCustomerWithUserDialog() {
    final TextEditingController customerNameController = TextEditingController();
    final TextEditingController userEmailController = TextEditingController();
    final TextEditingController userPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Customer and User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: customerNameController,
                decoration: const InputDecoration(labelText: 'Customer Name'),
              ),
              TextField(
                controller: userEmailController,
                decoration: const InputDecoration(labelText: 'User Email'),
              ),
              TextField(
                controller: userPasswordController,
                decoration: const InputDecoration(labelText: 'User Password'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final customerName = customerNameController.text.trim();
                final userEmail = userEmailController.text.trim();
                final userPassword = userPasswordController.text.trim();

                if (customerName.isNotEmpty && userEmail.isNotEmpty && userPassword.isNotEmpty) {
                  addCustomerWithUser(customerName, userEmail, userPassword);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchCustomers(); // Load customers on widget initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchCustomers,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                print('customers => $customers');
                final customer = customers[index];
                return ListTile(
                  title: Text(customer['title'] ?? 'No Title'),
                  subtitle: Text(customer['additionalInfo']?['description'] ??
                      'No Description'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CustomerUsers(customerId: customer['id']),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddCustomerWithUserDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
