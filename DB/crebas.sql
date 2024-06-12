/*==============================================================*/
/* DBMS name:      SAP SQL Anywhere 17                          */
/* Created on:     11-06-2024 22:59:25                          */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_AUTORES_NOMBRA_NOMBRAR_') then
    alter table AUTORES
       delete foreign key FK_AUTORES_NOMBRA_NOMBRAR_
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_BODEGA_MUEVE_MOVIMIEN') then
    alter table BODEGA
       delete foreign key FK_BODEGA_MUEVE_MOVIMIEN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_CLIENTE_ADQUIERE2_COMPRA_P') then
    alter table CLIENTE
       delete foreign key FK_CLIENTE_ADQUIERE2_COMPRA_P
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_EMPLEADO_REGISTRA_MOVIMIEN') then
    alter table EMPLEADOS
       delete foreign key FK_EMPLEADO_REGISTRA_MOVIMIEN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_TEXTOS_ADQUIERE_COMPRA_P') then
    alter table TEXTOS
       delete foreign key FK_TEXTOS_ADQUIERE_COMPRA_P
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_TEXTOS_ALMACENA_BODEGA') then
    alter table TEXTOS
       delete foreign key FK_TEXTOS_ALMACENA_BODEGA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_TEXTOS_CONTIENE_NOMBRAR_') then
    alter table TEXTOS
       delete foreign key FK_TEXTOS_CONTIENE_NOMBRAR_
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_TEXTOS_TIENE_EDITORIA') then
    alter table TEXTOS
       delete foreign key FK_TEXTOS_TIENE_EDITORIA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_USUARIOS_INHERITAN_CLIENTE') then
    alter table USUARIOS
       delete foreign key FK_USUARIOS_INHERITAN_CLIENTE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_USUARIOS_INHERITAN_EMPLEADO') then
    alter table USUARIOS
       delete foreign key FK_USUARIOS_INHERITAN_EMPLEADO
end if;

drop index if exists AUTORES.NOMBRA_FK;

drop index if exists AUTORES.AUTORES_PK;

drop table if exists AUTORES;

drop index if exists BODEGA.MUEVE_FK;

drop index if exists BODEGA.BODEGA_PK;

drop table if exists BODEGA;

drop index if exists CLIENTE.ADQUIERE2_FK;

drop index if exists CLIENTE.CLIENTE_PK;

drop table if exists CLIENTE;

drop index if exists COMPRA_PRODUCTOS.COMPRA_PRODUCTOS_PK;

drop table if exists COMPRA_PRODUCTOS;

drop index if exists EDITORIAL.EDITORIAL_PK;

drop table if exists EDITORIAL;

drop index if exists EMPLEADOS.REGISTRA_FK;

drop index if exists EMPLEADOS.EMPLEADOS_PK;

drop table if exists EMPLEADOS;

drop index if exists MOVIMIENTO_CONTENIDO.MOVIMIENTO_CONTENIDO_PK;

drop table if exists MOVIMIENTO_CONTENIDO;

drop index if exists NOMBRAR_TEXTO.NOMBRAR_TEXTO_PK;

drop table if exists NOMBRAR_TEXTO;

drop index if exists TEXTOS.CONTIENE_FK;

drop index if exists TEXTOS.ALMACENA_FK;

drop index if exists TEXTOS.TIENE_FK;

drop index if exists TEXTOS.ADQUIERE_FK;

drop index if exists TEXTOS.TEXTOS_PK;

drop table if exists TEXTOS;

drop index if exists USUARIOS.INHERITANCE_2_FK;

drop index if exists USUARIOS.INHERITANCE_1_FK;

drop index if exists USUARIOS.USUARIOS_PK;

drop table if exists USUARIOS;

/*==============================================================*/
/* Table: AUTORES                                               */
/*==============================================================*/
create or replace table AUTORES 
(
   TEXTOID              char(10)                       not null,
   AUT_RUT              varchar(10)                    not null,
   AUT_NOMBRE           char(30)                       not null,
   AUT_NACIONALIDA      char(20)                       null,
   AUT_APELLIDO         char(20)                       null,
   constraint PK_AUTORES primary key clustered (TEXTOID, AUT_RUT)
);

