import 'package:dinamik_not_ortalama/constants/app_constants.dart';
import 'package:dinamik_not_ortalama/helper/data_helper.dart';
import 'package:dinamik_not_ortalama/model/ders.dart';
import 'package:dinamik_not_ortalama/widgets/ders_listesi.dart';
import 'package:dinamik_not_ortalama/widgets/ortalama_goster.dart';
import 'package:flutter/material.dart';

class OrtalamaHesaplaPage extends StatefulWidget {
  const OrtalamaHesaplaPage({super.key});

  @override
  State<OrtalamaHesaplaPage> createState() => _OrtalamaHesaplaPageState();
}

class _OrtalamaHesaplaPageState extends State<OrtalamaHesaplaPage> {
  var formKey = GlobalKey<FormState>();
  double secilenDeger = 4;
  double secilenKredi = 1;
  String girilenDersAdi = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            Sabitler.baslikText,
            style: Sabitler.baslikStyle,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //form
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildForm(),
              ),
              Expanded(
                flex: 1,
                child: OrtalamaGoster(
                    dersSayisi: DataHelper.tumEklenenDersler.length,
                    ortalama: DataHelper.ortalamaHesapla()),
              )
            ],
          ),
          //liste
          Expanded(
            child: DersListesi(
              onDismiss: (index){
                DataHelper.tumEklenenDersler.removeAt(index);
                setState(() {
                  
                });
              },
            ),
          )
        ],
      ),
    );
  }

  _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: Sabitler.yatayPadding8,
            child: _buildTextFormField(),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: Sabitler.yatayPadding8,
                  child: _buildHarfler(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: Sabitler.yatayPadding8,
                  child: _buildKrediler(),
                ),
              ),
              IconButton(
                onPressed: _dersEkleveOrtalamaHesapla,
                icon: Icon(Icons.arrow_forward_ios_sharp),
                color: Sabitler.anaRenk,
                iconSize: 30,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  _buildTextFormField() {
    return TextFormField(
      onSaved: (deger) {
        setState(() {
          girilenDersAdi = deger!;
        });
      },
      validator: (s) {
        if (s!.length <= 0) {
          return "Ders adını giriniz";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: "Ders adını giriniz",
        border: OutlineInputBorder(
            borderRadius: Sabitler.borderRadius, borderSide: BorderSide.none),
        filled: true,
        fillColor: Sabitler.anaRenk.shade100.withOpacity(0.3),
      ),
    );
  }

  _buildHarfler() {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropDownPadding,
      decoration: BoxDecoration(
          color: Sabitler.anaRenk.shade100.withOpacity(0.3),
          borderRadius: Sabitler.borderRadius),
      child: DropdownButton<double>(
        value: secilenDeger,
        elevation: 16,
        iconEnabledColor: Sabitler.anaRenk.shade200,
        onChanged: (deger) {
          setState(() {
            secilenDeger = deger!;
          });
        },
        underline: Container(),
        items: DataHelper.tumDerslerinHarfleri(),
      ),
    );
  }

  _buildKrediler() {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropDownPadding,
      decoration: BoxDecoration(
          color: Sabitler.anaRenk.shade100.withOpacity(0.3),
          borderRadius: Sabitler.borderRadius),
      child: DropdownButton<double>(
        value: secilenKredi,
        elevation: 16,
        iconEnabledColor: Sabitler.anaRenk.shade200,
        onChanged: (deger) {
          setState(() {
            secilenKredi = deger!;
          });
        },
        underline: Container(),
        items: DataHelper.tumDerslerinKredileri(),
      ),
    );
  }

  _dersEkleveOrtalamaHesapla() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var eklenecekDers = Ders(
          ad: girilenDersAdi,
          harfDegeri: secilenDeger,
          krediDegeri: secilenKredi);
      DataHelper.dersEkle(eklenecekDers);
      setState(() {});
    }
  }
}
