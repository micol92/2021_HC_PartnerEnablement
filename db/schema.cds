using { Currency, managed, sap } from '@sap/cds/common';
namespace demo_ns;

entity Books : managed {
  key ID : Integer;
  title  : localized String(111);
  descr  : localized String(1111);
  author_id : Integer;
  genre_id : Integer;
  
  author : Association to Authors on author.ID = author_id;
  genre  : Association to Genres on genre.ID = genre_id;
  
  stock  : Integer;
  price  : Decimal(9,2);
  currency : Currency;
}

entity Authors : managed {
  key ID : Integer;
  name   : String(111);
  dateOfBirth  : Date;
  dateOfDeath  : Date;
  placeOfBirth : String;
  placeOfDeath : String;  
  books  : Association to many Books on books.author_id = ID;
}

/** Hierarchically organized Code List for Genres */
entity Genres : sap.common.CodeList {
  key ID   : Integer;
  parent_id : Integer;
  children : Composition of many Genres on children.parent_id = ID;
}