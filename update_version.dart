import 'dart:io';

void main() {
  File pubspec = File('pubspec.yaml');
  List<String> lines = pubspec.readAsLinesSync();

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].startsWith('version:')) {
      // Extract version number
      String versionLine = lines[i];
      String version = versionLine.split(' ')[1].split('+')[0];

      // Split into major.minor.patch
      List<String> parts = version.split('.');
      int patch = int.parse(parts[2]) + 1; // Increment patch

      // Create new version string
      String newVersion = "${parts[0]}.${parts[1]}.$patch+${patch}";
      lines[i] = "version: $newVersion"; // Update the line

      print("Updated version: $newVersion");
      break;
    }
  }

  // Write back to pubspec.yaml
  pubspec.writeAsStringSync(lines.join('\n'));
}
  
  // In this snippet, we read the  pubspec.yaml  file and extract the current version number. We then increment the patch version and write it back to the file. 
  // The  pubspec.yaml  file is a configuration file for Dart packages. It contains metadata about the package, including the name, version, dependencies, and other information. 
  // The version number in the  pubspec.yaml  file follows the  semantic versioning scheme, which consists of three parts: major, minor, and patch. The patch version is incremented when making backward-compatible bug fixes. 
  // In this snippet, we extract the version number from the  pubspec.yaml  file, increment the patch version, and write it back to the file. 
  // To run the script, save it to a file (e.g.,  update_version.dart ) and execute it using the Dart VM: 
  // dart update_version.dart
  
  // The script will read the  pubspec.yaml  file, update the version number, and write it back to the file. 
  // Learn more about Dart at  https://dart.dev/
  // Learn more about the  pubspec.yaml  file at  https://dart.dev/tools/pub/pubspec
  // Learn more about semantic versioning at  https://semver.org/
  // Dart is a client-optimized language for fast apps on any platform. 
  // The  pubspec.yaml  file is a configuration file for Dart packages. It contains metadata about the package, including the name, version, dependencies, and other information. 
  // The version number in the  pubspec.yaml  file follows the  semantic versioning scheme, which consists of three parts: major, minor, and patch. The patch version is incremented when making backward-compatible bug fixes. 
  // In this snippet, we extract the version number from the  pubspec.yaml  file, increment the patch version, and write it back to the file. 
  // To run the script, save it to a file (e.g.,  update_version.dart ) and execute it using the Dart VM: 
  // dart update_version.dart
  
  // The script will read the  pubspec.yaml  file, update the version number, and write it back to the file. 
  // Learn more about Dart at  https://dart.dev/
  // Learn more about the  pubspec.yaml  file at  https://dart.dev/tools/pub/pubspec
  // Learn more about semantic versioning at  https://semver.org/
  // Dart is a client-optimized language for fast apps on any platform.