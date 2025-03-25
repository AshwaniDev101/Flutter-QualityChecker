
enum WhatChange{
  DEFECTIVE_LIST,
  DEFECTS_LIST,
  INSPECTED_LIST,
}

class Calculation
{
  static int totalDefective = 0;
  static int totalDefects = 0;
  static int totalInspected = 0;
  static int totalPassed = 0;
  static double totalDHU = 0;

  static List<int> defectiveList = [0,0,0,0,0,0,0,0,0,0];
  static List<int> defectsList = [0,0,0,0,0,0,0,0,0,0];
  static List<int> inspectedList = [0,0,0,0,0,0,0,0,0,0];
  static List<int> passedList = [0,0,0,0,0,0,0,0,0,0];
  static List<double> dhuList = [0,0,0,0,0,0,0,0,0,0];

}