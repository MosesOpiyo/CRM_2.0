import 'package:admin/API/SalesService/service.dart';
import 'package:admin/API/StockService/service.dart';
import 'package:admin/ResponseModels/sales_model.dart';
import 'package:admin/ResponseModels/stock_model.dart';

import 'package:flutter/material.dart';

import '../../constants.dart';

class SalesList extends StatefulWidget {
  const SalesList({Key? key}) : super(key: key);

  @override
  State<SalesList> createState() => _SalesListState();
}

class _SalesListState extends State<SalesList> {
  late List<SaleModel> sales = [];
  late SaleModel sale = SaleModel(
      id: 0,
      product: 'None',
      imei: 0,
      supplier: 'None',
      deliveredToClientBy: 'none',
      clientName: 'None',
      status: 'None',
      cash: 0,
      mpesa: 0,
      warrantyStatus: 'None',
      invoicedAmount: 0);
  bool salesPage = true;

  getSales() {
    SalesService().getSales().then((value) {
      setState(() {
        sales = value
            .map((dynamic saleValue) => SaleModel.fromJson(saleValue))
            .toList();
      });
    });
  }

  setSale(SaleModel selectedSale) {
    setState(() {
      sale = selectedSale;
      if (salesPage == false) {
        salesPage = true;
      } else {
        salesPage = false;
      }
    });
  }

  pageSwitch() {
    setState(() {
      if (salesPage == false) {
        salesPage = true;
      } else {
        salesPage = false;
      }
    });
  }

  void initState() {
    super.initState();
    getSales();
  }

  @override
  Widget build(BuildContext context) {
    return salesPage
        ? Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sales',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    columnSpacing: defaultPadding,
                    // minWidth: 600,
                    columns: [
                      DataColumn(
                        label: Text("Product"),
                      ),
                      DataColumn(
                        label: Text("Supplier"),
                      ),
                      DataColumn(
                        label: Text("IMEI"),
                      ),
                      DataColumn(
                        label: Text("Client"),
                      ),
                      DataColumn(
                        label: Text("Payment Status"),
                      ),
                      DataColumn(
                        label: Text(""),
                      ),
                    ],
                    rows: List.generate(
                      sales.length,
                      (index) => DataRow(
                        cells: [
                          DataCell(
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: defaultPadding),
                                  child: Text(sales[index].product),
                                ),
                              ],
                            ),
                          ),
                          DataCell(Text("${sales[index].supplier}")),
                          DataCell(Text("${sales[index].imei}")),
                          DataCell(Text("${sales[index].clientName}")),
                          DataCell(invoicedAmount(sales[index].invoicedAmount)
                              ? Text("Full Payment")
                              : Text("Partial Payment")),
                          DataCell(PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert),
                            onSelected: (String result) {
                              switch (result) {
                                case 'Option 1':
                                  setSale(sales[index]);
                                  break;
                                case 'Option 2':
                                  print('Option 2 selected');
                                  break;
                                case 'Option 3':
                                  print('Option 3 selected');
                                  break;
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'Option 1',
                                child: Text('More Details'),
                              ),
                              PopupMenuItem<String>(
                                value: 'Option 2',
                                child: Text('Option 2'),
                              ),
                              PopupMenuItem<String>(
                                value: 'Option 3',
                                child: Text('Option 3'),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Sale(
            sale: sale,
            onpressed: pageSwitch,
          );
  }
}

bool invoicedAmount(invoicedAmountIsPresent) {
  if (invoicedAmountIsPresent == 0) {
    return true;
  }
  return false;
}

class Sale extends StatelessWidget {
  const Sale({Key? key, required this.sale, required this.onpressed})
      : super(key: key);
  final SaleModel sale;
  final Function onpressed;

  bool invoicedAmount(invoicedAmountIsPresent) {
    if (invoicedAmountIsPresent == 0) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${sale.product} Sale',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Spacer(),
              TextButton(
                  onPressed: () => onpressed(), child: Text('Back to Sales'))
            ],
          ),
          SizedBox(height: 15),
          SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Supplier:'),
                          SizedBox(width: 12),
                          Text(sale.supplier,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('IMEI:'),
                          SizedBox(width: 12),
                          Text(sale.supplier,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Client name:'),
                          SizedBox(width: 12),
                          Text(sale.clientName,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Status:'),
                          SizedBox(width: 12),
                          Text(sale.status,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Warranty:'),
                          SizedBox(width: 12),
                          Text(sale.warrantyStatus,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Payment:'),
                          SizedBox(width: 12),
                          invoicedAmount(sale.invoicedAmount)
                              ? Text("Fully Paid",
                                  style: TextStyle(fontWeight: FontWeight.bold))
                              : Text("Partially Paid",
                                  style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Client name:'),
                          SizedBox(width: 12),
                          Text(sale.clientName,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Status:'),
                          SizedBox(width: 12),
                          Text(sale.status,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  ),
                  Spacer()
                ],
              )),
        ],
      ),
    );
  }
}

class StockList extends StatefulWidget {
  final String Option;
  const StockList({
    required this.Option,
    Key? key,
  }) : super(key: key);

  @override
  State<StockList> createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  late List<StockModel> stock = [];

  getSuppliers() {
    StockService().getStock().then((value) {
      print(value);
      setState(() {
        stock = value
            .map((dynamic stockValue) => StockModel.fromJson(stockValue))
            .toList();
      });
    });
  }

  void initState() {
    super.initState();
    getSuppliers();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.Option,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Product"),
                ),
                DataColumn(
                  label: Text("Units"),
                ),
                DataColumn(
                  label: Text("Number of Sales"),
                ),
              ],
              rows: List.generate(
                stock.length,
                (index) => dataRow(stock[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow dataRow(StockModel stock) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(stock.product),
            ),
          ],
        ),
      ),
      DataCell(Text("${stock.units.toString()} Units")),
      DataCell(Text("${stock.clients.length.toString()} Clients")),
    ],
  );
}
