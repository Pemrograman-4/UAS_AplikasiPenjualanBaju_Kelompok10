import 'dart:async';
import 'package:flutter_baju/const/collor.dart';
import 'package:flutter_baju/server/server.dart';
import 'package:flutter_baju/ui/home.dart';
import 'package:flutter_baju/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AddProduk extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<AddProduk> {
  //Tambahkan varibale untuk menampung data dari inputan
  TextEditingController harga_baju = new TextEditingController();
  TextEditingController warna_baju = new TextEditingController();
  TextEditingController deskripsi_baju = new TextEditingController();
  TextEditingController merk_baju = new TextEditingController();

  void showSnakbar(BuildContext context, Message, color) {
    final snackBar = SnackBar(content: Text(Message), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> Simpan() async {
    var url = UrlServer + "produk/add";
    String warna = warna_baju.text;
    String deskripsi = deskripsi_baju.text;
    String merk = merk_baju.text;
    String harga = harga_baju.text;
    if (warna.isEmpty || deskripsi.isEmpty || merk.isEmpty || harga.isEmpty) {
      // Navigator.of(context, rootNavigator: true).pop();
      showSnakbar(context, 'Kolom Tidak Kosong !', ErrorColor);
    } else {
      final response = await http.post(Uri.parse(url), body: {
        "warna": warna,
        "deskripsi": deskripsi,
        "merk": merk,
        "harga": harga
      });
      var result = convert.jsonDecode(response.body);
      String Message = result['message'];
      if (result['status']) {
        Navigator.of(context, rootNavigator: true).pop();
        showSnakbar(context, Message, SuccesColor);
        print(Message);
        var _duration = const Duration(seconds: 1);
        Timer(_duration, () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => homepage()));
        });
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        showSnakbar(context, Message, ErrorColor);
        print(Message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Baju'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 15),
              child: Center(
                child: Container(
                    width: 150,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/ss.png')),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Center(
                child: Text(
                  'Tambah Baju',
                  style: (TextStyle(
                      color: Colors.blue, fontSize: 25, fontFamily: 'Raleway')),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: harga_baju,
                autofocus: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'Harga',
                    hintText: 'Masukan Harga Baju'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: warna_baju,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'Warna Baju',
                    hintText: 'Masukan Warna Baju'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: deskripsi_baju,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'Deskripsi',
                    hintText: 'Deskripsi Baju'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: merk_baju,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'Merk',
                    hintText: 'Masukan Merk Baju'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                margin: const EdgeInsets.all(10),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    Submit(context);
                  },
                  child: const Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
            // Text('Belum Punya Akun? Daftar')
          ],
        ),
      ),
    );
  }

  Future<void> Submit(BuildContext context) async {
    try {
      Simpan();
    } catch (error) {
      print(error);
    }
  }
}