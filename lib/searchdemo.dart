// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:untitled2/provider.dart';
// import 'package:provider/provider.dart';
//
//
// class seaching extends StatelessWidget {
//   const seaching({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//   return  ChangeNotifierProvider<EligiblityScreenProvider>(
//         create: (context) => EligiblityScreenProvider(),
//         child: Builder(builder: (context) {
//           return FutureBuilder(
//               future:    ,
//               builder: (BuildContext ctx,
//                   AsyncSnapshot<List> snapshot) =>
//               snapshot.hasData
//                   ?
//                Container(
//               child: TypeAheadField(
//                 textFieldConfiguration: TextFieldConfiguration(
//                     autofocus: true,
//                     style: DefaultTextStyle
//                         .of(context)
//                         .style
//                         .copyWith(
//                         fontStyle: FontStyle.italic
//                     ),
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder()
//                     )
//                 ),
//                 suggestionsCallback: (pattern) async {
//                   return await BackendService.getSuggestions(pattern);
//                 },
//                 itemBuilder: (context, suggestion) {
//                   return ListTile(
//                     leading: Icon(Icons.shopping_cart),
//                     title: Text(suggestion['name']),
//                     subtitle: Text('\$${suggestion['price']}'),
//                   );
//                 }, onSuggestionSelected: (Object? suggestion) {  },
//                 // onSuggestionSelected: (suggestion) {
//                 //   Navigator.of(context).push(MaterialPageRoute(
//                 //       builder: (context) => ProductPage(product: suggestion)
//                 //   ));
//                 // },
//               ),
//             ),
//           );
//         })  );
//         }
// }
