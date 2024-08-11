double processNumber(String input) {
  // Remove any spaces from the input
  input = input.replaceAll(' ', '');

  // Normalize the input to handle multiple decimal points
  input = _normalizeNumber(input);

  // Convert the normalized input to a double
  try {
    return double.parse(input);
  } catch (e) {
    throw const FormatException('Invalid number format');
  }
}

String _normalizeNumber(String input) {
  // Split the input by decimal points
  List<String> parts = input.split('.');

  // If there's only one part, there's no decimal point to worry about
  if (parts.length == 1) {
    return parts[0];
  }

  // Combine all parts except the last one into the integer part
  String integerPart = parts.sublist(0, parts.length - 1).join('');

  // Use the last part as the decimal part
  String decimalPart = parts.last;

  // If decimalPart is empty, don't add any decimal part
  if (decimalPart.isEmpty) {
    return integerPart;
  }

  // Combine integer and decimal parts
  return '$integerPart.$decimalPart';
}
//
// void main() {
//   //print('Enter a number with potential multiple decimal points:');
//
//   // Read input from the user
//   String? input = stdin.readLineSync();
//
//   if (input != null && input.isNotEmpty) {
//     try {
//       double result = processNumber(input);
//       //print('The valid double is: $result');
//     } catch (e) {
//       print('Error processing number: $e');
//     }
//   } else {
//     print('No input provided.');
//   }
// }
