import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikomik/presentation/widgets/comic_card_widget.dart';

import '../../../../common/enums.dart';
import '../../../controllers/search_comic_controller.dart';

class SearchPagePhone extends StatelessWidget {
  const SearchPagePhone({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Komik Search",
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GetX<SearchComicController>(
        builder: (controller) => RefreshIndicator(
          onRefresh: controller.search,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 16.0,
              ),
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.searchInputController,
                    autofocus: true,
                    textInputAction: TextInputAction.send,
                    textAlignVertical: kIsWeb || kIsWasm
                        ? TextAlignVertical.center
                        : Platform.isWindows ||
                                Platform.isMacOS ||
                                Platform.isLinux
                            ? TextAlignVertical.top
                            : TextAlignVertical.center,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Search",
                      hintText: "Search comic here",
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      suffixIcon: controller.query.value.isEmpty
                          ? null
                          : IconButton(
                              onPressed: controller.clearQuery,
                              icon: Icon(
                                Icons.close,
                                color: theme.primaryColor,
                              ),
                            ),
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    onChanged: controller.changeQuery,
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    onFieldSubmitted: (value) => controller.search(),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  if (controller.comics.isEmpty &&
                      controller.stateSearch.value == RequestState.loaded)
                    Center(
                      child: Text(
                        "Comic not found",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  if (controller.comics.isNotEmpty &&
                      controller.stateSearch.value == RequestState.loaded)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (size.width / 250).round(),
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        mainAxisExtent: 260,
                      ),
                      itemCount: controller.comics.length,
                      itemBuilder: (context, index) {
                        final item = controller.comics[index];

                        return ComicCardWidget(
                          comic: item,
                        );
                      },
                    ),
                  if (controller.stateSearch.value == RequestState.loading)
                    const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
