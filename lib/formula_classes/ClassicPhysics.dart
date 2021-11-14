import 'dart:math';

class ClassicPhysics{
  force(paramList) {
    double m = double.parse(paramList['m'].text);
    double me = double.parse(paramList['me'].text);
    double a = double.parse(paramList['a'].text);
    double ae = double.parse(paramList['ae'].text);
    return (m+me)*(a+ae);
  }
  kineticEnergy(paramList) {
    double m = double.parse(paramList['m'].text);
    double me = double.parse(paramList['me'].text);
    double v = double.parse(paramList['v'].text);
    double ve = double.parse(paramList['ve'].text);
    return (m+me)*pow(v,2)/2;
  }
  potentialEnergy(paramList) {
    double m = double.parse(paramList['m'].text);
    double g = double.parse(paramList['g'].text);
    double h = double.parse(paramList['h'].text);
    return m*g*h;
  }
  pythagoreanTheorem(paramList) {
    double a = double.parse(paramList['a'].text);
    double b = double.parse(paramList['b'].text);
    return sqrt(pow(a, 2)+pow(b, 2));
  }
}