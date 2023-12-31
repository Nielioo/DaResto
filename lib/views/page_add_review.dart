part of 'pages.dart';

class AddReviewPage extends StatefulWidget {
  static const String routeName = '/add-review';
  final String id;

  const AddReviewPage({super.key, required this.id});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Review'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<CustomerReviewProvider>(
            builder: (context, state, _) {
              return Form(
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
                    Gap.h16,
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          state
                              .postCustomerReview(widget.id,
                                  _nameController.text, _reviewController.text)
                              .then(
                            (_) {
                              Navigator.pop(context, true);
                            },
                          );
                        }
                      },
                      child: const Text('Submit Review'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
