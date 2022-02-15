import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OkNotedToolbar extends StatelessWidget with PreferredSizeWidget {
  const OkNotedToolbar(this.preferredSize, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: 82,
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(16, 82 / 3, 0, 0),
                child: Text(
                  "Mau inget apa ni?",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, color: Color(0xff1A1A1A)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 82 / 3, 4, 0),
              width: 32,
              height: 24,
              child: SvgPicture.asset('assets/toolbar/more.svg'),
            )
          ],
        ),
      ),
    );
  }

  @override
  final Size preferredSize;
}
