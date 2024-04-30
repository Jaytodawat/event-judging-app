import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../data/models/Winner.dart';
import '../../providers/event_provider.dart';

class WinnerListScreen extends StatelessWidget {
  final int eventId;

  const WinnerListScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    var eventListModel = Provider.of<EventListModel>(context, listen: true);
    Future<void> refreshWinners() async {
      // Call the function to fetch winners again
      await eventListModel.refresh();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Winners',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: RefreshIndicator(
          onRefresh: () => refreshWinners(),
          child: FutureBuilder<List<Winner>>(
            future: eventListModel.getWinnerList(eventId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                String errorMessage = '';
                if (snapshot.error is Exception) {
                  // print(snapshot.error.hashCode);
                  final error = snapshot.error as Exception;
                  // print(error is DioException);
                  if (error is DioException) {
                    // print(error.response?.statusCode);
                    if (error.response?.statusCode == 400) {
                      errorMessage = 'Wrong input';
                    } else if (error.response?.statusCode == 502) {
                      errorMessage = 'Server down';
                    } else {
                      // print(error.response?.statusCode);
                      errorMessage = 'Unknown error';
                    }
                  } else {
                    // print(error.response?.statusCode);
                    errorMessage = 'No Teams Judged yet';
                  }
                } else {
                  // print(snapshot.error.response?.statusCode);
                  errorMessage = 'No Team Judged Yet in this event';
                }
                return Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              } else {
                final winners = snapshot.data!;
                return ListView.builder(
                  itemCount: winners.length,
                  itemBuilder: (context, index) {
                    final winner = winners[index];
                    return WinnerCard(winnerTeam: winner);
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class WinnerCard extends StatelessWidget {
  final Winner winnerTeam;
  const WinnerCard({super.key, required this.winnerTeam});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0),
        child: Material(
          color: Colors.white,
          // elevation: 1,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${winnerTeam.teamId}',
                        style: kSubTextStyle.copyWith(
                            color: Colors.black, fontSize: 10),
                      ),
                      Text(
                        winnerTeam.teamName,
                        style: kSubTextStyle1.copyWith(fontSize: 14),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.score),
                          const SizedBox(
                              width:
                                  8), // Adjust the spacing between the icon and text as needed
                          Text('${winnerTeam.teamScore}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
