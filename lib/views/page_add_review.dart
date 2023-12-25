part of 'pages.dart';

class AddReviewPage extends StatefulWidget {
  static const String routeName = '/add-review';

  const AddReviewPage({super.key});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Listen variable changes, best for calling variable
    final watchCustomerReview = context.watch<CustomerReviewProvider>();

    // Only read variable, not for listen changes, best for calling function
    final readCustomerReview = context.read<CustomerReviewProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Review'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Space.medium),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _reviewController,
                  decoration: const InputDecoration(labelText: 'Review'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your review';
                    }
                    return null;
                  },
                ),
                DaSpacer.vertical(space: Space.large),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var review = CustomerReview(
                        name: _nameController.text,
                        review: _reviewController.text,
                        date: DateTime.now().toIso8601String(),
                      );
                      watchCustomerReview.postCustomerReview(review);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Submit Review'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
