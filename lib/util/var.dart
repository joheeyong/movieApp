import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

const baseUrl = 'https://api.themoviedb.org/3';
const apiKey = '0a6c0b2c95e6a608a491267361eab2c3';

DateFormat dateFormat = DateFormat("yyyy-MM-dd");

final shimmer = Shimmer(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Colors.grey[900]!,
          Colors.grey[900]!,
          Colors.grey[800]!,
          Colors.grey[900]!,
          Colors.grey[900]!
        ],
        stops: const <double>[
          0.0,
          0.35,
          0.5,
          0.65,
          1.0
        ]),
    child: Container(
      width: 140.0,
      height: 220.0,
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(),
      ),
    ));
