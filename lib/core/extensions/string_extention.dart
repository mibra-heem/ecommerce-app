
extension StringExtention on String {
  String get obscureEmail {
    // split the email into username and domain
    final index = indexOf('@');
    var username = substring(0, index);
    final domain = substring(index + 1);

    // obscure the email show first and last digit of the username

    username = '${username[0]}*****${username[username.length - 1]}';

    return '$username@$domain';
  }

  String get firstName {
    final index = indexOf(' ');
    final name = substring(0, index + 2);

    return '$name.';
  }

  String get lastName {
    final firstLetter = this[0];
    final index = indexOf(' ');
    final name = substring(index);

    return '$firstLetter.$name';
  }

  String get firstLetterCapital {
    final firstLetter = this[0].toUpperCase();
    final withoutFirstLetter = substring(1);

    return '$firstLetter$withoutFirstLetter';
  }

}
