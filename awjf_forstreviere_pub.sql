CREATE SCHEMA IF NOT EXISTS awjf_forstreviere_pub;
CREATE SEQUENCE awjf_forstreviere_pub.t_ili2db_seq;;
-- GeometryCHLV95_V1.SurfaceStructure
CREATE TABLE awjf_forstreviere_pub.surfacestructure (
  T_Id bigint PRIMARY KEY DEFAULT nextval('awjf_forstreviere_pub.t_ili2db_seq')
  ,T_Seq bigint NULL
  ,surface geometry(POLYGON,2056) NULL
  ,multisurface_surfaces bigint NULL
)
;
CREATE INDEX surfacestructure_surface_idx ON awjf_forstreviere_pub.surfacestructure USING GIST ( surface );
CREATE INDEX surfacestructure_multisurface_surfaces_idx ON awjf_forstreviere_pub.surfacestructure ( multisurface_surfaces );
-- GeometryCHLV95_V1.MultiSurface
CREATE TABLE awjf_forstreviere_pub.multisurface (
  T_Id bigint PRIMARY KEY DEFAULT nextval('awjf_forstreviere_pub.t_ili2db_seq')
  ,T_Seq bigint NULL
)
;
-- SO_Forstreviere_Publikation_20170428.Forstreviere.Forstkreis
CREATE TABLE awjf_forstreviere_pub.forstreviere_forstkreis (
  T_Id bigint PRIMARY KEY DEFAULT nextval('awjf_forstreviere_pub.t_ili2db_seq')
  ,geometrie geometry(MULTIPOLYGON,2056) NOT NULL
  ,forstkreis varchar(50) NOT NULL
)
;
CREATE INDEX forstreviere_forstkreis_geometrie_idx ON awjf_forstreviere_pub.forstreviere_forstkreis USING GIST ( geometrie );
COMMENT ON COLUMN awjf_forstreviere_pub.forstreviere_forstkreis.geometrie IS 'Geometrie des Forstkreises';
COMMENT ON COLUMN awjf_forstreviere_pub.forstreviere_forstkreis.forstkreis IS 'Name des Forstkreises';
-- SO_Forstreviere_Publikation_20170428.Forstreviere.Forstrevier
CREATE TABLE awjf_forstreviere_pub.forstreviere_forstrevier (
  T_Id bigint PRIMARY KEY DEFAULT nextval('awjf_forstreviere_pub.t_ili2db_seq')
  ,geometrie geometry(MULTIPOLYGON,2056) NOT NULL
  ,forstrevier varchar(50) NOT NULL
  ,forstkreis varchar(50) NOT NULL
)
;
CREATE INDEX forstreviere_forstrevier_geometrie_idx ON awjf_forstreviere_pub.forstreviere_forstrevier USING GIST ( geometrie );
COMMENT ON COLUMN awjf_forstreviere_pub.forstreviere_forstrevier.geometrie IS 'Geometrie des Forstreviers';
COMMENT ON COLUMN awjf_forstreviere_pub.forstreviere_forstrevier.forstrevier IS 'Name des Forstreviers';
COMMENT ON COLUMN awjf_forstreviere_pub.forstreviere_forstrevier.forstkreis IS 'Name des Forstkreises';
CREATE TABLE awjf_forstreviere_pub.T_ILI2DB_BASKET (
  T_Id bigint PRIMARY KEY
  ,dataset bigint NULL
  ,topic varchar(200) NOT NULL
  ,T_Ili_Tid varchar(200) NULL
  ,attachmentKey varchar(200) NOT NULL
  ,domains varchar(1024) NULL
)
;
CREATE INDEX T_ILI2DB_BASKET_dataset_idx ON awjf_forstreviere_pub.t_ili2db_basket ( dataset );
CREATE TABLE awjf_forstreviere_pub.T_ILI2DB_DATASET (
  T_Id bigint PRIMARY KEY
  ,datasetName varchar(200) NULL
)
;
CREATE TABLE awjf_forstreviere_pub.T_ILI2DB_INHERITANCE (
  thisClass varchar(1024) PRIMARY KEY
  ,baseClass varchar(1024) NULL
)
;
CREATE TABLE awjf_forstreviere_pub.T_ILI2DB_SETTINGS (
  tag varchar(60) PRIMARY KEY
  ,setting varchar(1024) NULL
)
;
CREATE TABLE awjf_forstreviere_pub.T_ILI2DB_TRAFO (
  iliname varchar(1024) NOT NULL
  ,tag varchar(1024) NOT NULL
  ,setting varchar(1024) NOT NULL
)
;
CREATE TABLE awjf_forstreviere_pub.T_ILI2DB_MODEL (
  filename varchar(250) NOT NULL
  ,iliversion varchar(3) NOT NULL
  ,modelName text NOT NULL
  ,content text NOT NULL
  ,importDate timestamp NOT NULL
  ,PRIMARY KEY (modelName,iliversion)
)
;
CREATE TABLE awjf_forstreviere_pub.T_ILI2DB_CLASSNAME (
  IliName varchar(1024) PRIMARY KEY
  ,SqlName varchar(1024) NOT NULL
)
;
CREATE TABLE awjf_forstreviere_pub.T_ILI2DB_ATTRNAME (
  IliName varchar(1024) NOT NULL
  ,SqlName varchar(1024) NOT NULL
  ,ColOwner varchar(1024) NOT NULL
  ,Target varchar(1024) NULL
  ,PRIMARY KEY (SqlName,ColOwner)
)
;
CREATE TABLE awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (
  tablename varchar(255) NOT NULL
  ,subtype varchar(255) NULL
  ,columnname varchar(255) NOT NULL
  ,tag varchar(1024) NOT NULL
  ,setting varchar(1024) NOT NULL
)
;
CREATE TABLE awjf_forstreviere_pub.T_ILI2DB_TABLE_PROP (
  tablename varchar(255) NOT NULL
  ,tag varchar(1024) NOT NULL
  ,setting varchar(1024) NOT NULL
)
;
CREATE TABLE awjf_forstreviere_pub.T_ILI2DB_META_ATTRS (
  ilielement varchar(255) NOT NULL
  ,attr_name varchar(1024) NOT NULL
  ,attr_value varchar(1024) NOT NULL
)
;
ALTER TABLE awjf_forstreviere_pub.surfacestructure ADD CONSTRAINT surfacestructure_multisurface_surfaces_fkey FOREIGN KEY ( multisurface_surfaces ) REFERENCES awjf_forstreviere_pub.multisurface DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE awjf_forstreviere_pub.T_ILI2DB_BASKET ADD CONSTRAINT T_ILI2DB_BASKET_dataset_fkey FOREIGN KEY ( dataset ) REFERENCES awjf_forstreviere_pub.T_ILI2DB_DATASET DEFERRABLE INITIALLY DEFERRED;
CREATE UNIQUE INDEX T_ILI2DB_DATASET_datasetName_key ON awjf_forstreviere_pub.T_ILI2DB_DATASET (datasetName)
;
CREATE UNIQUE INDEX T_ILI2DB_MODEL_modelName_iliversion_key ON awjf_forstreviere_pub.T_ILI2DB_MODEL (modelName,iliversion)
;
CREATE UNIQUE INDEX T_ILI2DB_ATTRNAME_SqlName_ColOwner_key ON awjf_forstreviere_pub.T_ILI2DB_ATTRNAME (SqlName,ColOwner)
;
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('SO_Forstreviere_Publikation_20170428.Forstreviere.Forstkreis','forstreviere_forstkreis');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('GeometryCHLV95_V1.MultiSurface','multisurface');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('SO_Forstreviere_Publikation_20170428.Forstreviere.Forstrevier','forstreviere_forstrevier');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('GeometryCHLV95_V1.SurfaceStructure','surfacestructure');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('GeometryCHLV95_V1.MultiSurface.Surfaces','multisurface_surfaces','surfacestructure','multisurface');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('SO_Forstreviere_Publikation_20170428.Forstreviere.Forstrevier.Forstrevier','forstrevier','forstreviere_forstrevier',NULL);
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('SO_Forstreviere_Publikation_20170428.Forstreviere.Forstrevier.Forstkreis','forstkreis','forstreviere_forstrevier',NULL);
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('GeometryCHLV95_V1.SurfaceStructure.Surface','surface','surfacestructure',NULL);
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('SO_Forstreviere_Publikation_20170428.Forstreviere.Forstkreis.Geometrie','geometrie','forstreviere_forstkreis',NULL);
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('SO_Forstreviere_Publikation_20170428.Forstreviere.Forstrevier.Geometrie','geometrie','forstreviere_forstrevier',NULL);
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('SO_Forstreviere_Publikation_20170428.Forstreviere.Forstkreis.Forstkreis','forstkreis','forstreviere_forstkreis',NULL);
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('SO_Forstreviere_Publikation_20170428.Forstreviere.Forstkreis','ch.ehi.ili2db.inheritance','newClass');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('SO_Forstreviere_Publikation_20170428.Forstreviere.Forstrevier.Geometrie','ch.ehi.ili2db.multiSurfaceTrafo','coalesce');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('SO_Forstreviere_Publikation_20170428.Forstreviere.Forstkreis.Geometrie','ch.ehi.ili2db.multiSurfaceTrafo','coalesce');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('GeometryCHLV95_V1.MultiSurface','ch.ehi.ili2db.inheritance','newClass');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('SO_Forstreviere_Publikation_20170428.Forstreviere.Forstrevier','ch.ehi.ili2db.inheritance','newClass');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('GeometryCHLV95_V1.SurfaceStructure','ch.ehi.ili2db.inheritance','newClass');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('SO_Forstreviere_Publikation_20170428.Forstreviere.Forstkreis',NULL);
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('SO_Forstreviere_Publikation_20170428.Forstreviere.Forstrevier',NULL);
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('GeometryCHLV95_V1.MultiSurface',NULL);
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('GeometryCHLV95_V1.SurfaceStructure',NULL);
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('surfacestructure',NULL,'surface','ch.ehi.ili2db.c2Min','1045000.000');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('forstreviere_forstkreis',NULL,'geometrie','ch.ehi.ili2db.geomType','MULTIPOLYGON');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('surfacestructure',NULL,'surface','ch.ehi.ili2db.c1Min','2460000.000');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('forstreviere_forstrevier',NULL,'geometrie','ch.ehi.ili2db.c1Min','2460000.000');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('forstreviere_forstkreis',NULL,'geometrie','ch.ehi.ili2db.srid','2056');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('forstreviere_forstrevier',NULL,'geometrie','ch.ehi.ili2db.c2Min','1045000.000');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('surfacestructure',NULL,'surface','ch.ehi.ili2db.srid','2056');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('surfacestructure',NULL,'multisurface_surfaces','ch.ehi.ili2db.foreignKey','multisurface');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('forstreviere_forstrevier',NULL,'geometrie','ch.ehi.ili2db.geomType','MULTIPOLYGON');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('forstreviere_forstkreis',NULL,'geometrie','ch.ehi.ili2db.c1Min','2460000.000');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('forstreviere_forstrevier',NULL,'geometrie','ch.ehi.ili2db.srid','2056');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('surfacestructure',NULL,'surface','ch.ehi.ili2db.coordDimension','2');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('surfacestructure',NULL,'surface','ch.ehi.ili2db.geomType','POLYGON');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('forstreviere_forstrevier',NULL,'geometrie','ch.ehi.ili2db.c2Max','1310000.000');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('surfacestructure',NULL,'surface','ch.ehi.ili2db.c2Max','1310000.000');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('forstreviere_forstkreis',NULL,'geometrie','ch.ehi.ili2db.c1Max','2870000.000');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('forstreviere_forstkreis',NULL,'geometrie','ch.ehi.ili2db.c2Min','1045000.000');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('forstreviere_forstrevier',NULL,'geometrie','ch.ehi.ili2db.coordDimension','2');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('forstreviere_forstrevier',NULL,'geometrie','ch.ehi.ili2db.c1Max','2870000.000');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('forstreviere_forstkreis',NULL,'geometrie','ch.ehi.ili2db.c2Max','1310000.000');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('forstreviere_forstkreis',NULL,'geometrie','ch.ehi.ili2db.coordDimension','2');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('surfacestructure',NULL,'surface','ch.ehi.ili2db.c1Max','2870000.000');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_TABLE_PROP (tablename,tag,setting) VALUES ('forstreviere_forstkreis','ch.ehi.ili2db.tableKind','CLASS');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_TABLE_PROP (tablename,tag,setting) VALUES ('forstreviere_forstrevier','ch.ehi.ili2db.tableKind','CLASS');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_TABLE_PROP (tablename,tag,setting) VALUES ('surfacestructure','ch.ehi.ili2db.tableKind','STRUCTURE');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_TABLE_PROP (tablename,tag,setting) VALUES ('multisurface','ch.ehi.ili2db.tableKind','STRUCTURE');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_MODEL (filename,iliversion,modelName,content,importDate) VALUES ('Units-20120220.ili','2.3','Units','!! File Units.ili Release 2012-02-20

INTERLIS 2.3;

!! 2012-02-20 definition of "Bar [bar]" corrected
!!@precursorVersion = 2005-06-06

CONTRACTED TYPE MODEL Units (en) AT "http://www.interlis.ch/models"
  VERSION "2012-02-20" =

  UNIT
    !! abstract Units
    Area (ABSTRACT) = (INTERLIS.LENGTH*INTERLIS.LENGTH);
    Volume (ABSTRACT) = (INTERLIS.LENGTH*INTERLIS.LENGTH*INTERLIS.LENGTH);
    Velocity (ABSTRACT) = (INTERLIS.LENGTH/INTERLIS.TIME);
    Acceleration (ABSTRACT) = (Velocity/INTERLIS.TIME);
    Force (ABSTRACT) = (INTERLIS.MASS*INTERLIS.LENGTH/INTERLIS.TIME/INTERLIS.TIME);
    Pressure (ABSTRACT) = (Force/Area);
    Energy (ABSTRACT) = (Force*INTERLIS.LENGTH);
    Power (ABSTRACT) = (Energy/INTERLIS.TIME);
    Electric_Potential (ABSTRACT) = (Power/INTERLIS.ELECTRIC_CURRENT);
    Frequency (ABSTRACT) = (INTERLIS.DIMENSIONLESS/INTERLIS.TIME);

    Millimeter [mm] = 0.001 [INTERLIS.m];
    Centimeter [cm] = 0.01 [INTERLIS.m];
    Decimeter [dm] = 0.1 [INTERLIS.m];
    Kilometer [km] = 1000 [INTERLIS.m];

    Square_Meter [m2] EXTENDS Area = (INTERLIS.m*INTERLIS.m);
    Cubic_Meter [m3] EXTENDS Volume = (INTERLIS.m*INTERLIS.m*INTERLIS.m);

    Minute [min] = 60 [INTERLIS.s];
    Hour [h] = 60 [min];
    Day [d] = 24 [h];

    Kilometer_per_Hour [kmh] EXTENDS Velocity = (km/h);
    Meter_per_Second [ms] = 3.6 [kmh];
    Newton [N] EXTENDS Force = (INTERLIS.kg*INTERLIS.m/INTERLIS.s/INTERLIS.s);
    Pascal [Pa] EXTENDS Pressure = (N/m2);
    Joule [J] EXTENDS Energy = (N*INTERLIS.m);
    Watt [W] EXTENDS Power = (J/INTERLIS.s);
    Volt [V] EXTENDS Electric_Potential = (W/INTERLIS.A);

    Inch [in] = 2.54 [cm];
    Foot [ft] = 0.3048 [INTERLIS.m];
    Mile [mi] = 1.609344 [km];

    Are [a] = 100 [m2];
    Hectare [ha] = 100 [a];
    Square_Kilometer [km2] = 100 [ha];
    Acre [acre] = 4046.873 [m2];

    Liter [L] = 1 / 1000 [m3];
    US_Gallon [USgal] = 3.785412 [L];

    Angle_Degree = 180 / PI [INTERLIS.rad];
    Angle_Minute = 1 / 60 [Angle_Degree];
    Angle_Second = 1 / 60 [Angle_Minute];

    Gon = 200 / PI [INTERLIS.rad];

    Gram [g] = 1 / 1000 [INTERLIS.kg];
    Ton [t] = 1000 [INTERLIS.kg];
    Pound [lb] = 0.4535924 [INTERLIS.kg];

    Calorie [cal] = 4.1868 [J];
    Kilowatt_Hour [kWh] = 0.36E7 [J];

    Horsepower = 746 [W];

    Techn_Atmosphere [at] = 98066.5 [Pa];
    Atmosphere [atm] = 101325 [Pa];
    Bar [bar] = 100000 [Pa];
    Millimeter_Mercury [mmHg] = 133.3224 [Pa];
    Torr = 133.3224 [Pa]; !! Torr = [mmHg]

    Decibel [dB] = FUNCTION // 10**(dB/20) * 0.00002 // [Pa];

    Degree_Celsius [oC] = FUNCTION // oC+273.15 // [INTERLIS.K];
    Degree_Fahrenheit [oF] = FUNCTION // (oF+459.67)/1.8 // [INTERLIS.K];

    CountedObjects EXTENDS INTERLIS.DIMENSIONLESS;

    Hertz [Hz] EXTENDS Frequency = (CountedObjects/INTERLIS.s);
    KiloHertz [KHz] = 1000 [Hz];
    MegaHertz [MHz] = 1000 [KHz];

    Percent = 0.01 [CountedObjects];
    Permille = 0.001 [CountedObjects];

    !! ISO 4217 Currency Abbreviation
    USDollar [USD] EXTENDS INTERLIS.MONEY;
    Euro [EUR] EXTENDS INTERLIS.MONEY;
    SwissFrancs [CHF] EXTENDS INTERLIS.MONEY;

END Units.

','2019-10-10 15:50:26.169');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_MODEL (filename,iliversion,modelName,content,importDate) VALUES ('SO_Forstreviere_Publikation_20170428.ili','2.3','SO_Forstreviere_Publikation_20170428{ GeometryCHLV95_V1}','INTERLIS 2.3;
!!============================================================================== 
!!@ File = "SO_Forstreviere_Publikation_20170428.ili"; 
!!@ Title = "Forstreviere und Forstkreise"; 
!!@ shortDescription = "Forstreviere und Forstkreise des Kanton Solothurn"; 
!!@ Issuer = "http://www.agi.so.ch"; 
!!@ technicalContact = "mailto:agi@so.ch"; 
!!@ furtherInformation = ""; 
!!@ kGeoiV_ID = ""; 
!!  Publikationsmodellsmodell;
!!  Compiler-Version = "4.6.1-20170109"; 
!!------------------------------------------------------------------------------ 
!! Version    | wer | Änderung 
!!------------------------------------------------------------------------------ 
!! 2017-04-28 | Noëmi Sturm  | Erstfassung 
!!=============================================================================

MODEL SO_Forstreviere_Publikation_20170428 (de)
AT "http://www.geo.so.ch/models/AWJF"
VERSION "2017-04-28"  =
  IMPORTS GeometryCHLV95_V1;

  TOPIC Forstreviere =

    CLASS Forstkreis =
      /** Geometrie des Forstkreises
       */
      Geometrie : MANDATORY GeometryCHLV95_V1.MultiSurface;
      /** Name des Forstkreises
       */
      Forstkreis : MANDATORY TEXT*50;
    END Forstkreis;

    CLASS Forstrevier =
      /** Geometrie des Forstreviers
       */
      Geometrie : MANDATORY GeometryCHLV95_V1.MultiSurface;
      /** Name des Forstreviers
       */
      Forstrevier : MANDATORY TEXT*50;
      /** Name des Forstkreises
       */
      Forstkreis : MANDATORY TEXT*50;
    END Forstrevier;

  END Forstreviere;

END SO_Forstreviere_Publikation_20170428.
','2019-10-10 15:50:26.169');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_MODEL (filename,iliversion,modelName,content,importDate) VALUES ('CoordSys-20151124.ili','2.3','CoordSys','!! File CoordSys.ili Release 2015-11-24

INTERLIS 2.3;

!! 2015-11-24 Cardinalities adapted (line 122, 123, 124, 132, 133, 134, 142, 143,
!!                                   148, 149, 163, 164, 168, 169, 206 and 207)
!!@precursorVersion = 2005-06-16

REFSYSTEM MODEL CoordSys (en) AT "http://www.interlis.ch/models"
  VERSION "2015-11-24" =

  UNIT
    Angle_Degree = 180 / PI [INTERLIS.rad];
    Angle_Minute = 1 / 60 [Angle_Degree];
    Angle_Second = 1 / 60 [Angle_Minute];

  STRUCTURE Angle_DMS_S =
    Degrees: -180 .. 180 CIRCULAR [Angle_Degree];
    CONTINUOUS SUBDIVISION Minutes: 0 .. 59 CIRCULAR [Angle_Minute];
    CONTINUOUS SUBDIVISION Seconds: 0.000 .. 59.999 CIRCULAR [Angle_Second];
  END Angle_DMS_S;

  DOMAIN
    Angle_DMS = FORMAT BASED ON Angle_DMS_S (Degrees ":" Minutes ":" Seconds);
    Angle_DMS_90 EXTENDS Angle_DMS = "-90:00:00.000" .. "90:00:00.000";


  TOPIC CoordsysTopic =

    !! Special space aspects to be referenced
    !! **************************************

    CLASS Ellipsoid EXTENDS INTERLIS.REFSYSTEM =
      EllipsoidAlias: TEXT*70;
      SemiMajorAxis: MANDATORY 6360000.0000 .. 6390000.0000 [INTERLIS.m];
      InverseFlattening: MANDATORY 0.00000000 .. 350.00000000;
      !! The inverse flattening 0 characterizes the 2-dim sphere
      Remarks: TEXT*70;
    END Ellipsoid;

    CLASS GravityModel EXTENDS INTERLIS.REFSYSTEM =
      GravityModAlias: TEXT*70;
      Definition: TEXT*70;
    END GravityModel;

    CLASS GeoidModel EXTENDS INTERLIS.REFSYSTEM =
      GeoidModAlias: TEXT*70;
      Definition: TEXT*70;
    END GeoidModel;


    !! Coordinate systems for geodetic purposes
    !! ****************************************

    STRUCTURE LengthAXIS EXTENDS INTERLIS.AXIS =
      ShortName: TEXT*12;
      Description: TEXT*255;
    PARAMETER
      Unit (EXTENDED): NUMERIC [INTERLIS.LENGTH];
    END LengthAXIS;

    STRUCTURE AngleAXIS EXTENDS INTERLIS.AXIS =
      ShortName: TEXT*12;
      Description: TEXT*255;
    PARAMETER
      Unit (EXTENDED): NUMERIC [INTERLIS.ANGLE];
    END AngleAXIS;

    CLASS GeoCartesian1D EXTENDS INTERLIS.COORDSYSTEM =
      Axis (EXTENDED): LIST {1} OF LengthAXIS;
    END GeoCartesian1D;

    CLASS GeoHeight EXTENDS GeoCartesian1D =
      System: MANDATORY (
        normal,
        orthometric,
        ellipsoidal,
        other);
      ReferenceHeight: MANDATORY -10000.000 .. +10000.000 [INTERLIS.m];
      ReferenceHeightDescr: TEXT*70;
    END GeoHeight;

    ASSOCIATION HeightEllips =
      GeoHeightRef -- {*} GeoHeight;
      EllipsoidRef -- {1} Ellipsoid;
    END HeightEllips;

    ASSOCIATION HeightGravit =
      GeoHeightRef -- {*} GeoHeight;
      GravityRef -- {1} GravityModel;
    END HeightGravit;

    ASSOCIATION HeightGeoid =
      GeoHeightRef -- {*} GeoHeight;
      GeoidRef -- {1} GeoidModel;
    END HeightGeoid;

    CLASS GeoCartesian2D EXTENDS INTERLIS.COORDSYSTEM =
      Definition: TEXT*70;
      Axis (EXTENDED): LIST {2} OF LengthAXIS;
    END GeoCartesian2D;

    CLASS GeoCartesian3D EXTENDS INTERLIS.COORDSYSTEM =
      Definition: TEXT*70;
      Axis (EXTENDED): LIST {3} OF LengthAXIS;
    END GeoCartesian3D;

    CLASS GeoEllipsoidal EXTENDS INTERLIS.COORDSYSTEM =
      Definition: TEXT*70;
      Axis (EXTENDED): LIST {2} OF AngleAXIS;
    END GeoEllipsoidal;

    ASSOCIATION EllCSEllips =
      GeoEllipsoidalRef -- {*} GeoEllipsoidal;
      EllipsoidRef -- {1} Ellipsoid;
    END EllCSEllips;


    !! Mappings between coordinate systems
    !! ***********************************

    ASSOCIATION ToGeoEllipsoidal =
      From -- {0..*} GeoCartesian3D;
      To -- {0..*} GeoEllipsoidal;
      ToHeight -- {0..*} GeoHeight;
    MANDATORY CONSTRAINT
      ToHeight -> System == #ellipsoidal;
    MANDATORY CONSTRAINT
      To -> EllipsoidRef -> Name == ToHeight -> EllipsoidRef -> Name;
    END ToGeoEllipsoidal;

    ASSOCIATION ToGeoCartesian3D =
      From2 -- {0..*} GeoEllipsoidal;
      FromHeight-- {0..*} GeoHeight;
      To3 -- {0..*} GeoCartesian3D;
    MANDATORY CONSTRAINT
      FromHeight -> System == #ellipsoidal;
    MANDATORY CONSTRAINT
      From2 -> EllipsoidRef -> Name == FromHeight -> EllipsoidRef -> Name;
    END ToGeoCartesian3D;

    ASSOCIATION BidirectGeoCartesian2D =
      From -- {0..*} GeoCartesian2D;
      To -- {0..*} GeoCartesian2D;
    END BidirectGeoCartesian2D;

    ASSOCIATION BidirectGeoCartesian3D =
      From -- {0..*} GeoCartesian3D;
      To2 -- {0..*} GeoCartesian3D;
      Precision: MANDATORY (
        exact,
        measure_based);
      ShiftAxis1: MANDATORY -10000.000 .. 10000.000 [INTERLIS.m];
      ShiftAxis2: MANDATORY -10000.000 .. 10000.000 [INTERLIS.m];
      ShiftAxis3: MANDATORY -10000.000 .. 10000.000 [INTERLIS.m];
      RotationAxis1: Angle_DMS_90;
      RotationAxis2: Angle_DMS_90;
      RotationAxis3: Angle_DMS_90;
      NewScale: 0.000001 .. 1000000.000000;
    END BidirectGeoCartesian3D;

    ASSOCIATION BidirectGeoEllipsoidal =
      From4 -- {0..*} GeoEllipsoidal;
      To4 -- {0..*} GeoEllipsoidal;
    END BidirectGeoEllipsoidal;

    ASSOCIATION MapProjection (ABSTRACT) =
      From5 -- {0..*} GeoEllipsoidal;
      To5 -- {0..*} GeoCartesian2D;
      FromCo1_FundPt: MANDATORY Angle_DMS_90;
      FromCo2_FundPt: MANDATORY Angle_DMS_90;
      ToCoord1_FundPt: MANDATORY -10000000 .. +10000000 [INTERLIS.m];
      ToCoord2_FundPt: MANDATORY -10000000 .. +10000000 [INTERLIS.m];
    END MapProjection;

    ASSOCIATION TransverseMercator EXTENDS MapProjection =
    END TransverseMercator;

    ASSOCIATION SwissProjection EXTENDS MapProjection =
      IntermFundP1: MANDATORY Angle_DMS_90;
      IntermFundP2: MANDATORY Angle_DMS_90;
    END SwissProjection;

    ASSOCIATION Mercator EXTENDS MapProjection =
    END Mercator;

    ASSOCIATION ObliqueMercator EXTENDS MapProjection =
    END ObliqueMercator;

    ASSOCIATION Lambert EXTENDS MapProjection =
    END Lambert;

    ASSOCIATION Polyconic EXTENDS MapProjection =
    END Polyconic;

    ASSOCIATION Albus EXTENDS MapProjection =
    END Albus;

    ASSOCIATION Azimutal EXTENDS MapProjection =
    END Azimutal;

    ASSOCIATION Stereographic EXTENDS MapProjection =
    END Stereographic;

    ASSOCIATION HeightConversion =
      FromHeight -- {0..*} GeoHeight;
      ToHeight -- {0..*} GeoHeight;
      Definition: TEXT*70;
    END HeightConversion;

  END CoordsysTopic;

END CoordSys.

','2019-10-10 15:50:26.169');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_MODEL (filename,iliversion,modelName,content,importDate) VALUES ('CHBase_Part1_GEOMETRY_20110830.ili','2.3','GeometryCHLV03_V1{ CoordSys Units INTERLIS} GeometryCHLV95_V1{ CoordSys Units INTERLIS}','/* ########################################################################
   CHBASE - BASE MODULES OF THE SWISS FEDERATION FOR MINIMAL GEODATA MODELS
   ======
   BASISMODULE DES BUNDES           MODULES DE BASE DE LA CONFEDERATION
   FÜR MINIMALE GEODATENMODELLE     POUR LES MODELES DE GEODONNEES MINIMAUX
   
   PROVIDER: GKG/KOGIS - GCS/COSIG             CONTACT: models@geo.admin.ch
   PUBLISHED: 2011-0830
   ########################################################################
*/

INTERLIS 2.3;

/* ########################################################################
   ########################################################################
   PART I -- GEOMETRY
   - Package GeometryCHLV03
   - Package GeometryCHLV95
*/

!! ########################################################################

!! Version    | Who   | Modification
!!------------------------------------------------------------------------------
!! 2015-02-20 | KOGIS | WITHOUT OVERLAPS added (line 57, 58, 65 and 66)
!! 2015-11-12 | KOGIS | WITHOUT OVERLAPS corrected (line 57 and 58)
!! 2017-11-27 | KOGIS | Meta-Attributes @furtherInformation adapted and @CRS added (line 31, 44 and 50)
!! 2017-12-04 | KOGIS | Meta-Attribute @CRS corrected

!!@technicalContact=models@geo.admin.ch
!!@furtherInformation=https://www.geo.admin.ch/de/geoinformation-schweiz/geobasisdaten/geodata-models.html
TYPE MODEL GeometryCHLV03_V1 (en)
  AT "http://www.geo.admin.ch" VERSION "2017-12-04" =

  IMPORTS UNQUALIFIED INTERLIS;
  IMPORTS Units;
  IMPORTS CoordSys;

  REFSYSTEM BASKET BCoordSys ~ CoordSys.CoordsysTopic
    OBJECTS OF GeoCartesian2D: CHLV03
    OBJECTS OF GeoHeight: SwissOrthometricAlt;

  DOMAIN
    !!@CRS=EPSG:21781
    Coord2 = COORD
      460000.000 .. 870000.000 [m] {CHLV03[1]},
       45000.000 .. 310000.000 [m] {CHLV03[2]},
      ROTATION 2 -> 1;

    !!@CRS=EPSG:21781
    Coord3 = COORD
      460000.000 .. 870000.000 [m] {CHLV03[1]},
       45000.000 .. 310000.000 [m] {CHLV03[2]},
        -200.000 ..   5000.000 [m] {SwissOrthometricAlt[1]},
      ROTATION 2 -> 1;

    Surface = SURFACE WITH (STRAIGHTS, ARCS) VERTEX Coord2 WITHOUT OVERLAPS > 0.001;
    Area = AREA WITH (STRAIGHTS, ARCS) VERTEX Coord2 WITHOUT OVERLAPS > 0.001;
    Line = POLYLINE WITH (STRAIGHTS, ARCS) VERTEX Coord2;
    DirectedLine EXTENDS Line = DIRECTED POLYLINE;
    LineWithAltitude = POLYLINE WITH (STRAIGHTS, ARCS) VERTEX Coord3;
    DirectedLineWithAltitude = DIRECTED POLYLINE WITH (STRAIGHTS, ARCS) VERTEX Coord3;
    
    /* minimal overlaps only (2mm) */
    SurfaceWithOverlaps2mm = SURFACE WITH (STRAIGHTS, ARCS) VERTEX Coord2 WITHOUT OVERLAPS > 0.002;
    AreaWithOverlaps2mm = AREA WITH (STRAIGHTS, ARCS) VERTEX Coord2 WITHOUT OVERLAPS > 0.002;

    Orientation = 0.00000 .. 359.99999 CIRCULAR [Units.Angle_Degree] <Coord2>;

    Accuracy = (cm, cm50, m, m10, m50, vague);
    Method = (measured, sketched, calculated);

    STRUCTURE LineStructure = 
      Line: Line;
    END LineStructure;

    STRUCTURE DirectedLineStructure =
      Line: DirectedLine;
    END DirectedLineStructure;

    STRUCTURE MultiLine =
      Lines: BAG {1..*} OF LineStructure;
    END MultiLine;

    STRUCTURE MultiDirectedLine =
      Lines: BAG {1..*} OF DirectedLineStructure;
    END MultiDirectedLine;

    STRUCTURE SurfaceStructure =
      Surface: Surface;
    END SurfaceStructure;

    STRUCTURE MultiSurface =
      Surfaces: BAG {1..*} OF SurfaceStructure;
    END MultiSurface;

END GeometryCHLV03_V1.

!! ########################################################################

!! Version    | Who   | Modification
!!------------------------------------------------------------------------------
!! 2015-02-20 | KOGIS | WITHOUT OVERLAPS added (line 135, 136, 143 and 144)
!! 2015-11-12 | KOGIS | WITHOUT OVERLAPS corrected (line 135 and 136)
!! 2017-11-27 | KOGIS | Meta-Attributes @furtherInformation adapted and @CRS added (line 109, 122 and 128)
!! 2017-12-04 | KOGIS | Meta-Attribute @CRS corrected

!!@technicalContact=models@geo.admin.ch
!!@furtherInformation=https://www.geo.admin.ch/de/geoinformation-schweiz/geobasisdaten/geodata-models.html
TYPE MODEL GeometryCHLV95_V1 (en)
  AT "http://www.geo.admin.ch" VERSION "2017-12-04" =

  IMPORTS UNQUALIFIED INTERLIS;
  IMPORTS Units;
  IMPORTS CoordSys;

  REFSYSTEM BASKET BCoordSys ~ CoordSys.CoordsysTopic
    OBJECTS OF GeoCartesian2D: CHLV95
    OBJECTS OF GeoHeight: SwissOrthometricAlt;

  DOMAIN
    !!@CRS=EPSG:2056
    Coord2 = COORD
      2460000.000 .. 2870000.000 [m] {CHLV95[1]},
      1045000.000 .. 1310000.000 [m] {CHLV95[2]},
      ROTATION 2 -> 1;

    !!@CRS=EPSG:2056
    Coord3 = COORD
      2460000.000 .. 2870000.000 [m] {CHLV95[1]},
      1045000.000 .. 1310000.000 [m] {CHLV95[2]},
         -200.000 ..   5000.000 [m] {SwissOrthometricAlt[1]},
      ROTATION 2 -> 1;

    Surface = SURFACE WITH (STRAIGHTS, ARCS) VERTEX Coord2 WITHOUT OVERLAPS > 0.001;
    Area = AREA WITH (STRAIGHTS, ARCS) VERTEX Coord2 WITHOUT OVERLAPS > 0.001;
    Line = POLYLINE WITH (STRAIGHTS, ARCS) VERTEX Coord2;
    DirectedLine EXTENDS Line = DIRECTED POLYLINE;
    LineWithAltitude = POLYLINE WITH (STRAIGHTS, ARCS) VERTEX Coord3;
    DirectedLineWithAltitude = DIRECTED POLYLINE WITH (STRAIGHTS, ARCS) VERTEX Coord3;
    
    /* minimal overlaps only (2mm) */
    SurfaceWithOverlaps2mm = SURFACE WITH (STRAIGHTS, ARCS) VERTEX Coord2 WITHOUT OVERLAPS > 0.002;
    AreaWithOverlaps2mm = AREA WITH (STRAIGHTS, ARCS) VERTEX Coord2 WITHOUT OVERLAPS > 0.002;

    Orientation = 0.00000 .. 359.99999 CIRCULAR [Units.Angle_Degree] <Coord2>;

    Accuracy = (cm, cm50, m, m10, m50, vague);
    Method = (measured, sketched, calculated);

    STRUCTURE LineStructure = 
      Line: Line;
    END LineStructure;

    STRUCTURE DirectedLineStructure =
      Line: DirectedLine;
    END DirectedLineStructure;

    STRUCTURE MultiLine =
      Lines: BAG {1..*} OF LineStructure;
    END MultiLine;

    STRUCTURE MultiDirectedLine =
      Lines: BAG {1..*} OF DirectedLineStructure;
    END MultiDirectedLine;

    STRUCTURE SurfaceStructure =
      Surface: Surface;
    END SurfaceStructure;

    STRUCTURE MultiSurface =
      Surfaces: BAG {1..*} OF SurfaceStructure;
    END MultiSurface;

END GeometryCHLV95_V1.

!! ########################################################################
','2019-10-10 15:50:26.169');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.createMetaInfo','True');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.beautifyEnumDispName','underscore');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.interlis.ili2c.ilidirs','.;http://models.geo.admin.ch');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.arrayTrafo','coalesce');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.createForeignKeyIndex','yes');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.nameOptimization','topic');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.localisedTrafo','expand');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.jsonTrafo','coalesce');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.numericCheckConstraints','create');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.sender','ili2pg-4.3.0-21cbac10c7e35a41346af1c5fc5d6980bb99609d');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.createForeignKey','yes');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.sqlgen.createGeomIndex','True');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.defaultSrsAuthority','EPSG');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.defaultSrsCode','2056');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.createEnumDefs','multiTable');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.maxSqlNameLength','60');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.uuidDefaultValue','uuid_generate_v4()');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.inheritanceTrafo','smart1');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.catalogueRefTrafo','coalesce');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.multiPointTrafo','coalesce');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.StrokeArcs','enable');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.multiLineTrafo','coalesce');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.multiSurfaceTrafo','coalesce');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.multilingualTrafo','expand');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('SO_Forstreviere_Publikation_20170428','Issuer','http://www.agi.so.ch');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('SO_Forstreviere_Publikation_20170428','Title','Forstreviere und Forstkreise');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('SO_Forstreviere_Publikation_20170428','shortDescription','Forstreviere und Forstkreise des Kanton Solothurn');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('SO_Forstreviere_Publikation_20170428','File','SO_Forstreviere_Publikation_20170428.ili');
INSERT INTO awjf_forstreviere_pub.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('SO_Forstreviere_Publikation_20170428','technicalContact','mailto:agi@so.ch');
