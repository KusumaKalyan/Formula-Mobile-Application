String jsonFormulaData = """
{
  "Force": {
    "formula": "F = (m+me)(a+ae)",
    "units": "kg/m^2",
    "parameters": {
      "m": {
        "name": "mass",
        "units": "kg",
        "hasDefaultValue": false,
        "hasError": true,
        "defaultError": 0
      },
      "a": {
        "name": "acceleration",
        "units": "m^2/s",
        "hasDefaultValue": false,
        "hasError": true,
        "defaultError": 0
      }
    },
    "function": "ClassicPhysics.force"
  },
  "Kinetic Energy (KE)": {
    "formula": "KE = 1/2(mv^2)",
    "units": "kg m^2/s^2",
    "parameters": {
      "m": {
        "name": "mass",
        "units": "kg",
        "hasDefaultValue": false,
        "hasError": true,
        "defaultError": 0
      },
      "v": {
        "name": "velocity",
        "units": "m/s",
        "hasDefaultValue": false,
        "hasError": true,
        "defaultError": 0
      }
    },
    "function": "ClassicPhysics.ke"
  },
  "Potential Energy (PE)": {
    "formula": "PE = mgh",
    "units": "kg m^2/s^2",
    "parameters": {
      "m": {
        "name": "mass",
        "units": "kg",
        "hasDefaultValue": false,
        "hasError": true,
        "defaultError": 0
      },
      "g": {
        "name": "gravitational acceleration",
        "units": "m/s^2",
        "hasDefaultValue": true,
        "defaultValue": 9.807,
        "hasError": true,
        "defaultError": 0
      },
      "h": {
        "name": "height",
        "units": "m",
        "hasDefaultValue": false,
        "hasError": true,
        "defaultError": 0
      }
    },
    "function": "ClassicPhysics.pe"
  },
  "Pythagorean Theorem": {
    "formula": "h = √(a²+b²)",
    "units": "length",
    "parameters": {
      "a": {
        "name": "one side of triangle",
        "units": "length",
        "hasDefaultValue": false,
        "hasError": false
      },
      "b": {
        "name": "another side of triangle",
        "units": "length",
        "hasDefaultValue": false,
        "hasError": false
      }
    },
    "function": "ClassicPhysics.pythagoreanTheory"
  }
}
""";