import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/favoriets_model.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/shared/cubits/main_cubit/app_cubit.dart';
import 'package:shop_app/shared/other/components.dart';
import 'package:shop_app/shared/setting/vars.dart';

class ComponPrivt {
  AppCubit cubit;

  ComponPrivt(this.cubit);

  Widget productItemColumn(Products product) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              img(product.image, izFit: false, hight: 200),
              if (product.discount != 0)
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, left: 5),
                  child: Container(
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      )),
                )
            ],
          ),
          Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                (product.name ?? ''),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Text(product.price.toString() + '  '),
                if (product.discount != 0)
                  Text(
                    product.oldPrice.toString(),
                    style: const TextStyle(
                        color: Colors.grey,
                        decorationColor: Colors.red,
                        decoration: TextDecoration.lineThrough),
                  ),
                const Spacer(),
                favorButtom(product.id ?? -1)
              ],
            ),
          )
        ],
      );

  Widget productItemRow(ProductFavor? product) => Container(
    height: 150,
    child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                img(product!.image, izFit: false,width: 150),
                if (product.discount != 0)
                  Container(
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10,0, 10),
              child: Container(width: 1,color: Colors.grey[200],),
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          (product.name ?? ''),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,

                        )),
                    const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Text(product.price.toString() + '  '),
                            if (product.discount != 0)
                              Text(
                                product.oldPrice.toString(),
                                style: const TextStyle(
                                    color: Colors.grey,
                                    decorationColor: Colors.red,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            const Spacer(),
                            favorButtom(product.id ?? -1)
                          ],
                        ),
                      )
                  ],),
                ),
              ),
            )


          ],
        ),
  );

  Widget favorButtom(int id) => InkWell(
        onTap: () {
          cubit.addOrREmoveFavor(id);
        },
        child: CircleAvatar(
          backgroundColor:
              cubit.izFav[id] ?? false ? Vars.pryClr : Colors.grey[300],
          radius: 15,
          child: const Icon(
            Icons.favorite_border,
          ),
        ),
      );

  Widget img(String? url, {izFit = true, double? hight, double? width}) {
    return Image(
      image: NetworkImage(
        url ?? '',
      ),
      width: width,
      height: hight,
      fit: izFit ? BoxFit.cover : null,
    );
  }

  Widget line({double height = 2}) => Container(
        height: height,
        color: Colors.grey,
      );

  Widget showLoading(bool condition, Widget child) =>
      condition ? child : Components.loading();
}
