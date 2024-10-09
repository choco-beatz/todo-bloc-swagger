import 'package:flutter/material.dart';
import 'package:todo_bloc/constant/colors.dart';

Icon addIcon() {
    return const Icon(
        Icons.add,
        size: 35,
        color: black,
      );
  }

    Icon deleteIcon() {
    return const Icon(
                                  Icons.delete_outline_rounded,
                                  color: clockColor,
                                  size: 28,
                                );
  }

  
  Icon tickIcon() {
    return const Icon(
                                          Icons.check,
                                          size: 30,
                                          color: white,
                                        );
  }

  
  Icon refreshIcon() {
    return const Icon(
              Icons.refresh,
              size: 30,
            );
  }