/*==============================================================*/
/* Index: AUTORES_PK                                            */
/*==============================================================*/
create unique clustered index AUTORES_PK on AUTORES (
TEXTOID ASC,
AUT_RUT ASC
);

/*==============================================================*/
/* Index: NOMBRA_FK                                             */
/*==============================================================*/
create index NOMBRA_FK on AUTORES (
TEXTOID ASC
);

/*==============================================================*/
/* Table: BODEGA                                                */
/*==============================================================*/
create or replace table BODEGA 
(
   MOVIMIENTOID         char(10)                       not null,
   BOD_CODIGO           integer                        not null,
   BOD_TIPODECONTENIDO  varchar(30)                    null,
   BOD_TAMANO           varchar(30)                    null,
   constraint PK_BODEGA primary key clustered (MOVIMIENTOID, BOD_CODIGO)
);

/*==============================================================*/
/* Index: BODEGA_PK                                             */
/*==============================================================*/
create unique clustered index BODEGA_PK on BODEGA (
MOVIMIENTOID ASC,
BOD_CODIGO ASC
);

/*==============================================================*/
/* Index: MUEVE_FK                                              */
/*==============================================================*/
create index MUEVE_FK on BODEGA (
MOVIMIENTOID ASC
);

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create or replace table CLIENTE 
(
   COM_CODIGO           integer                        not null,
   CLI_RUT              varchar(20)                    not null,
   CLI_NOMBRE           char(40)                       null,
   CLI_APELLIDO         char(30)                       null,
   CLI_DIRECCION        char(30)                       null,
   CLI_TELEFONO         integer                        null,
   constraint PK_CLIENTE primary key clustered (COM_CODIGO, CLI_RUT)
);

/*==============================================================*/
/* Index: CLIENTE_PK                                            */
/*==============================================================*/
create unique clustered index CLIENTE_PK on CLIENTE (
COM_CODIGO ASC,
CLI_RUT ASC
);

/*==============================================================*/
/* Index: ADQUIERE2_FK                                          */
/*==============================================================*/
create index ADQUIERE2_FK on CLIENTE (
COM_CODIGO ASC
);

/*==============================================================*/
/* Table: COMPRA_PRODUCTOS                                      */
/*==============================================================*/
create or replace table COMPRA_PRODUCTOS 
(
   COM_CODIGO           integer                        not null,
   COM_COSTO            integer                        null,
   COM_CANTIDAD         integer                        null,
   constraint PK_COMPRA_PRODUCTOS primary key clustered (COM_CODIGO)
);

/*==============================================================*/
/* Index: COMPRA_PRODUCTOS_PK                                   */
/*==============================================================*/
create unique clustered index COMPRA_PRODUCTOS_PK on COMPRA_PRODUCTOS (
COM_CODIGO ASC
);

/*==============================================================*/
/* Table: EDITORIAL                                             */
/*==============================================================*/
create or replace table EDITORIAL 
(
   EDI_NOMBRE           varchar(4)                     not null,
   EDI_DIRECCION        varchar(40)                    null,
   EDI_PAIS             varchar(30)                    null,
   constraint PK_EDITORIAL primary key clustered (EDI_NOMBRE)
);

/*==============================================================*/
/* Index: EDITORIAL_PK                                          */
/*==============================================================*/
create unique clustered index EDITORIAL_PK on EDITORIAL (
EDI_NOMBRE ASC
);

/*==============================================================*/
/* Table: EMPLEADOS                                             */
/*==============================================================*/
create or replace table EMPLEADOS 
(
   MOVIMIENTOID         char(10)                       not null,
   EMP_RUT              varchar(10)                    not null,
   EMP_NOMBRE           char(40)                       not null,
   EMP_APELLIDO         char(40)                       not null,
   EMP_PUESTO           char(30)                       not null,
   EMP_FECHCONTRATACION timestamp                      null,
   EMP_DIRECCION        char(30)                       null,
   constraint PK_EMPLEADOS primary key clustered (MOVIMIENTOID, EMP_RUT)
);

