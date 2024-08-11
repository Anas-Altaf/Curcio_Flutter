import 'dart:collection';

import 'package:curcio/endpoints/xe_com.dart';
import 'package:curcio/models/currency_input_evaluator.dart';
import 'package:flutter/cupertino.dart';

class CurrencyData extends ChangeNotifier {
  String _currencyInput = '';
  VerticalDirection _currencyBarPlacement = VerticalDirection.down;
  String _lowerCurrentValue = 'EUR';
  String _upperCurrentValue = 'USD';
  //Api Status
  static int _apiStatus = 200;

  void addInput(String input) {
    _currencyInput = _currencyInput + input;
    notifyListeners();
  }

  void clearInput() {
    _currencyInput = '';
    notifyListeners();
  }

  void removeLastChar() {
    if (_currencyInput.isNotEmpty) {
      _currencyInput = _currencyInput.substring(0, _currencyInput.length - 1);
      notifyListeners();
    }
  }

  double get getInput {
    if (_currencyInput.isNotEmpty) {
      return processNumber(_currencyInput);
    }
    return 0.0;
  }

//API Status
  int get getApiStatus {
    return _apiStatus;
  }

  set setApiStatus(int statusCode) {
    _apiStatus = statusCode;
    print('🌟Status Code :$_apiStatus');
    notifyListeners();
  }

  //Fetch Results
  Future<double> getConversionResult(
      {required toCurrency, required String fromCurrency}) async {
    FetchExchangeData fetchExchangeData = FetchExchangeData();
    double results = await fetchExchangeData.fetchExchangeRate(
            fromCurrency: fromCurrency, toCurrency: toCurrency) ??
        0.0;
    return results;
  }

  VerticalDirection get getCurrencyBarPlacement => _currencyBarPlacement;

  set setCurrencyBarPlacement(VerticalDirection direction) {
    _currencyBarPlacement = direction;
    notifyListeners();
  }

//Drop-Down Button CurrentValues
  String get getLowerCurrentValue => _lowerCurrentValue;

  set setLowerCurrentValue(String value) {
    _lowerCurrentValue = value;
    notifyListeners();
  }

  String get getUpperCurrentValue => _upperCurrentValue;

  set setUpperCurrentValue(String value) {
    _upperCurrentValue = value;
    notifyListeners();
  }

  void notifyListenersManually() {
    notifyListeners();
  }

  UnmodifiableMapView<String, String> get currencyList {
    return UnmodifiableMapView(_currencyList);
  }

