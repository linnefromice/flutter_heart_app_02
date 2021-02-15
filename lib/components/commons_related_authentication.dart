import 'package:flutter/material.dart';

final List<String> _domainList = [
  "gmail.com",
  "yahoo.co.jp",
  "ezweb.ne.jp",
  "au.com",
  "docomo.ne.jp",
  "i.softbank.jp",
  "softbank.ne.jp",
  "mognet.com"
];
final String defaultDomain = _domainList.first;

ElevatedButton buildButtonRelatedAuthentication({final String label, final IconData iconData, final Function onPressed}) {
  return ElevatedButton.icon(
    icon: Icon(
      iconData,
      size: 48,
      color: Colors.white,
    ),
    label: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    ),
    style: ElevatedButton.styleFrom(
      primary: Colors.transparent,
      onPrimary: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
    ),
    onPressed: onPressed,
  );
}

TextField buildEmailField(TextEditingController localPartController) {
  return TextField(
    controller: localPartController,
    keyboardType: TextInputType.emailAddress,
    obscureText: false,
    style: TextStyle(
        fontSize: 18.0,
        color: Colors.white
    ),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        prefixIcon: Icon(Icons.account_circle, color: Colors.white),
        hintText: "Email",
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(32.0)
        )
    ),
  );
}

Theme buildEmailDomainSelector(ValueNotifier<String> selectedDomain) {
  return Theme(
    data: ThemeData(
        canvasColor: Colors.grey
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedDomain.value,
        onChanged: (value) => selectedDomain.value = value,
        style: TextStyle(color: Colors.white),
        items: _domainList.map((value) => DropdownMenuItem(
          value: value,
          child: Text(value),
        )) .toList(),
      ),
    ),
  );
}

TextField buildPasswordField(TextEditingController passwordController, ValueNotifier<bool> _isObscureText) {
  return TextField(
    controller: passwordController,
    keyboardType: TextInputType.text,
    obscureText: _isObscureText.value,
    style: TextStyle(
        fontSize: 18.0,
        color: Colors.white
    ),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        prefixIcon: Icon(Icons.lock, color: Colors.white),
        hintText: "Password",
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(32.0),
        )
    ),
  );
}

Row buildObscureCheckbox({final String label, final ValueNotifier<bool> isObscureText}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      Theme(
        data: ThemeData(
            primarySwatch: Colors.grey,
            unselectedWidgetColor: Colors.white
        ),
        child: Checkbox(
          value: isObscureText.value,
          onChanged: (value) => isObscureText.value = value,
        ),
      )
    ],
  );
}
