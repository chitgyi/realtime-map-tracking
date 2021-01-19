import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:realtime_map_tracking/features/home/presentation/pages/location.picker.page.dart';

import '../../../../core/builders/bloc_builder.dart';
import '../blocs/home.bloc.dart';
import '../widgets/location_text_field.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeBloc>(context, listen: false);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              heroTag: 1,
              onPressed: bloc.setCameraPositionToMyLocation,
              child: Icon(Icons.location_on),
            ),
            FloatingActionButton(
              heroTag: 2,
              onPressed: bloc.drawPolylinesAndMarkers,
              child: Icon(Icons.drive_eta),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          BlocBuilder<HomeBloc>(
            builder: (bloc, _) => GoogleMap(
              initialCameraPosition: bloc.cameraPosition,
              onMapCreated: bloc.onMapCreated,
              zoomControlsEnabled: false,
              markers: bloc.markers,
              polylines: bloc.polylines,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
            ),
          ),
          Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).padding.top,
                    ),
                    LocationTextField(
                      hintText: 'Source',
                      controller: bloc.sourceTextController,
                      enabled: false,
                      onTap: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (_) => LocationPickerPage(
                              currentPosition: bloc.sourcePosition,
                            ),
                          ),
                        )
                            .then(
                          (pickedSourcePosition) {
                            bloc.sourcePosition = pickedSourcePosition;
                            bloc.sourceTextController.text =
                                pickedSourcePosition.toString();
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    LocationTextField(
                      hintText: 'Destination',
                      controller: bloc.destinationTextController,
                      enabled: false,
                      onTap: () {
                        print('on tap');
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (_) => LocationPickerPage(
                              currentPosition: bloc.destinationPosition,
                            ),
                          ),
                        )
                            .then(
                          (pickedDestinationPosition) {
                            bloc.destinationPosition =
                                pickedDestinationPosition;
                            bloc.destinationTextController.text =
                                pickedDestinationPosition.toString();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
