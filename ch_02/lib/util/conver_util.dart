class Conversion {
  //helps transform the strings in numbers for the List
  final int w = 8;
  var formulas;
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
  //builds the list containing the formulas
  //List<List<double>> formulas;
  Conversion() {
    formulas = {
      '0':[1,0.001,0,0,3.28084,0.000621371,0,0],
      '1':[1000,1,0,0,3280.84,0.621371,0,0],
      '2':[0,0,1,0.0001,0,0,0.00220462,0.035274],
      '3':[0,0,1000,1,0,0,2.20462,35.274],
      '4':[0.3048,0.0003048,0,0,1,0.000189394,0,0],
      '5':[1609.34, 1.60934,0,0,5280,1,0,0],
      '6':[0,0,453.592,0.453592,0,0,1,16],
      '7':[0,0,28.3495,0.0283495,3.28084,0,0.0625, 1],
      };
  }
  
  double convert(double value, String from, String to) {
    int nFrom = measures[from];
    int nTo = measures[to];
    var multiplier = formulas[nFrom.toString()][nTo];
    return value * multiplier;
  }
}