import 'package:dio_methods_curd/framework/controller/homecontroller/home_controller_provider.dart';
import 'package:dio_methods_curd/framework/repository/homerepository/module/fetchdata_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/theme/app_color.dart';
import '../utils/widgets/custom_text_widget.dart';

class ProductDetailedScreen extends ConsumerWidget {
  final Datum fetchData;

  const ProductDetailedScreen({super.key, required this.fetchData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async {
        ref.read(apisOperationProvider.notifier).getAllResponseApi(true);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: CustomTextWidget(
            text: "Product Detailed Screen",
            color: AppColor.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Consumer(
            builder: (context, ref, child) {
              final data = ref.watch(apisOperationProvider);

              /// when data is loading it show these
              if (data.uiState.isLoading) {
                return Expanded(
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              /// when error come that time thee code execute
              if (data.uiState.error != null) {
                return Expanded(
                  child: Center(

                    child: CustomTextWidget(
                      text: "${data.uiState.success.error}",
                      color: AppColor.error,
                    ),
                  ),
                );
              }

              if (data.uiState.success.singleData != null) {
                Datum d = data.uiState.success.singleData!;
                return Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Hero(
                        tag: d.id!,
                        child: Container(
                          height: 190,
                          width: 190,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: fetchData.logoUrl != null
                                ? Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image.network(d.logoUrl!),
                                  )
                                : Icon(
                                    Icons.shopify_outlined,
                                    color: AppColor.black,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTextWidget(
                      text: "Product Name  : ${d.name!}",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomTextWidget(
                      text:
                          "Product Description  : ${d.description ?? "No Discription"}",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                );
              }
              return Expanded(
                child: const Center(
                  child: CustomTextWidget(text: "No Data Found"),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
