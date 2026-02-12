import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/models/location_item_model.dart';
import 'package:flutter_ecommerce_app/utils/app_colors.dart';
import 'package:flutter_ecommerce_app/view_models/choose_location_cubit/choose_location_cubit.dart';
import 'package:flutter_ecommerce_app/views/widgets/location_item_widget.dart';
import 'package:flutter_ecommerce_app/views/widgets/main_botton.dart';

class ChooseLocationPage extends StatefulWidget {
  const ChooseLocationPage({super.key});

  @override
  State<ChooseLocationPage> createState() => _ChooseLocationPageState();
}

class _ChooseLocationPageState extends State<ChooseLocationPage> {
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ChooselocationCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Location'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Choose your Location',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
              const SizedBox(height: 12.0),
              Text(
                  'Let\'s find unforgetable event. Choose a location to get started:',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: AppColors.grey,
                      )),
              const SizedBox(height: 36.0),
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  suffixIcon:
                      BlocConsumer<ChooselocationCubit, ChooselocationState>(
                    bloc: cubit,
                    buildWhen: (previous, current) =>
                        current is AddingLocations ||
                        current is LocationAdded ||
                        current is LocationAddingFailure,
                    listenWhen: (previous, current) => 
                    current is LocationAdded || current is ConfirmAddressLoaded,
                    listener: (context, state) {
                      if (state is LocationAdded) {
                        locationController.clear();
                      } else if (state is ConfirmAddressLoaded) {
                        Navigator.of(context).pop();
                      }
                    },
                    builder: (context, state) {
                      if (state is AddingLocations) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: AppColors.grey,
                          ),
                        );
                      }
                      return IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          if (locationController.text.isNotEmpty) {
                            cubit.addLocation(locationController.text);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Enter your location!'),
                              ),
                            );
                          }
                          // Handle add location
                        },
                      );
                    },
                  ),
                  suffixIconColor: AppColors.grey,
                  prefixIconColor: AppColors.grey,
                  hintText: 'Write location: city-country',
                  fillColor: AppColors.grey1,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: AppColors.red,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 36.0),
              Text(
                'Select Location',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 16.0),
              BlocBuilder<ChooselocationCubit, ChooselocationState>(
                bloc: cubit,
                buildWhen: (previous, current) =>
                    current is FetchedLocations ||
                    current is FetchingLocations ||
                    current is FetchLocationsFailure,
                builder: (context, state) {
                  if (state is FetchingLocations) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FetchedLocations) {
                    final locations = state.locations;

                    return ListView.builder(
                      itemCount: locations.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final location = locations[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: BlocBuilder<ChooselocationCubit,
                              ChooselocationState>(
                            bloc: cubit,
                            buildWhen: (previous, current) =>
                                current is LocationChosen,
                            builder: (context, state) {
                              LocationItemModel? chosenLocation;
                              if (state is LocationChosen) {
                                chosenLocation = state.location;
                              }
                              return LocationItemWidget(
                                onTap: () {
                                  cubit.selectLocation(location.id);
                                },
                                location: location,
                                borderColor: chosenLocation?.id == location.id
                                    ? AppColors.primary
                                    : AppColors.grey,
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is FetchLocationsFailure) {
                    return Center(
                      child: Text(state.errorMessage),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(height: 24.0),
              BlocBuilder<ChooselocationCubit, ChooselocationState>(
                bloc: cubit,
                buildWhen: (previous, current) =>
                    current is ConfirmAddressLoaded ||
                    current is ConfirmAddressLoading ||
                    current is ConfirmAddressFailure,
                builder: (context, state) {
                  if (state is ConfirmAddressLoading) {
                    return MainBotton(
                      isLoading: true,
                    );
                  }

                  return MainBotton(
                    text: 'Confirm Address',
                    onTap: () {
                      cubit.confirmAddress();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
