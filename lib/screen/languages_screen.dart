import 'package:flutter/material.dart';
import 'package:ithildin/db/eldamo_db.dart';
import 'package:ithildin/model/language.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({Key? key}) : super(key: key);

  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  late List<Language> languages;
  late var allLanguages = <Language>[];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadLanguages();
  }

  @override
  void dispose() {
    EldamoDb.instance.close();
    super.dispose();
  }

  Future loadLanguages() async {
    setState(() => isLoading = true);
    languages = await EldamoDb.instance.loadEldarinLanguages();
    allLanguages.addAll(languages);
    setState(() => isLoading = false);
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      var filteredLanguages = <Language>[];
      for (var item in allLanguages) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          filteredLanguages.add(item);
        }
      }
      setState(() {
        languages.clear();
        languages.addAll(filteredLanguages);
      });
      return;
    } else {
      setState(() {
        languages.clear();
        languages.addAll(allLanguages);
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'choose a language',
            style: TextStyle(fontSize: 24),
          ),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFACE5EE),
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : languages.isEmpty
                      ? const Text(
                          'No languages found',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: languages.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              dense: true,
                              leading: Icon(Icons.list),
                              trailing: Text(
                                "GFG",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 15),
                              ),
                              title: Text(languages[index].name),
                            );
                          },
                        ),
            ),
          ],
        ),
      );
}
