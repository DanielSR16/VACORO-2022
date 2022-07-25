import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';

class generateReports extends StatefulWidget {
  generateReports({Key? key}) : super(key: key);

  @override
  State<generateReports> createState() => _generateReportsState();
}

class _generateReportsState extends State<generateReports> {
  final String folderSave = 'Reportes/';
  var savePath = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            print("Regresar...");
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Reportes"),
        centerTitle: true,
        actions: [
          Container(
            child: Image.asset('assets/images/logoVacoro.png'),
            height: 60,
            width: 60,
          )
        ],
        backgroundColor: ColorSelect.color5,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Text('Seleccione el reporte a generar',
                  style: TextStyle(fontSize: 18)),
            ),
            Center(
              child: Container(
                width: size.width - 50,
                height: 70,
                margin: EdgeInsets.only(top: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(35),
                    primary: ColorSelect.color5,
                    onPrimary: Colors.white,
                    textStyle: const TextStyle(fontSize: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  onPressed: () {
                    var urlDescarga =
                        "http://192.168.100.15:3001/pdf/globalReportVaca"; //url del back
                    String fileName =
                        "Vacas.pdf"; //url.substring(url.lastIndexOf("/") + 1);
                    downloadFile(urlDescarga, fileName);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 1000),
                        content: Text('Reporte generado, revise descargas'),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image(
                          image: AssetImage('assets/images/vaca.png'),
                          width: 40,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            "Generar reporte vacas",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20.0),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                  width: size.width - 50,
                  height: 70,
                  margin: EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(35),
                      primary: ColorSelect.color5,
                      onPrimary: Colors.white,
                      textStyle: const TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    onPressed: () {
                      var urlDescarga =
                          "http://192.168.100.15:3001/pdf/globalReportToro"; //url del back
                      String fileName =
                          "Toros.pdf"; //url.substring(url.lastIndexOf("/") + 1);
                      downloadFile(urlDescarga, fileName);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 1000),
                          content: Text('Reporte generado, revise descargas'),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Image(
                            image: AssetImage('assets/images/toro.png'),
                            width: 40,
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 30.0),
                            child: Text(
                              "Generar reporte toros",
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20.0),
                            ))
                      ],
                    ),
                  )),
            ),
            Center(
              child: Container(
                  width: size.width - 50,
                  height: 70,
                  margin: EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(35),
                      primary: ColorSelect.color5,
                      onPrimary: Colors.white,
                      textStyle: const TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    onPressed: () {
                      var urlDescarga =
                          "http://192.168.100.15:3001/pdf/globalReportBecerro"; //url del back
                      String fileName =
                          "Becerros.pdf"; //url.substring(url.lastIndexOf("/") + 1);
                      downloadFile(urlDescarga, fileName);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 1000),
                          content: Text('Reporte generado, revise descargas'),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Image(
                            image: AssetImage('assets/images/becerro.png'),
                            width: 37,
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 30.0),
                            child: Text(
                              "Generar reporte becerros",
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20.0),
                            ))
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future downloadFile(url, filename) async {
    bool downloading = true;
    String downloadingStr = "No data";

    final directory = await getExternalStorageDirectory();
    String rutaGuardado = directory!.path + "/";

    try {
      Dio dio = Dio();
      savePath = await getFilePath(rutaGuardado, filename);
      await dio.download(url, savePath, onReceiveProgress: (rec, total) {
        setState(() {
          downloading = true;
          downloadingStr = "Downloading Image : $rec";
        });
      });
      setState(() {
        downloading = false;
        downloadingStr = "Completed";
      });

      print(downloading);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getFilePath(rutaGuardado, fileName) async {
    String path = 'storage/emulated/0/download/' + fileName;
    return path;
  }
}
