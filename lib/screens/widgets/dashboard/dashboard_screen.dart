// import 'package:admin/API/SalesService/service.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/components/my_fields.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../components/header.dart';

import '../../components/recent_files.dart';
import '../../components/storage_details.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _pickedAtShop = false;

  // Product Details Controllers
  final TextEditingController _imeiController = TextEditingController();

  final TextEditingController _deliveredByController = TextEditingController();

  final TextEditingController _statusController = TextEditingController();

  final TextEditingController _warrantyStatusController =
      TextEditingController();

  final TextEditingController _paymentMethodController =
      TextEditingController();

  final TextEditingController _amountController = TextEditingController();

  final TextEditingController _invoicedAmountController =
      TextEditingController();

  final TextEditingController _expenseController = TextEditingController();

  final TextEditingController _expenseAmountController =
      TextEditingController();

  // Client Details Controllers
  final TextEditingController _clientNameController = TextEditingController();

  final TextEditingController _clientEmailController = TextEditingController();

  final TextEditingController _clientLocationController =
      TextEditingController();

  final TextEditingController _clientPinController = TextEditingController();

  newSale() {
    int _currentStep = 0;

    List<Step> stepList() => [
          Step(
            state: _currentStep <= 0 ? StepState.editing : StepState.complete,
            isActive: _currentStep >= 0,
            title: Text('Product Details'),
            content: Column(
              children: [
                TextField(
                  controller: _imeiController,
                  decoration: InputDecoration(labelText: 'IMEI'),
                ),
                TextField(
                  controller: _deliveredByController,
                  decoration: InputDecoration(labelText: 'Delivered By'),
                ),
                TextField(
                  controller: _statusController,
                  decoration: InputDecoration(labelText: 'Status'),
                ),
                TextField(
                  controller: _warrantyStatusController,
                  decoration: InputDecoration(labelText: 'Warranty Status'),
                ),
                TextField(
                  controller: _paymentMethodController,
                  decoration: InputDecoration(labelText: 'Payment Method'),
                ),
                TextField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _invoicedAmountController,
                  decoration: InputDecoration(labelText: 'Invoiced Amount'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _expenseController,
                  decoration: InputDecoration(labelText: 'Expense'),
                ),
                TextField(
                  controller: _expenseAmountController,
                  decoration: InputDecoration(labelText: 'Expense Amount'),
                  keyboardType: TextInputType.number,
                ),
                CheckboxListTile(
                  title: Text('Picked at Shop'),
                  value: _pickedAtShop,
                  onChanged: (bool? value) {
                    setState(() {
                      _pickedAtShop = !_pickedAtShop;
                    });
                  },
                ),
              ],
            ),
          ),
          Step(
            state: _currentStep <= 1 ? StepState.editing : StepState.complete,
            isActive: _currentStep >= 1,
            title: Text('Client Details'),
            content: Column(
              children: [
                TextField(
                  controller: _clientNameController,
                  decoration: InputDecoration(labelText: 'Client Name'),
                ),
                TextField(
                  controller: _clientEmailController,
                  decoration: InputDecoration(labelText: 'Client Email'),
                ),
                TextField(
                  controller: _clientLocationController,
                  decoration: InputDecoration(labelText: 'Client Location'),
                ),
                TextField(
                  controller: _clientPinController,
                  decoration: InputDecoration(labelText: 'Client PIN'),
                ),
              ],
            ),
          ),
        ];
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text("New Sale"),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: StatefulBuilder(
                builder: (context, setState) {
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;

                  return SizedBox(
                      height: height - 100,
                      width: width - 800,
                      child: Stepper(
                        steps: stepList(),
                        type: StepperType.horizontal,
                        currentStep: _currentStep,
                        onStepContinue: () {
                          if (_currentStep < (stepList().length - 1)) {
                            setState(() {
                              _currentStep += 1;
                            });
                          } else if (_currentStep == (stepList().length - 1)) {
                            Navigator.pop(ctx);
                            //          var product = _imeiController.text;
                            // var deliveredBy = _deliveredByController.text;
                            // var status = _statusController.text;
                            // var warrantyStatus = _warrantyStatusController.text;
                            // var paymentMethod = _paymentMethodController.text;
                            // var amount = int.parse(_amountController.text);
                            // var invoicedAmount = int.parse(_invoicedAmountController.text);
                            // var expense = _expenseController.text;
                            // var expenseAmount = int.parse(_expenseAmountController.text);
                            // var clientName = _clientNameController.text;
                            // var clientEmail = _clientEmailController.text;
                            // var clientLocation = _clientLocationController.text;
                            // var clientPin = _clientPinController.text;

                            // Call your API or handle the captured data
                            // SalesService().postSale(
                            //   product,
                            //   deliveredBy,
                            //   status,
                            //   warrantyStatus,
                            //   paymentMethod,
                            //   amount,
                            //   invoicedAmount,
                            //   expense,
                            //   expenseAmount,
                            //   clientName,
                            //   clientEmail,
                            //   clientLocation,
                            //   clientPin,
                            // );
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    DashboardScreen()));
                          } else {
                            return;
                          }
                        },
                        onStepCancel: () {
                          setState(() {
                            _currentStep > 0
                                ? _currentStep -= 1
                                : Navigator.pop(ctx);
                          });
                        },
                        onStepTapped: (int value) {
                          setState(() {
                            _currentStep = value;
                          });
                        },
                      ));
                },
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(Page: "Dashboard"),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Overalls(
                        overalls: "Sales Overalls",
                        onpressed: newSale,
                      ),
                      SizedBox(height: defaultPadding),
                      SalesList(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) SupplierDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: SupplierDetails(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
