import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '/config/locale/app_localizations.dart';
import '/core/utils/extension.dart';
import '/core/widgets/error_text.dart';
import '/features/language/domain/entities/languages_response.dart';
import '/features/language/presentation/cubit/get_languages_cubit/get_languages_cubit.dart';
import '../../../../core/utils/values/svg_manager.dart';
import '../../../../injection_container.dart';

class LanguagesView extends StatefulWidget {
  final ValueChanged<Language>? updateView;
  const LanguagesView({super.key, this.updateView});

  @override
  State<LanguagesView> createState() => _LanguagesViewState();
}

class _LanguagesViewState extends State<LanguagesView> {
  Language? languageValue;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    TextTheme theme = Theme.of(context).textTheme;
    AppLocalizations locale = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          border: Border.all(
            color: colors.main,
          )),
      child: BlocBuilder<GetLanguagesCubit, GetLanguagesState>(
        builder: (context, state) {
          if (state is GetLanguagesIsLoading) {
            return Center(
              child: const CircularProgressIndicator().appLoading,
            );
          } else if (state is GetLanguagesLoaded) {
            List<Language> languages = state.response.data as List<Language>;
            if (languages.isNotEmpty && languageValue == null) {
              languageValue = languages[0];
              widget.updateView!(languageValue!);
            }
            return languages.isNotEmpty
                ? ListView.builder(
                    itemCount: languages.length,
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                      onTap: () {
                        setState(() {
                          languageValue = languages[index];
                          widget.updateView!(languageValue!);
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.r),
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: colors.dividerColor,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  languages[index].name ?? '',
                                  style: theme.bodyMedium!
                                      .copyWith(fontSize: 14.sp),
                                ),
                              ),
                            ),
                            languageValue?.id == languages[index].id
                                ? SvgPicture.asset(SvgAssets.bell)
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: ErrorText(
                      text: locale.text('noData'),
                      // width: width,
                      width: width * 0.25,
                      isNetwork: false,
                    ),
                  );
          } else if (state is GetLanguagesError) {
            return Center(
              child: ErrorText(
                text: state.msg.toString(),
                width: width * 0.25,
                isNetwork: false,
              ),
            );
          } else {
            return Center(
              child: ErrorText(
                text: locale.text('noData'),
                width: width * 0.25,
                isNetwork: false,
              ),
            );
          }
        },
      ),
    );
  }
}
