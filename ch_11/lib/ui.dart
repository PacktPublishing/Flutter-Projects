import 'package:flutter/material.dart';
import 'data/bookshelper.dart';

class BooksTable extends StatelessWidget {
  final List<dynamic> books;
  final bool isFavorite;

  BooksTable(this.books, this.isFavorite);
  final BooksHelper helper = BooksHelper();

  @override
  Widget build(BuildContext context) {
    
    return Table(
      columnWidths: {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(1),
      },
      border: TableBorder.all(color: Colors.blueGrey),
      children: 
        books.map((book) {
        return TableRow(
          children: [
            TableCell(child:TableText(book.title)),
            TableCell(child:TableText(book.authors)),
            TableCell(child:TableText(book.publisher)),
            TableCell(
              child: IconButton(
                color: (isFavorite) ? Colors.red : Colors.amber, 
                tooltip: (isFavorite) ? 'Remove from favorites' : 'Add to favorites', 
                icon: Icon(Icons.star), 
                onPressed: () {
                  if (isFavorite) {
                    helper.removeFromFavorites(book, context);
                  }
                  else { 
                    helper.addToFavorites(book);
                  }
              }))
          ]
        );
      }).toList(),
    );
  }
}

class BooksList extends StatelessWidget {
  final List<dynamic> books;
  final bool isFavorite;
  BooksList(this.books, this.isFavorite);
  final BooksHelper helper = BooksHelper();

  @override
  Widget build(BuildContext context) {
    final int booksCount = books.length;
    print(booksCount);
    return Container(
      height: MediaQuery.of(context).size.height /1.4,
      child: ListView.builder(
      itemCount: (booksCount==null) ? 0: booksCount,
      itemBuilder: (BuildContext context, int position) {
        return ListTile(
          title: Text(books[position].title),
          subtitle: Text(books[position].authors),
          trailing: IconButton(
                color: (isFavorite) ? Colors.red : Colors.amber, 
                tooltip: (isFavorite) ? 'Remove from favorites' : 'Add to favorites', 
                icon: Icon(Icons.star), 
                onPressed: () {
                  if (isFavorite) {
                    helper.removeFromFavorites(books[position], context);
                  }
                  else { 
                    helper.addToFavorites(books[position]);
                  }
              }),
        );
      }));
  }
}

class TableText extends StatelessWidget {
    final String text;
    TableText(this.text);

    @override
    Widget build(BuildContext context) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Text(text, 
          style: TextStyle(color: Theme.of(context).primaryColorDark),),
      );
    }
  }

