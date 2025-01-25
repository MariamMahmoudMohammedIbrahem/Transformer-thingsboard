

import '../commons.dart';

class CustomerUsers extends StatefulWidget {
  final String customerId;

  const CustomerUsers({super.key, required this.customerId});

  @override
  CustomerUsersState createState() => CustomerUsersState();
}

class CustomerUsersState extends State<CustomerUsers> {
  List<User> users = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCustomerUsers();
  }

  // Fetch users for the given customer
  Future<void> fetchCustomerUsers() async {
    setState(() => isLoading = true);
    try {
      final pageData = await tbClient.getUserService().getCustomerUsers(
            widget.customerId,
            PageLink(10),
          );
      setState(() {
        users = pageData.data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      print('Error fetching customer users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Users')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : users.isEmpty
              ? const Center(child: Text('No users found for this customer'))
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      title: Text(user.firstName ?? 'No Name'),
                      subtitle: Text(user.email),
                    );
                  },
                ),
    );
  }
}
