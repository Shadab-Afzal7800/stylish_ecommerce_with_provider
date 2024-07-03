import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text('Checkout'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: CheckoutForm(),
      ),
    );
  }
}

class CheckoutForm extends StatefulWidget {
  const CheckoutForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CheckoutFormState createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Personal Details'),
          const DetailTextFormField(
            label: 'Email Address',
          ),
          const DetailTextFormField(
            label: 'Full Name',
          ),
          const SectionTitle(title: 'Address Details'),
          const DetailTextFormField(
            label: 'Pincode',
          ),
          const DetailTextFormField(
            label: 'Address',
          ),
          const DetailTextFormField(
            label: 'City',
          ),
          const DetailTextFormField(
            label: 'State',
          ),
          const DetailTextFormField(
            label: 'Country',
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {},
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: Colors.red),
                child: const Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ),
          ),
          const Center(child: Icon(Icons.arrow_right_alt)),
          const Center(
              child: Text(
                  "All the way to checkout and Payment module\n(To be implemented)"))
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class DetailTextFormField extends StatelessWidget {
  final String label;

  const DetailTextFormField({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
