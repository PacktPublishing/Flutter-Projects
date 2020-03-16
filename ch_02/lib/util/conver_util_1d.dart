class Conversion {
  //helps transform the strings in numbers for the List
  final int w = 8;
  Map<String, int> measures = {
    'meters' : 0,
    'kilometers' : 1,
    'grams' : 2,
    'kilograms' : 3,
    'feet' : 4,
    'miles' : 5,
    'pounds (lbs)' : 6,
    'ounces' : 7,
  };
  //builds the list containing the formulas (x + y*width)
  List<double> formulas;
  Conversion() {
    formulas = List<double>();
    //row 1
    formulas.insert(0+0*w, 1);
    formulas.insert(1+0*w, 0.001);
    formulas.insert(2+0*w, 0);
    formulas.insert(3+0*w, 0);
    formulas.insert(4+0*w, 3.28084);
    formulas.insert(5+0*w, 0.000621371);
    formulas.insert(6+0*w, 0);
    formulas.insert(7+0*w, 0);
    //row 2
    formulas.insert(0+1*w, 1000);
    formulas.insert(1+1*w, 1);
    formulas.insert(2+1*w, 0);
    formulas.insert(3+1*w, 0);
    formulas.insert(4+1*w, 3280.84);
    formulas.insert(5+1*w, 0.621371);
    formulas.insert(6+1*w, 0);
    formulas.insert(7+1*w, 0);
    //row 3
    formulas.insert(0+2*w, 0);
    formulas.insert(1+2*w, 0);
    formulas.insert(2+2*w, 1);
    formulas.insert(3+2*w, 0.0001);
    formulas.insert(4+2*w, 0);
    formulas.insert(5+2*w, 0);
    formulas.insert(6+2*w, 0.00220462);
    formulas.insert(7+2*w, 0.035274);
    //row 4
    formulas.insert(0+3*w, 0);
    formulas.insert(1+3*w, 0);
    formulas.insert(2+3*w, 1000);
    formulas.insert(3+3*w, 1);
    formulas.insert(4+3*w, 0);
    formulas.insert(5+3*w, 0);
    formulas.insert(6+3*w, 2.20462);
    formulas.insert(7+3*w, 35.274);
    //row 5
    formulas.insert(0+4*w, 0.3048);
    formulas.insert(1+4*w, 0.0003048);
    formulas.insert(2+4*w, 0);
    formulas.insert(3+4*w, 0);
    formulas.insert(4+4*w, 1);
    formulas.insert(5+4*w, 0.000189394);
    formulas.insert(6+4*w, 0);
    formulas.insert(7+4*w, 0);
    //row 6
    formulas.insert(0+5*w, 1609.34);
    formulas.insert(1+5*w, 1.60934);
    formulas.insert(2+5*w, 0);
    formulas.insert(3+5*w, 0);
    formulas.insert(4+5*w, 5280);
    formulas.insert(5+5*w, 1);
    formulas.insert(6+5*w, 0);
    formulas.insert(7+5*w, 0);
    //row 7
    formulas.insert(0+6*w, 0);
    formulas.insert(1+6*w, 0);
    formulas.insert(2+6*w, 453.592);
    formulas.insert(3+6*w, 0.453592);
    formulas.insert(4+6*w, 0);
    formulas.insert(5+6*w, 0);
    formulas.insert(6+6*w, 1);
    formulas.insert(7+6*w, 16);
    //row 8
    formulas.insert(0+7*w, 0);
    formulas.insert(1+7*w, 0);
    formulas.insert(2+7*w, 28.3495);
    formulas.insert(3+7*w, 0.0283495);
    formulas.insert(4+7*w, 3.28084);
    formulas.insert(5+7*w, 0);
    formulas.insert(6+7*w, 0.0625);
    formulas.insert(7+7*w, 1);
  }

  double convert(double value, String from, String to) {
    int nFrom = measures[from];
    int nTo = measures[to];
    double multiplier = formulas[nTo+w*nFrom];
    return value * multiplier;
  }
}