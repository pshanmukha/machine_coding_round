import 'package:flutter/material.dart';
import 'package:machine_code/utils/dash_divider.dart';
import 'package:machine_code/utils/util_methods.dart';

import 'agenda_model.dart';

class AgendaItemWidget extends StatefulWidget {
  final Datum datum;
  final String accessToken;
  const AgendaItemWidget({super.key,required this.datum, required this.accessToken});

  @override
  State<AgendaItemWidget> createState() => _AgendaItemWidgetState();
}

class _AgendaItemWidgetState extends State<AgendaItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Image.network(
            widget.datum.imageUrl,
            width: 50,
            height: 50,
            headers: {
              'Authorization': 'Bearer ${widget.accessToken}', // Include token if required
            },
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error); // Display an error icon if the image fails to load
            },
          ),
          const SizedBox(width: 16.0),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.datum.title),
                SizedBox(
                    width: double.infinity,
                    child: CustomPaint(
                      painter: DashedLinePainter(),
                    )
                ),
                Text("${widget.datum.speakerName ?? ""}"),
                Text("${widget.datum.sessionTitle} | ${widget.datum.locationName}"),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(children: [
              IconButton(
                icon: Icon(
                  Icons.star,
                  color: widget.datum.selected ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    widget.datum.selected = !widget.datum.selected;
                  });
                },
              ),
              Text(widget.datum.occurs ?? ""),
              Text(formatTimeRange(widget.datum.startDate, widget.datum.endDate)),
              Text(widget.datum.eventClassification ?? ""),
            ],),
          )
        ],
      ),
    );
  }
}
