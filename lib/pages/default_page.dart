import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/slot/slot_bloc.dart';
import '../entry/entry_point.dart';
import '../widgets/default_list.dart';
import '../widgets/pdf_download.dart';

class SlotPage extends StatelessWidget {
  const SlotPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => RosterBloc()..add(FetchRoster()),
      child: BlocBuilder<RosterBloc, RosterState>(
        builder: (context, state) {
          if (state is RosterInitial) {
            return const Center(child: Text('Please wait...'));
          } else if (state is RosterLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RosterLoaded) {
            return Column(
              children: [
                Container(
                  // margin: EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  height: size.height,
                  width: size.width,
                  child: ListView.builder(
                    itemCount: state.rosterRecords.length,
                    itemBuilder: (context1, index1) {
                    final record = state.rosterRecords[index1];
                    // final userslotlist = widget.home.user_slot_list;
                      if (state.rosterRecords.length - 1 != index1) {
                        return defaultList(
                          record: record,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EntryScreen(
                                    body: PdfCreatorPage(data: record)),
                              ),
                            );
                          },
                        ); // Create a new today_work widget for each item
                      } else {
                        return Column(
                          children: [
                            defaultList(
                              record: record,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EntryScreen(
                                        body: PdfCreatorPage(data: record)),                            
                                  ),
                                );
                              }, 
                            ),
                            Container(height: 300)
                          ],
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 300,
                ),
              ],
            );
          } else if (state is RosterError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
