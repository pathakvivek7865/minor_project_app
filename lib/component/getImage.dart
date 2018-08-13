import 'package:flutter/material.dart';

getImage(String imgUrl) {
    try {
      return Image.network(imgUrl);
    } catch (exception) {
      return exception;
    }
  }