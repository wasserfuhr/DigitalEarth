/*BootStrap*/
create table b (id integer primary key, c text);

/*BaseLog*/
create table l (
 id integer primary key,
 h varchar(20), /* Hash */
 t int, /* TimeStamp */
 u int, /* User */
 foreign key (h) REFERENCES b(id));