/*==============================================================*/
/* Index: EMPLEADOS_PK                                          */
/*==============================================================*/
create unique clustered index EMPLEADOS_PK on EMPLEADOS (
MOVIMIENTOID ASC,
EMP_RUT ASC
);

/*==============================================================*/
/* Index: REGISTRA_FK                                           */
/*==============================================================*/
create index REGISTRA_FK on EMPLEADOS (
MOVIMIENTOID ASC
);

/*==============================================================*/
/* Table: MOVIMIENTO_CONTENIDO                                  */
/*==============================================================*/
create or replace table MOVIMIENTO_CONTENIDO 
(
   MOVIMIENTOID         char(10)                       not null,
   CONTENIDODESCRIPCION char(10)                       null,
   FECHAMOVIMIENTO      char(10)                       null,
   CANTIDADMOVIDA       char(10)                       null,
   constraint PK_MOVIMIENTO_CONTENIDO primary key clustered (MOVIMIENTOID)
);

/*==============================================================*/
/* Index: MOVIMIENTO_CONTENIDO_PK                               */
/*==============================================================*/
create unique clustered index MOVIMIENTO_CONTENIDO_PK on MOVIMIENTO_CONTENIDO (
MOVIMIENTOID ASC
);

/*==============================================================*/
/* Table: NOMBRAR_TEXTO                                         */
/*==============================================================*/
create or replace table NOMBRAR_TEXTO 
(
   TEXTOID              char(10)                       not null,
   TEXTODESCRIPCION     char(10)                       null,
   FECHACREACIONTEXTO   char(10)                       null,
   AUTORTEXTO           char(10)                       null,
   constraint PK_NOMBRAR_TEXTO primary key clustered (TEXTOID)
);

/*==============================================================*/
/* Index: NOMBRAR_TEXTO_PK                                      */
/*==============================================================*/
create unique clustered index NOMBRAR_TEXTO_PK on NOMBRAR_TEXTO (
TEXTOID ASC
);

/*==============================================================*/
/* Table: TEXTOS                                                */
/*==============================================================*/
create or replace table TEXTOS 
(
   COM_CODIGO           integer                        not null,
   TEXTOID              char(10)                       not null,
   TEX_CODIGO           integer                        not null,
   EDI_NOMBRE           varchar(4)                     null,
   MOVIMIENTOID         char(10)                       not null,
   BOD_CODIGO           integer                        not null,
   TEX_TITULO           varchar(20)                    null,
   TEX_TIPO             varchar(20)                    null,
   TEX_TAMANO           varchar(20)                    null,
   constraint PK_TEXTOS primary key clustered (COM_CODIGO, TEXTOID, TEX_CODIGO)
);

/*==============================================================*/
/* Index: TEXTOS_PK                                             */
/*==============================================================*/
create unique clustered index TEXTOS_PK on TEXTOS (
COM_CODIGO ASC,
TEXTOID ASC,
TEX_CODIGO ASC
);

/*==============================================================*/
/* Index: ADQUIERE_FK                                           */
/*==============================================================*/
create index ADQUIERE_FK on TEXTOS (
COM_CODIGO ASC
);

/*==============================================================*/
/* Index: TIENE_FK                                              */
/*==============================================================*/
create index TIENE_FK on TEXTOS (
EDI_NOMBRE ASC
);

/*==============================================================*/
/* Index: ALMACENA_FK                                           */
/*==============================================================*/
create index ALMACENA_FK on TEXTOS (
MOVIMIENTOID ASC,
BOD_CODIGO ASC
);

/*==============================================================*/
/* Index: CONTIENE_FK                                           */
/*==============================================================*/
create index CONTIENE_FK on TEXTOS (
TEXTOID ASC
);

