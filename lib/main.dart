import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

import 'UrlLauncher.dart';
import 'my_custom_icons.dart';

void main() => runApp(EvanJuge());

// iOS only: Localized labels language setting is equal to CFBundleDevelopmentRegion value (Info.plist) of the iOS project
// Set iOSLocalizedLabels=false if you always want english labels whatever is the CFBundleDevelopmentRegion value.
const iOSLocalizedLabels = false;

const tel = "07 77 31 12 38";
const email = "contact@evanjuge.fr";
const url = "evanjuge.fr";
const url_linkedin = "fr.linkedin.com/in/evanjuge";
const url_github = "github.com/Ayce45";
const url_dribbble = "dribbble.com/Ayce45";
const url_twitter = "twitter.com/aycefr";
final UrlLauncher _urlLauncher = UrlLauncher();

class EvanJuge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage(), debugShowCheckedModeBanner: false);
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [ContactWidget(), SocialWidget()];

  @override
  void initState() {
    super.initState();
    _askPermissions();
  }

  Future<void> _askPermissions() async {
    await Permission.contacts.request().isGranted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Evan JUGE",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 10,
        actions: <Widget>[
          SaveButton(),
        ],
      ),
      backgroundColor: Colors.white,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (newIndex) => setState(() => _currentIndex = newIndex),
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.contacts),
            title: new Text('Contact'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.public),
            title: new Text('Social'),
          ),
        ],
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.save),
        color: Colors.white,
        tooltip: 'Enregister ma carte de visite',
        onPressed: () async {
          Contact contact = Contact(
            givenName: "Evan",
            familyName: "JUGE",
            company: "Ayce",
            phones: [Item(label: "mobile", value: "0777311238")],
            emails: [Item(label: "pro", value: "contact@evanjuge.fr")],
          );
          ContactsService.addContact(contact);

          final snackBar = SnackBar(
            content: Text('Le contact a été enregistré !'),
          );

          // Find the Scaffold in the widget tree and use
          // it to show a SnackBar.
          Scaffold.of(context).showSnackBar(snackBar);
        });
  }
}

class ContactWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.white,
        child: new Center(
          child: Card(
            child: Column(
              children: [
                Container(
                  child: new Image.asset(
                    'images/moi.png',
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Divider(),
                ListTile(
                    title: Text(tel,
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    leading: Icon(
                      Icons.phone,
                      color: Colors.blue[500],
                    ),
                    onTap: () {
                      _urlLauncher.call(tel);
                    }),
                Divider(),
                ListTile(
                    title: Text(email),
                    leading: Icon(
                      Icons.mail,
                      color: Colors.blue[500],
                    ),
                    onTap: () {
                      _urlLauncher.sendEmail(email);
                    }),
                Divider(),
                ListTile(
                    title: Text(url),
                    leading: Icon(
                      Icons.web,
                      color: Colors.blue[500],
                    ),
                    onTap: () {
                      _urlLauncher.openUrl(url);
                    }),
              ],
            ),
          ),
        ));
  }
}

class SocialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.white,
        child: new Center(
          child: Card(
            child: Column(
              children: [
                ListTile(
                    title: Text(url_linkedin),
                    leading: Icon(
                      MyCustomIcons.linkedin,
                      color: Colors.blue[500],
                    ),
                    onTap: () {
                      _urlLauncher.openUrl(url_linkedin);
                    }),
                Divider(),
                ListTile(
                    title: Text(url_github),
                    leading: Icon(
                      MyCustomIcons.github,
                      color: Colors.blue[500],
                    ),
                    onTap: () {
                      _urlLauncher.openUrl(url_github);
                    }),
                Divider(),
                ListTile(
                    title: Text(url_dribbble),
                    leading: Icon(
                      MyCustomIcons.dribbble,
                      color: Colors.blue[500],
                    ),
                    onTap: () {
                      _urlLauncher.openUrl(url_dribbble);
                    }),
                Divider(),
                ListTile(
                    title: Text(url_twitter),
                    leading: Icon(
                      MyCustomIcons.twitter,
                      color: Colors.blue[500],
                    ),
                    onTap: () {
                      _urlLauncher.openUrl(url_twitter);
                    }),
              ],
            ),
          ),
        ));
  }
}
