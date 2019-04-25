/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2019/4/25 21:44:18                           */
/*==============================================================*/


drop table if exists Bar;

drop table if exists Beer;

drop table if exists Drinker;

drop table if exists Group;

drop table if exists Location;

drop table if exists Manufacturer;

/*==============================================================*/
/* Table: Bar                                                   */
/*==============================================================*/
create table Bar
(
   chainName            char(16) not null,
   chainID              int not null,
   beer_brand_name      char(32) not null,
   beer_produce_factory_name char(32) not null,
   name                 char(32) not null,
   type                 char(16) not null,
   form                 char(16) not null,
   capacity             int not null,
   cardID               int not null,
   Dri_cardID           int not null,
   countyName           char(16) not null,
   streetName           char(16) not null,
   apartmentNumber      int not null,
   price                int not null,
   primary key (chainName, chainID)
);

/*==============================================================*/
/* Table: Beer                                                  */
/*==============================================================*/
create table Beer
(
   beer_brand_name      char(32) not null,
   beer_produce_factory_name char(32) not null,
   name                 char(32) not null,
   type                 char(16) not null,
   form                 char(16) not null,
   capacity             int not null,
   cardID               int not null,
   Dri_cardID           int not null,
   primary key (beer_brand_name, beer_produce_factory_name, name, type, form, capacity)
);

/*==============================================================*/
/* Table: Drinker                                               */
/*==============================================================*/
create table Drinker
(
   cardID               int not null,
   group_id             int not null,
   beer_brand_name      char(32) not null,
   beer_produce_factory_name char(32) not null,
   Bee_name             char(32) not null,
   type                 char(16) not null,
   form                 char(16) not null,
   capacity             int not null,
   chainName            char(16) not null,
   chainID              int not null,
   name                 char(32) not null,
   age                  int not null,
   sex                  tinyint not null,
   primary key (cardID)
);

/*==============================================================*/
/* Table: Group                                                 */
/*==============================================================*/
create table Group
(
   group_id             int not null,
   primary key (group_id)
);

/*==============================================================*/
/* Table: Location                                              */
/*==============================================================*/
create table Location
(
   zip                  int not null,
   street_number        int not null,
   apt_number           int not null,
   chainName            char(16) not null,
   chainID              int not null,
   cardID               int not null,
   state                char(32) not null,
   city                 char(32) not null,
   street_name          char(32) not null,
   apt_name             char(32),
   primary key (zip, street_number, apt_number)
);

/*==============================================================*/
/* Table: Manufacturer                                          */
/*==============================================================*/
create table Manufacturer
(
   beer_brand_name      char(32) not null,
   beer_produce_factory_name char(32) not null,
   primary key (beer_brand_name, beer_produce_factory_name)
);

alter table Bar add constraint FK_Favorita_bar foreign key (Dri_cardID)
      references Drinker (cardID) on delete restrict on update restrict;

alter table Bar add constraint FK_Often_bar foreign key (cardID)
      references Drinker (cardID) on delete restrict on update restrict;

alter table Bar add constraint FK_sales foreign key (beer_brand_name, beer_produce_factory_name, name, type, form, capacity)
      references Beer (beer_brand_name, beer_produce_factory_name, name, type, form, capacity) on delete restrict on update restrict;

alter table Beer add constraint "FK_Favorite Beer" foreign key (cardID)
      references Drinker (cardID) on delete restrict on update restrict;

alter table Beer add constraint FK_Often_beer foreign key (Dri_cardID)
      references Drinker (cardID) on delete restrict on update restrict;

alter table Beer add constraint "FK_Produce By" foreign key (beer_brand_name, beer_produce_factory_name)
      references Manufacturer (beer_brand_name, beer_produce_factory_name) on delete restrict on update restrict;

alter table Drinker add constraint FK_Favorita_bar foreign key (chainName, chainID)
      references Bar (chainName, chainID) on delete restrict on update restrict;

alter table Drinker add constraint "FK_Favorite Beer" foreign key (beer_brand_name, beer_produce_factory_name, Bee_name, type, form, capacity)
      references Beer (beer_brand_name, beer_produce_factory_name, name, type, form, capacity) on delete restrict on update restrict;

alter table Drinker add constraint FK_Gather foreign key (group_id)
      references Group (group_id) on delete restrict on update restrict;

alter table Location add constraint FK_Address foreign key (chainName, chainID)
      references Bar (chainName, chainID) on delete restrict on update restrict;

alter table Location add constraint "FK_Permanent Residence" foreign key (cardID)
      references Drinker (cardID) on delete restrict on update restrict;

