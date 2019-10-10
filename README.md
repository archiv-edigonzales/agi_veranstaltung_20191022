# agi_veranstaltung_20191022

## Einleitung
- AWJF möchte die Forstreviere und -kreise verwalten und im Web GIS Client publizieren. 
- Ein Forstkreis kann mehrere Forstreviere beinhalten. 
- In der Objektabfrage eines Forstrevieres möchte man sehen in welchem Forstkreis das Revier liegt.

Fragen: 
- Ein oder zwei Modelle?
- Warum zwei Modelle?
- Wo kommen die beiden Modelle liegen?
- Wie werden die Daten transferiert?

## Datenmodelle
Nach der gemeinsamen Auseinandersetzung der Thematik, wird mit UML-/INTERLIS-Editor das / die Datenmodell(e) erstellt. Im Web GIS das Resultat zeigen zum besseren Verständnis. Revier "Bucheggberg" vs. Kreis "Region Solothurn".

"Top-Down" / "Bottom-Up": Ein Revier kann aus einer oder mehreren Geometrien bestehen. Eine einzelne Geometrie wiederum kann genau exakt einem Kreis zugeordnet werden. Wenn wir das jetzt geschickt modellieren, muss man sehr wenig Daten erfassen. V.a. die Geometrie muss nur einmalig erfasst werden.

- UML zeigen
- Prüfung des Modelles zeigen
- Export in das Modell zeigen
- ILI zeigen

## Testen des Modells
```
docker-compose up
```

Frage: 
- Auf welche DB-Umgebung muss ich jetzt die leeren Tabellen anlegen?


**ili -> sql mit ili2pg auf die Int-Db**

```
ILI2PG_PATH=/Users/stefan/apps/ili2pg-4.3.0/ili2pg-4.3.0.jar  
java -jar ${ILI2PG_PATH} \
--dbschema awjf_forstreviere --models SO_Forstreviere_20170512 --modeldir ".;http://models.geo.admin.ch" \
--defaultSrsCode 2056 --createGeomIdx --createFk --createFkIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createNumChecks --nameByTopic --strokeArcs \
--createscript awjf_forstreviere.sql
```

```
ILI2PG_PATH=/Users/stefan/apps/ili2pg-4.3.0/ili2pg-4.3.0.jar  
java -jar ${ILI2PG_PATH} \
--dbschema awjf_forstreviere_pub --models SO_Forstreviere_Publikation_20170428 --modeldir ".;http://models.geo.admin.ch" \
--defaultSrsCode 2056 --createGeomIdx --createFk --createFkIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createNumChecks --nameByTopic --strokeArcs \
--createscript awjf_forstreviere_pub.sql
```

**QGIS-Projekt mit Formularen (Zukunft ist Automatisierung mit Model Baker)**

1. Kreis "Region Solothurn" erfassen.
2. Revier "Bucheggberg".
3. Geometrie "Messen" und Geometrie "Buchegg" erfassen und dem Revier "Bucheggberg" und dem Kreis "Region Solothurn" zuweisen. zuweisen.

Frage: 
- Wie geht es jetzt weiter? Was muss ich machen, damit ich zu den Revieren und den Kreisen komme?

**Umbau mit GRETL-Job**
GRETL-Job inkl. SQL zeigen.

```
export ORG_GRADLE_PROJECT_dbUriEdit="jdbc:postgresql://edit-db/edit"
export ORG_GRADLE_PROJECT_dbUserEdit="gretl"
export ORG_GRADLE_PROJECT_dbPwdEdit="gretl"
export ORG_GRADLE_PROJECT_dbUriPub="jdbc:postgresql://pub-db/pub"
export ORG_GRADLE_PROJECT_dbUserPub="gretl"
export ORG_GRADLE_PROJECT_dbPwdPub="gretl"
```

```

```


Zum Abschluss auch in GRETL-Jenkins zeigen.


int db
qgis projekt
