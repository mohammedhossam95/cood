import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/params/search_params.dart';
import '/core/widgets/my_default_button.dart';
import '/core/widgets/search_text_field.dart';
import '/features/cars/domain/entities/car_entity.dart';
import '/features/home/presentation/bloc/cities_bloc/cities_bloc.dart';
import '/features/home/presentation/widgets/bottom_loader.dart';
import '/injection_container.dart';

class CitiesList extends StatefulWidget {
  final ValueChanged<City?>? updateSelected;

  const CitiesList({
    super.key,
    this.updateSelected,
  });

  @override
  State<CitiesList> createState() => _CitiesListState();
}

class _CitiesListState extends State<CitiesList> {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode textSearchFocus = FocusNode();
  final _scrollController = ScrollController();
  late AppLocalizations locale;
  late TextTheme theme;

  // Track the selected zip code
  City? selectedZipCode;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<CitiesBloc>(context).add(CitiesFetched(
      SearchParams(
        keyword: textEditingController.text,
      ),
    ));
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<CitiesBloc>().add(CitiesFetched(
            SearchParams(
              keyword: textEditingController.text,
            ),
          ));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    locale = AppLocalizations.of(context)!;
    theme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.all(16.0.r),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'choose_city'.tr,
                      textAlign: TextAlign.center,
                      style: theme.bodyMedium!.copyWith(
                        fontSize: 20.sp,
                        color: colors.textColor,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    icon: Icon(
                      Icons.close,
                      color: colors.textColor,
                    ),
                  )
                ],
              ),
              SizedBox(height: 16.h),
              MySearchBar(
                controller: textEditingController,
                focusNode: FocusNode(),
                hintText: 'search'.tr,
                onTap: (term) => search(),
                autoComplete: true,
              ),
              SizedBox(height: 16.h),
              BlocBuilder<CitiesBloc, CitiesState>(
                builder: (context, state) {
                  switch (state.status) {
                    case CitiesStatus.initial:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case CitiesStatus.success:
                      if (state.posts.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(locale.text('noData')),
                          ),
                        );
                      }

                      return Expanded(
                        child: ListView.separated(
                          itemCount: state.hasReachedMax
                              ? state.posts.length
                              : state.posts.length + 1,
                          controller: _scrollController,
                          separatorBuilder: (context, int x) => const Divider(),
                          itemBuilder: (context, index) {
                            if (index >= state.posts.length) {
                              return const BottomLoader();
                            }

                            final zipCode = state.posts[index];
                            final isSelected = selectedZipCode == zipCode;

                            return ListTile(
                              onTap: () {
                                setState(() {
                                  selectedZipCode = isSelected ? null : zipCode;
                                });
                              },
                              title: Text(
                                appLocalizations.isArLocale
                                    ? zipCode.nameAr ?? ''
                                    : zipCode.nameEn ?? '',
                                style: theme.bodySmall!.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                              leading: isSelected
                                  ? Icon(Icons.check_circle, color: colors.main)
                                  : const Icon(Icons.circle_outlined),
                            );
                          },
                        ),
                      );

                    case CitiesStatus.failure:
                      return Center(
                        child: Text(
                          state.message.toString(),
                        ),
                      );
                  }
                },
              ),
            ],
          ),
          MyDefaultButton(
            onPressed: () {
              widget.updateSelected?.call(selectedZipCode);
              // Navigator.pushNamed(context, Routes.addTaskScreenRoute,
              //     arguments: AddTaskScreenArgs(
              //       serviceId: widget.serviceId,
              //       zipCode: selectedZipCode?.id,
              //     ));
              Navigator.pop(context);
            },
            btnText: 'confirm',
          ),
        ],
      ),
    );
  }

  search() {
    context.read<CitiesBloc>().add(CitiesFetched(
          SearchParams(
            keyword: textEditingController.text,
          ),
        ));
  }
}
