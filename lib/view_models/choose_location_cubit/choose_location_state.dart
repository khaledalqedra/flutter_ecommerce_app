part of 'choose_location_cubit.dart';


sealed class ChooselocationState {}

final class ChooselocationInitial extends ChooselocationState {}

final class FetchingLocations extends ChooselocationState {}

final class FetchedLocations extends ChooselocationState {
  final List<LocationItemModel> locations;

  FetchedLocations(this.locations);
}

final class FetchLocationsFailure extends ChooselocationState {
  final String errorMessage;

  FetchLocationsFailure(this.errorMessage);
}
final class AddingLocations extends ChooselocationState {}

final class LocationAdded extends ChooselocationState {

}

final class LocationAddingFailure extends ChooselocationState {
  final String errorMessage;

  LocationAddingFailure(this.errorMessage);
}

final class LocationChosen extends ChooselocationState {
  final LocationItemModel location;

  LocationChosen(this.location);
}

final class ConfirmAddressLoading extends ChooselocationState {}

final class ConfirmAddressLoaded extends ChooselocationState {

}

final class ConfirmAddressFailure extends ChooselocationState {
  final String errorMessage;

  ConfirmAddressFailure(this.errorMessage);
}