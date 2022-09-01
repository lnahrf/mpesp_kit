abstract class Tools {
  static final Tool Flash =
      Tool("Flash", "Used to flash a new MicroPython firmware");
  static final Tool Transfer =
      Tool("Transfer", "Used to transfer files to MicroPython's file system");
  static final Tool Delete = Tool("Delete",
      "Used to delete a file or files from MicroPython's file system");
  static final Tool SoftReset =
      Tool("Soft Reset", "Used to send a soft reset signal to the device");
  static final Tool Serial = Tool("Serial Shell",
      "Used to connect to your device's MicroPython CLI interface");
}

class Tool {
  String name;
  String description;
  Tool(this.name, this.description);
}
