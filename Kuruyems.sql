create table tmiktar_birimi
(
id tinyint identity (1,1) primary key,
birim_turu varchar(10),
constraint tek_tmiktar_birimi unique (birim_turu)
)
create table turun_grubu
(
id tinyint identity (1,1) primary key,
grup_adi varchar(30),
constraint tek_turun_grubu unique (grup_adi)
)
create table tKDV
(
id tinyint identity (1,1) primary key,
kdv smallint,
constraint tek_tKDV unique (kdv)
)
create table tIskonto
(
id tinyint identity (1,1) primary key,
iskonto smallint,
constraint tek_tIskonto unique (iskonto)
)
create table todeme
(
id tinyint identity (1,1) primary key,
yontem varchar(15),
constraint tek_todeme unique (yontem)
)
create table tmahalle
(
id smallint identity (1,1) primary key,
mahalle varchar(30),
constraint tek_tmahalle unique (mahalle)
)
create table tbayi
(
id tinyint identity (1,1) primary key,
bayi varchar(20),
constraint tek_tbayi unique (bayi),
mahalle_tmahalle smallint,
foreign key (mahalle_tmahalle)
	references tmahalle(id),
)
create table tmusteri
(
id int identity (1,1) primary key,
adi varchar(50),
soyadi varchar(50),
telno varchar(10),
email varchar(50),
constraint tek_ttelno unique (telno),
constraint tek_temail unique (email),
iskonto_tIskonto tinyint,
foreign key (iskonto_tIskonto)
	references tIskonto(id),
)
create table tUrun
(
id int identity (1,1) primary key,
adi varchar(50),
constraint tek_tUrun unique (adi),
kdv_tKDV tinyint,
foreign key (kdv_tKDV)
	references tKDV(id),
grup_turun_grubu tinyint,
foreign key (grup_turun_grubu)
	references turun_grubu(id),
birim_tmiktar_birimi tinyint,
foreign key (birim_tmiktar_birimi)
	references tmiktar_birimi(id),
)
create table tsatis
(
id int identity (1,1) primary key,
zaman smalldatetime default getdate(),
fiyat float,
miktar float,
musteri_tmusteri int,
foreign key (musteri_tmusteri)
	references tmusteri(id),
urun_turun int,
foreign key (urun_turun)
	references tUrun(id),
odeme_todeme tinyint,
foreign key (odeme_todeme)
	references todeme(id),
bayi_tbayi tinyint,
foreign key (bayi_tbayi)
	references tbayi(id),
iskonto_tIskonto tinyint,
foreign key (iskonto_tIskonto)
	references tIskonto(id),
)