  final Map<String, String> _currencyList = {
    "ADA": "Cardano",
    "AED": "Emirati Dirham",
    "AFN": "Afghan Afghani",
    "ALL": "Albanian Lek",
    "AMD": "Armenian Dram",
    "ANG": "Dutch Guilder",
    "AOA": "Angolan Kwanza",
    "ARS": "Argentine Peso",
    "AUD": "Australian Dollar",
    "AWG": "Aruban or Dutch Guilder",
    "AZN": "Azerbaijan Manat",
    "BAM": "Bosnian Convertible Mark",
    "BBD": "Barbadian or Bajan Dollar",
    "BCH": "Bitcoin Cash",
    "BDT": "Bangladeshi Taka",
    "BGN": "Bulgarian Lev",
    "BHD": "Bahraini Dinar",
    "BIF": "Burundian Franc",
    "BMD": "Bermudian Dollar",
    "BND": "Bruneian Dollar",
    "BOB": "Bolivian Bolíviano",
    "BRL": "Brazilian Real",
    "BSD": "Bahamian Dollar",
    "BTC": "Bitcoin",
    "BTN": "Bhutanese Ngultrum",
    "BWP": "Botswana Pula",
    "BYN": "Belarusian Ruble",
    "BYR": "Belarusian Ruble",
    "BZD": "Belizean Dollar",
    "CAD": "Canadian Dollar",
    "CDF": "Congolese Franc",
    "CHF": "Swiss Franc",
    "CLP": "Chilean Peso",
    "CNY": "Chinese Yuan Renminbi",
    "COP": "Colombian Peso",
    "CRC": "Costa Rican Colon",
    "CUC": "Cuban Convertible Peso",
    "CUP": "Cuban Peso",
    "CVE": "Cape Verdean Escudo",
    "CZK": "Czech Koruna",
    "DJF": "Djiboutian Franc",
    "DKK": "Danish Krone",
    "DOGE": "Dogecoin",
    "DOP": "Dominican Peso",
    "DOT": "Polkadot",
    "DZD": "Algerian Dinar",
    "EEK": "Estonian Kroon",
    "EGP": "Egyptian Pound",
    "ERN": "Eritrean Nakfa",
    "ETB": "Ethiopian Birr",
    "ETH": "Ethereum",
    "EUR": "Euro",
    "FJD": "Fijian Dollar",
    "FKP": "Falkland Island Pound",
    "GBP": "British Pound",
    "GEL": "Georgian Lari",
    "GGP": "Guernsey Pound",
    "GHS": "Ghanaian Cedi",
    "GIP": "Gibraltar Pound",
    "GMD": "Gambian Dalasi",
    "GNF": "Guinean Franc",
    "GTQ": "Guatemalan Quetzal",
    "GYD": "Guyanese Dollar",
    "HKD": "Hong Kong Dollar",
    "HNL": "Honduran Lempira",
    "HRK": "Croatian Kuna",
    "HTG": "Haitian Gourde",
    "HUF": "Hungarian Forint",
    "IDR": "Indonesian Rupiah",
    "ILS": "Israeli Shekel",
    "IMP": "Isle of Man Pound",
    "INR": "Indian Rupee",
    "IQD": "Iraqi Dinar",
    "IRR": "Iranian Rial",
    "ISK": "Icelandic Krona",
    "JEP": "Jersey Pound",
    "JMD": "Jamaican Dollar",
    "JOD": "Jordanian Dinar",
    "JPY": "Japanese Yen",
    "KES": "Kenyan Shilling",
    "KGS": "Kyrgyzstani Som",
    "KHR": "Cambodian Riel",
    "KMF": "Comorian Franc",
    "KPW": "North Korean Won",
    "KRW": "South Korean Won",
    "KWD": "Kuwaiti Dinar",
    "KYD": "Caymanian Dollar",
    "KZT": "Kazakhstani Tenge",
    "LAK": "Lao Kip",
    "LBP": "Lebanese Pound",
    "LINK": "Chainlink",
    "LKR": "Sri Lankan Rupee",
    "LRD": "Liberian Dollar",
    "LSL": "Basotho Loti",
    "LTC": "Litecoin",
    "LTL": "Lithuanian Litas",
    "LUNA": "Terra",
    "LVL": "Latvian Lat",
    "LYD": "Libyan Dinar",
    "MAD": "Moroccan Dirham",
    "MDL": "Moldovan Leu",
    "MGA": "Malagasy Ariary",
    "MKD": "Macedonian Denar",
    "MMK": "Burmese Kyat",
    "MNT": "Mongolian Tughrik",
    "MOP": "Macau Pataca",
    "MRU": "Mauritanian Ouguiya",
    "MUR": "Mauritian Rupee",
    "MVR": "Maldivian Rufiyaa",
    "MWK": "Malawian Kwacha",
    "MXN": "Mexican Peso",
    "MYR": "Malaysian Ringgit",
    "MZN": "Mozambican Metical",
    "NAD": "Namibian Dollar",
    "NGN": "Nigerian Naira",
    "NIO": "Nicaraguan Cordoba",
    "NOK": "Norwegian Krone",
    "NPR": "Nepalese Rupee",
    "NZD": "New Zealand Dollar",
    "OMR": "Omani Rial",
    "PAB": "Panamanian Balboa",
    "PEN": "Peruvian Sol",
    "PGK": "Papua New Guinean Kina",
    "PHP": "Philippine Peso",
    "PKR": "Pakistani Rupee",
    "PLN": "Polish Zloty",
    "PYG": "Paraguayan Guarani",
    "QAR": "Qatari Riyal",
    "RON": "Romanian Leu",
    "RSD": "Serbian Dinar",
    "RUB": "Russian Ruble",
    "RWF": "Rwandan Franc",
    "SAR": "Saudi Arabian Riyal",
    "SBD": "Solomon Islander Dollar",
    "SCR": "Seychellois Rupee",
    "SDG": "Sudanese Pound",
    "SEK": "Swedish Krona",
    "SGD": "Singapore Dollar",
    "SHP": "Saint Helenian Pound",
    "SLE": "Sierra Leonean Leone",
    "SLL": "Sierra Leonean Leone",
    "SOS": "Somali Shilling",
    "SPL": "Seborgan Luigino",
    "SRD": "Surinamese Dollar",
    "STN": "Sao Tomean Dobra",
    "SVC": "Salvadoran Colon",
    "SYP": "Syrian Pound",
    "SZL": "Swazi Lilangeni",
    "THB": "Thai Baht",
    "TJS": "Tajikistani Somoni",
    "TMT": "Turkmenistani Manat",
    "TND": "Tunisian Dinar",
    "TOP": "Tongan Pa'anga",
    "TRY": "Turkish Lira",
    "TTD": "Trinidadian Dollar",
    "TVD": "Tuvaluan Dollar",
    "TWD": "Taiwan New Dollar",
    "TZS": "Tanzanian Shilling",
    "UAH": "Ukrainian Hryvnia",
    "UGX": "Ugandan Shilling",
    "UNI": "Uniswap",
    "USD": "US Dollar",
    "UYU": "Uruguayan Peso",
    "UZS": "Uzbekistani Som",
    "VEF": "Venezuelan Bolívar",
    "VES": "Venezuelan Bolívar",
    "VND": "Vietnamese Dong",
    "VUV": "Ni-Vanuatu Vatu",
    "WST": "Samoan Tala",
    "XAF": "Central African CFA Franc BEAC",
    "XAG": "Silver Ounce",
    "XAU": "Gold Ounce",
    "XCD": "East Caribbean Dollar",
    "XDR": "IMF Special Drawing Rights",
    "XLM": "Stellar Lumen",
    "XOF": "CFA Franc",
    "XPD": "Palladium Ounce",
    "XPF": "CFP Franc",
    "XPT": "Platinum Ounce",
    "XRP": "Ripple",
    "YER": "Yemeni Rial",
    "ZAR": "South African Rand",
    "ZMK": "Zambian Kwacha",
    "ZMW": "Zambian Kwacha",
    "ZWD": "Zimbabwean Dollar",
    "ZWL": "Zimbabwean Dollar"
  };

// UnmodifiableListView<String> get currencyList {
//   return UnmodifiableListView(_currencyList);
// }
// final List<String> _currencyList = [
//   "ada",
//   "aed",
//   "afn",
//   "all",
//   "amd",
//   "ang",
//   "aoa",
//   "ars",
//   "aud",
//   "awg",
//   "azn",
//   "bam",
//   "bbd",
//   "bch",
//   "bdt",
//   "bgn",
//   "bhd",
//   "bif",
//   "bmd",
//   "bnd",
//   "bob",
//   "brl",
//   "bsd",
//   "btc",
//   "btn",
//   "bwp",
//   "byn",
//   "byr",
//   "bzd",
//   "cad",
//   "cdf",
//   "chf",
//   "clp",
//   "cny",
//   "cop",
//   "crc",
//   "cuc",
//   "cup",
//   "cve",
//   "czk",
//   "djf",
//   "dkk",
//   "doge",
//   "dop",
//   "dot",
//   "dzd",
//   "eek",
//   "egp",
//   "ern",
//   "etb",
//   "eth",
//   "eur",
//   "fjd",
//   "fkp",
//   "gbp",
//   "gel",
//   "ggp",
//   "ghs",
//   "gip",
//   "gmd",
//   "gnf",
//   "gtq",
//   "gyd",
//   "hkd",
//   "hnl",
//   "hrk",
//   "htg",
//   "huf",
//   "idr",
//   "ils",
//   "imp",
//   "inr",
//   "iqd",
//   "irr",
//   "isk",
//   "jep",
//   "jmd",
//   "jod",
//   "jpy",
//   "kes",
//   "kgs",
//   "khr",
//   "kmf",
//   "kpw",
//   "krw",
//   "kwd",
//   "kyd",
//   "kzt",
//   "lak",
//   "lbp",
//   "link",
//   "lkr",
//   "lrd",
//   "lsl",
//   "ltc",
//   "ltl",
//   "luna",
//   "lvl",
//   "lyd",
//   "mad",
//   "mdl",
//   "mga",
//   "mkd",
//   "mmk",
//   "mnt",
//   "mop",
//   "mru",
//   "mur",
//   "mvr",
//   "mwk",
//   "mxn",
//   "myr",
//   "mzn",
//   "nad",
//   "ngn",
//   "nio",
//   "nok",
//   "npr",
//   "nzd",
//   "omr",
//   "pab",
//   "pen",
//   "pgk",
//   "php",
//   "pkr",
//   "pln",
//   "pyg",
//   "qar",
//   "ron",
//   "rsd",
//   "rub",
//   "rwf",
//   "sar",
//   "sbd",
//   "scr",
//   "sdg",
//   "sek",
//   "sgd",
//   "shp",
//   "sle",
//   "sll",
//   "sos",
//   "spl",
//   "srd",
//   "stn",
//   "svc",
//   "syp",
//   "szl",
//   "thb",
//   "tjs",
//   "tmt",
//   "tnd",
//   "top",
//   "try",
//   "ttd",
//   "tvd",
//   "twd",
//   "tzs",
//   "uah",
//   "ugx",
//   "uni",
//   "usd",
//   "uyu",
//   "uzs",
//   "vef",
//   "ves",
//   "vnd",
//   "vuv",
//   "wst",
//   "xaf",
//   "xag",
//   "xau",
//   "xcd",
//   "xdr",
//   "xlm",
//   "xof",
//   "xpd",
//   "xpf",
//   "xpt",
//   "xrp",
//   "yer",
//   "zar",
//   "zmk",
//   "zmw",
//   "zwd",
//   "zwl"
// ];
}
