using { demo_ns as my } from '../db/schema';
service CatalogService @(path:'/browse') {

  @readonly entity Books as SELECT from my.Books {*,
    author.name as author
  } excluding { createdBy, modifiedBy };

  @requires_: 'authenticated-user'
  action submitOrder (book: Books:ID, amount: Integer);

  @readonly entity ListOfBooks as SELECT from Books
  excluding { descr };
  
  entity BookText as
  select A.ID, coalesce(B.title, A.title,) as title : String(100), 
        coalesce(A.descr,B.descr) as descr : String
  from my.Books A
  left outer join my.Books_texts B
  on A.ID = B.ID
  and B.locale = $user.locale;

  entity BookText2 as
  select ID, coalesce(localized.title, title) as title : String ,
        coalesce(localized.descr, descr) as descr : String,
        currency.code, currency.name, currency.localized.descr as descr2
  from Books;

}