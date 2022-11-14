import 'dart:math';
import 'constant.dart';

import 'package:flutter/material.dart';

class Calculator {
  int octet1, octet2, octet3, octet4, prefix;

  Calculator(
      {required this.octet1,
      required this.octet2,
      required this.octet3,
      required this.octet4,
      required this.prefix});

  String _convertToBin(int value) {
    String data = '';
    var j = 9;
    for (var i = 1; i < j; i++) {
      if (value.toRadixString(2).toString().length == i) {
        data = '0' * (j - i - 1) + value.toRadixString(2).toString();
        j--;
      }
    }
    return data;
  }

  int getHosts() {
    return pow(2, 32 - prefix).toInt();
  }

  String getIpClass() {
    if (prefix > 8 && prefix <= 15) {
      return "A";
    } else if (prefix > 15 && prefix <= 23) {
      return "B";
    } else if (prefix > 23 && prefix <= 32) {
      return "C";
    }
    return 'N/A';
  }

  String getIpType() {
    if (octet1 == 10) {
      return 'Private';
    } else if (octet1 == 172 && (octet2 >= 16 && octet2 <= 31)) {
      return 'Private';
    } else if (octet1 == 192 && octet2 == 168) {
      return 'Private';
    } else {
      return 'Public';
    }
  }

  String getIpAddress() {
    return "$octet1.$octet2.$octet3.$octet4";
  }

  String getNetwork({int add = 0}) {
    int node1;
    int node2;
    int node3;
    int node4;
    num netmask;

    if (prefix >= 8 && prefix <= 15) {
      netmask = pow(2, 16 - prefix);
      node1 = octet1;
      node2 = ((octet2 / netmask).floor() * netmask).toInt();
      node3 = 0;
      node4 = 0 + add;
    } else if (prefix > 15 && prefix <= 23) {
      netmask = pow(2, 24 - prefix);
      node1 = octet1;
      node2 = octet2;
      node3 = ((octet3 / netmask).floor() * netmask).toInt();
      node4 = 0 + add;
    } else if (prefix > 23 && prefix < 32) {
      netmask = pow(2, 32 - prefix);
      node1 = octet1;
      node2 = octet2;
      node3 = octet3;
      node4 = ((octet4 / netmask).floor() * netmask).toInt() + add;
    } else if (prefix == 32) {
      node1 = octet1;
      node2 = octet2;
      node3 = octet3;
      node4 = octet4;
    } else {
      node1 = 0;
      node2 = 0;
      node3 = 0;
      node4 = 0;
    }

    return "$node1.$node2.$node3.$node4";
  }

  String getBroadcast({int sub = 0}) {
    int node1;
    int node2;
    int node3;
    int node4;
    num netmask;

    if (prefix > 8 && prefix <= 15) {
      netmask = pow(2, 16 - prefix);
      node1 = octet1;
      node2 =
          ((octet2 / netmask).floor() * netmask).toInt() + netmask.toInt() - 1;
      node3 = 255;
      node4 = 255 - sub;
    } else if (prefix > 15 && prefix <= 23) {
      netmask = pow(2, 24 - prefix);
      node1 = octet1;
      node2 = octet2;
      node3 =
          ((octet3 / netmask).floor() * netmask).toInt() + netmask.toInt() - 1;
      node4 = 255 - sub;
    } else if (prefix > 23 && prefix <= 32) {
      netmask = pow(2, 32 - prefix);
      node1 = octet1;
      node2 = octet2;
      node3 = octet3;
      node4 = ((octet4 / netmask).floor() * netmask).toInt() +
          netmask.toInt() -
          1 -
          sub;
    } else {
      node1 = 255;
      node2 = 255;
      node3 = 255;
      node4 = 255;
    }

    return "$node1.$node2.$node3.$node4";
  }

  String getSubnetMask() {
    int node1 = 256;
    int node2 = 256;
    int node3 = 256;
    int node4 = 256;
    num netmask;

    if (prefix >= 8 && prefix <= 15) {
      netmask = pow(2, 16 - prefix);
      node1 = node1 - 1;
      node2 = node2 - netmask.toInt();
      node3 = 0;
      node4 = 0;
    } else if (prefix > 15 && prefix <= 23) {
      netmask = pow(2, 24 - prefix);
      node1 = node1 - 1;
      node2 = node2 - 1;
      node3 = node3 - netmask.toInt();
      node4 = 0;
    } else if (prefix > 23 && prefix < 32) {
      netmask = pow(2, 32 - prefix);
      node1 = node1 - 1;
      node2 = node2 - 1;
      node3 = node3 - 1;
      node4 = node4 - netmask.toInt();
    } else if (prefix == 32) {
      node1 = 255;
      node2 = 255;
      node3 = 255;
      node4 = 255;
    }

    return "$node1.$node2.$node3.$node4";
  }

  String getBinarySubnetMask() {
    List<String> data = getSubnetMask().split('.');
    return "${_convertToBin(int.parse(data[0]))}.${_convertToBin(int.parse(data[1]))}.${_convertToBin(int.parse(data[2]))}.${_convertToBin(int.parse(data[3]))}";
  }

  String getWildcardMask() {
    List<String> data = getSubnetMask().split('.');

    for (var i = 0; i < data.length; i++) {
      data[i] = (255 - int.parse(data[i])).toString();
    }

    return "${data[0]}.${data[1]}.${data[2]}.${data[3]}";
  }

  int getTotalUsableHost() {
    if (prefix == 32) {
      return 0;
    } else {
      return getHosts() - 2;
    }
  }

  String getUsableHost() {
    if (prefix == 32) {
      return "N/A\n";
    } else {
      return "${getNetwork(add: 1)}  -  \n${getBroadcast(sub: 1)}";
    }
  }

  String getBinaryIp() {
    return "${_convertToBin(octet1)}.${_convertToBin(octet2)}.${_convertToBin(octet3)}.${_convertToBin(octet4)}";
  }

  Container result() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Wrap(
              direction: Axis.vertical,
              spacing: 2,
              children: const [
                Text("IP Address", style: keyTextStyle),
                Text("Network", style: keyTextStyle),
                Text("Broadcast", style: keyTextStyle),
                Text("Subnet Mask", style: keyTextStyle),
                // Text("Binary Subnet Mask : ", style: keyTextStyle),
                Text("Wildcard Mask", style: keyTextStyle),
                Text("Total Hosts", style: keyTextStyle),
                Text("Total Usable Hosts", style: keyTextStyle),
                Text("Usable Host\n", style: keyTextStyle),
                Text("CIDR Notation", style: keyTextStyle),
                Text("IP Class", style: keyTextStyle),
                Text("IP Type", style: keyTextStyle),
                // Text("Binary IP Address : ", style: keyTextStyle),
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              child: Wrap(
                direction: Axis.vertical,
                spacing: 2,
                children: [
                  Text(getIpAddress(), style: textStyle),
                  Text(getNetwork(), style: textStyle),
                  Text(getBroadcast(), style: textStyle),
                  Text(getSubnetMask(), style: textStyle),
                  // Text(getBinarySubnetMask(), style: textStyle),
                  Text(getWildcardMask(), style: textStyle),
                  Text(getHosts().toString(), style: textStyle),
                  Text(getTotalUsableHost().toString(), style: textStyle),
                  Text(getUsableHost(), style: textStyle),
                  Text("/" + prefix.toString(), style: textStyle),
                  Text(getIpClass(), style: textStyle),
                  Text(getIpType(), style: textStyle),
                  // Text(getBinaryIp(), style: textStyle),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
