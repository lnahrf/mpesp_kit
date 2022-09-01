import "package:dcli/dcli.dart";

void divide() {
  print(" \n");
}

void clear() {
  print("\x1B[2J\x1B[0;0H");
}

void printLogo(bool showSubtitle) {
  print(blue(""" 
                                                                                       
88b           d88  88888888ba   88888888888   ad88888ba   88888888ba   88      a8P   88  888888888888  
888b         d888  88       8b  88           d8       8b  88       8b  88    ,88     88       88       
88 8b       d8 88  88      ,8P  88           Y8,          88      ,8P  88  ,88       88       88       
88  8b     d8  88  88aaaaaa8P   88aaaaa       Y8aaaaa,    88aaaaaa8P   88,d88        88       88       
88   8b   d8   88  88******     88*****         *****8b,  88******     8888888,      88       88       
88    8b d8    88  88           88                    8b  88           88P   Y8b     88       88       
88     888     88  88           88           Y8a     a8P  88           88      88,   88       88       
88      8      88  88           88888888888    Y88888P    88           88       Y8b  88       88  

${showSubtitle ? getSubtitle() : ""}
"""));
}

String getSubtitle() {
  return "MicroPython ESP Toolkit, v1.0.0";
}
