import 'package:flutter/material.dart';

import '../../constants.dart';
import 'storage_info_card.dart';

class SupplierDetails extends StatelessWidget {
  const SupplierDetails({
    Key? key,
  }) : super(key: key);

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
            "SUppliers Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          StorageInfoCard(
            title: "Documents Files",
            numOfFiles: 1328,
          ),
          StorageInfoCard(
            title: "Media Files",
            numOfFiles: 1328,
          ),
          StorageInfoCard(
            title: "Other Files",
            numOfFiles: 1328,
          ),
          StorageInfoCard(
            title: "Unknown",
            numOfFiles: 140,
          ),
        ],
      ),
    );
  }
}