/*==============================================================*/
/* Table: USUARIOS                                              */
/*==============================================================*/
create or replace table USUARIOS 
(
   COM_CODIGO           integer                        not null,
   CLI_RUT              varchar(20)                    not null,
   MOVIMIENTOID         char(10)                       not null,
   EMP_RUT              varchar(10)                    not null,
   USU__CODIGO          integer                        not null,
   EMP_NOMBRE           char(40)                       not null,
   EMP_APELLIDO         char(40)                       not null,
   EMP_PUESTO           char(30)                       not null,
   EMP_FECHCONTRATACION timestamp                      null,
   EMP_DIRECCION        char(30)                       null,
   CLI_NOMBRE           char(40)                       null,
   CLI_APELLIDO         char(30)                       null,
   CLI_DIRECCION        char(30)                       null,
   CLI_TELEFONO         integer                        null,
   USU_CORREO           varchar(30)                    null,
   USU_CLAVE            varchar(30)                    null,
   constraint PK_USUARIOS primary key clustered (COM_CODIGO, MOVIMIENTOID, CLI_RUT, EMP_RUT, USU__CODIGO)
);

/*==============================================================*/
/* Index: USUARIOS_PK                                           */
/*==============================================================*/
create unique clustered index USUARIOS_PK on USUARIOS (
COM_CODIGO ASC,
MOVIMIENTOID ASC,
CLI_RUT ASC,
EMP_RUT ASC,
USU__CODIGO ASC
);

/*==============================================================*/
/* Index: INHERITANCE_1_FK                                      */
/*==============================================================*/
create index INHERITANCE_1_FK on USUARIOS (
COM_CODIGO ASC,
CLI_RUT ASC
);

/*==============================================================*/
/* Index: INHERITANCE_2_FK                                      */
/*==============================================================*/
create index INHERITANCE_2_FK on USUARIOS (
MOVIMIENTOID ASC,
EMP_RUT ASC
);

alter table AUTORES
   add constraint FK_AUTORES_NOMBRA_NOMBRAR_ foreign key (TEXTOID)
      references NOMBRAR_TEXTO (TEXTOID)
      on update restrict
      on delete restrict;

alter table BODEGA
   add constraint FK_BODEGA_MUEVE_MOVIMIEN foreign key (MOVIMIENTOID)
      references MOVIMIENTO_CONTENIDO (MOVIMIENTOID)
      on update restrict
      on delete restrict;

alter table CLIENTE
   add constraint FK_CLIENTE_ADQUIERE2_COMPRA_P foreign key (COM_CODIGO)
      references COMPRA_PRODUCTOS (COM_CODIGO)
      on update restrict
      on delete restrict;

alter table EMPLEADOS
   add constraint FK_EMPLEADO_REGISTRA_MOVIMIEN foreign key (MOVIMIENTOID)
      references MOVIMIENTO_CONTENIDO (MOVIMIENTOID)
      on update restrict
      on delete restrict;

alter table TEXTOS
   add constraint FK_TEXTOS_ADQUIERE_COMPRA_P foreign key (COM_CODIGO)
      references COMPRA_PRODUCTOS (COM_CODIGO)
      on update restrict
      on delete restrict;

alter table TEXTOS
   add constraint FK_TEXTOS_ALMACENA_BODEGA foreign key (MOVIMIENTOID, BOD_CODIGO)
      references BODEGA (MOVIMIENTOID, BOD_CODIGO)
      on update restrict
      on delete restrict;

alter table TEXTOS
   add constraint FK_TEXTOS_CONTIENE_NOMBRAR_ foreign key (TEXTOID)
      references NOMBRAR_TEXTO (TEXTOID)
      on update restrict
      on delete restrict;

alter table TEXTOS
   add constraint FK_TEXTOS_TIENE_EDITORIA foreign key (EDI_NOMBRE)
      references EDITORIAL (EDI_NOMBRE)
      on update restrict
      on delete restrict;

alter table USUARIOS
   add constraint FK_USUARIOS_INHERITAN_CLIENTE foreign key (COM_CODIGO, CLI_RUT)
      references CLIENTE (COM_CODIGO, CLI_RUT)
      on update restrict
      on delete restrict;

alter table USUARIOS
   add constraint FK_USUARIOS_INHERITAN_EMPLEADO foreign key (MOVIMIENTOID, EMP_RUT)
      references EMPLEADOS (MOVIMIENTOID, EMP_RUT)
      on update restrict
      on delete restrict;

