import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '/core/params/car_params.dart';
import '/core/widgets/my_default_button.dart';
import '/core/widgets/search_text_field.dart';
import '/features/cars/domain/entities/branch_entity.dart';
import '/features/cars/presentation/bloc/branches_bloc.dart';
import '/features/home/presentation/widgets/bottom_loader.dart';
import '/injection_container.dart';

class BranchesList extends StatefulWidget {
  final String? cityId, customerId;
  final ValueChanged<Branch?>? updateSelected;

  const BranchesList({
    super.key,
    this.updateSelected,
    this.cityId,
    this.customerId,
  });

  @override
  State<BranchesList> createState() => _BranchesListState();
}

class _BranchesListState extends State<BranchesList> {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode textSearchFocus = FocusNode();
  final _scrollController = ScrollController();
  late AppLocalizations locale;
  late TextTheme theme;
  Branch? selectedBranch;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<BranchesBloc>(context).add(BranchesFetched(
      CarParams(
        keyword: textEditingController.text,
        customerId: widget.customerId,
        cityId: widget.cityId,
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
      context.read<BranchesBloc>().add(BranchesFetched(
            CarParams(
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
                      'choose_branch'.tr, // Updated text
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
                focusNode: textSearchFocus,
                hintText: 'Search', // Updated hint text
                onTap: (term) => search(),
                autoComplete: true,
              ),
              SizedBox(height: 16.h),
              BlocBuilder<BranchesBloc, BranchesState>(
                builder: (context, state) {
                  switch (state.status) {
                    case BranchesStatus.initial:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case BranchesStatus.success:
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

                            final branch = state.posts[index];
                            final isSelected = selectedBranch == branch;

                            return ListTile(
                              onTap: () {
                                setState(() {
                                  selectedBranch = isSelected ? null : branch;
                                });
                              },
                              title: Text(
                                branch.nameAr ?? '',
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

                    case BranchesStatus.failure:
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
              widget.updateSelected?.call(selectedBranch);
              Navigator.pop(context);
            },
            btnText: 'confirm',
          ),
        ],
      ),
    );
  }

  search() {
    context.read<BranchesBloc>().add(BranchesFetched(
          CarParams(
            keyword: textEditingController.text,
          ),
        ));
  }
}
