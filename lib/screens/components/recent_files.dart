import 'package:admin/API/SalesService/service.dart';
import 'package:admin/API/StockService/service.dart';
import 'package:admin/API/SupplierService/service.dart';
import 'package:admin/API/VendorService/service.dart';
import 'package:admin/ResponseModels/sales_model.dart';
import 'package:admin/ResponseModels/stock_model.dart';
import 'package:admin/ResponseModels/supplier_model.dart';
import 'package:admin/ResponseModels/vendor_model.dart';
import 'package:admin/responsive.dart';

import 'package:flutter/material.dart';

import '../../constants.dart';

class SalesList extends StatefulWidget {
  const SalesList({Key? key}) : super(key: key);

  @override
  State<SalesList> createState() => _SalesListState();
}

class _SalesListState extends State<SalesList> {
  late List<SaleModel> sales = [];
  late SaleModel sale = sales[0];
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
                        label: Text("IMEI"),
                      ),
                      if (!Responsive.isMobile(context))
                        DataColumn(
                          label: Text("Status"),
                        ),
                      if (!Responsive.isMobile(context))
                        DataColumn(
                          label: Text("Warranty"),
                        ),
                      DataColumn(
                        label: Text("Payment"),
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
                          DataCell(Text("${sales[index].imei}")),
                          if (!Responsive.isMobile(context))
                            DataCell(Text("${sales[index].status}")),
                          if (!Responsive.isMobile(context))
                            DataCell(Text("${sales[index].warrantyStatus}")),
                          DataCell(invoicedAmount(sales[index].invoicedAmount)
                              ? Text("Full")
                              : Text("Partial")),
                          DataCell(PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert),
                            onSelected: (String result) {
                              switch (result) {
                                case 'Option 1':
                                  setSale(sales[index]);
                                  break;
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'Option 1',
                                child: Text('More Details'),
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
  late StockModel singleStock = stock[0];
  bool stockPage = true;

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

  pageSwitch() {
    setState(() {
      if (stockPage == false) {
        stockPage = true;
      } else {
        stockPage = false;
      }
    });
  }

  void initState() {
    super.initState();
    getSuppliers();
  }

  @override
  Widget build(BuildContext context) {
    return stockPage
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
                        label: Text("Supplier"),
                      ),
                      if (!Responsive.isMobile(context))
                        DataColumn(
                          label: Text("Imei"),
                        ),
                      if (!Responsive.isMobile(context))
                        DataColumn(
                          label: Text("Warranty"),
                        ),
                      if (!Responsive.isMobile(context))
                        DataColumn(
                          label: Text("Amount"),
                        ),
                      DataColumn(
                        label: Text(""),
                      ),
                    ],
                    rows: List.generate(
                      stock.length,
                      (index) => DataRow(
                        cells: [
                          DataCell(
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: defaultPadding),
                                  child: Text(stock[index].product),
                                ),
                              ],
                            ),
                          ),
                          DataCell(Text("${stock[index].supplier.supplier}")),
                          if (!Responsive.isMobile(context))
                            DataCell(Text("${stock[index].imei}")),
                          if (!Responsive.isMobile(context))
                            DataCell(Text("${stock[index].warrantyDuration}")),
                          if (!Responsive.isMobile(context))
                            DataCell(Text("${stock[index].amount}")),
                          DataCell(PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert),
                            onSelected: (String result) {
                              switch (result) {
                                case 'Option 1':
                                  pageSwitch();
                                  break;
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'Option 1',
                                child: Text('More Details'),
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
        : Stock(
            stock: singleStock,
            onpressed: pageSwitch,
          );
  }
}

class Stock extends StatelessWidget {
  const Stock({Key? key, required this.stock, required this.onpressed})
      : super(key: key);
  final StockModel stock;
  final Function onpressed;

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
                '${stock.product}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Spacer(),
              TextButton(
                  onPressed: () => onpressed(), child: Text('Back to Stocks'))
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
                          Text('Product:'),
                          SizedBox(width: 12),
                          Text(stock.product,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('IMEI:'),
                          SizedBox(width: 12),
                          Text(stock.imei.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Warranty Duration:'),
                          SizedBox(width: 12),
                          Text(stock.warrantyDuration,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Price:'),
                          SizedBox(width: 12),
                          Text(stock.amount.toString(),
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
                          Text('Status:'),
                          SizedBox(width: 12),
                          Text(stock.status,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(height: 10),
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

class SuppliersList extends StatefulWidget {
  const SuppliersList({Key? key}) : super(key: key);

  @override
  State<SuppliersList> createState() => _SuppliersListState();
}

class _SuppliersListState extends State<SuppliersList> {
  late List<SupplierModel> suppliers = [];
  bool suppliersPage = true;

  getSuppliers() {
    SupplierService().getSuppliers().then((value) {
      print(value);
      setState(() {
        suppliers = value
            .map((dynamic supplier) => SupplierModel.fromJson(supplier))
            .toList();
      });
    });
  }

  pageSwitch() {
    setState(() {
      if (suppliersPage == false) {
        suppliersPage = true;
      } else {
        suppliersPage = false;
      }
    });
  }

  @override
  void initState() {
    getSuppliers();
    super.initState();
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
            "Vendors",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Vendor"),
                ),
                DataColumn(
                  label: Text("Supplier"),
                ),
                if (!Responsive.isMobile(context))
                  DataColumn(
                    label: Text("Products"),
                  ),
                DataColumn(
                  label: Text(""),
                ),
              ],
              rows: List.generate(
                suppliers.length,
                (index) => DataRow(
                  cells: [
                    DataCell(
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding),
                            child: Text(suppliers[index].name),
                          ),
                        ],
                      ),
                    ),
                    DataCell(Text("${suppliers[index].supplier}")),
                    DataCell(Text("${suppliers[index].productsCount}")),
                    DataCell(PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert),
                      onSelected: (String result) {
                        switch (result) {
                          case 'Option 1':
                            pageSwitch();
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'Option 1',
                          child: Text('More Details'),
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
    );
  }
}

class VendorsList extends StatefulWidget {
  const VendorsList({Key? key}) : super(key: key);

  @override
  State<VendorsList> createState() => _VendorsListState();
}

class _VendorsListState extends State<VendorsList> {
  late List<VendorModel> vendors = [];
  bool vendorsPage = true;

  getVendors() {
    VendorService().getVendors().then((value) {
      setState(() {
        vendors = value
            .map((dynamic vendor) => VendorModel.fromJson(vendor))
            .toList();
      });
    });
  }

  pageSwitch() {
    setState(() {
      if (vendorsPage == false) {
        vendorsPage = true;
      } else {
        vendorsPage = false;
      }
    });
  }

  @override
  void initState() {
    getVendors();
    super.initState();
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
            "Vendors",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Vendor"),
                ),
                DataColumn(
                  label: Text("Supplier"),
                ),
                if (!Responsive.isMobile(context))
                  DataColumn(
                    label: Text("Products"),
                  ),
                DataColumn(
                  label: Text(""),
                ),
              ],
              rows: List.generate(
                vendors.length,
                (index) => DataRow(
                  cells: [
                    DataCell(
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding),
                            child: Text(vendors[index].name),
                          ),
                        ],
                      ),
                    ),
                    DataCell(Text("${vendors[index].supplier}")),
                    DataCell(Text("${vendors[index].products.length}")),
                    DataCell(PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert),
                      onSelected: (String result) {
                        switch (result) {
                          case 'Option 1':
                            pageSwitch();
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'Option 1',
                          child: Text('More Details'),
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
    );
  }
}
