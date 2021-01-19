import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:realtime_map_tracking/features/home/presentation/blocs/location.picker.bloc.dart';

import '../../../../core/builders/bloc_builder.dart';
import '../widgets/location_text_field.dart';

class LocationPickerPage extends StatelessWidget {
  final LatLng currentPosition;
  LocationPickerPage({this.currentPosition});
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LocationPickerBloc>(context, listen: false);
    bloc.pickedPosition = currentPosition ?? LatLng(20, 20);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: "location",
              onPressed: () => bloc.setCameraPositionToMyLocation(),
              child: Icon(Icons.location_on),
            ),
            FloatingActionButton(
              heroTag: "done",
              onPressed: () => Navigator.pop(
                context,
                bloc.pickedPosition,
              ),
              child: Icon(Icons.done),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          BlocBuilder<LocationPickerBloc>(
            builder: (bloc, _) => GoogleMap(
              initialCameraPosition: bloc.cameraPosition,
              onMapCreated: bloc.onMapCreated,
              zoomControlsEnabled: false,
              markers: bloc.markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              compassEnabled: true,
              onCameraMove: bloc.onCameraMove,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 10.0,
                left: 10.0,
                right: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: LocationTextField(
                    hintText: 'Search...',
                    controller: bloc.locationTextController,
                    onTap: () {
                      print('on tap');
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
