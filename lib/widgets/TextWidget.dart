import 'package:flutter/material.dart';


class TextWidget extends StatefulWidget
{
	TextWidget(this.textString, this.textSize, this.textColor, this.textFont, this.textAlign);
	
	final String textString;
	final double textSize;
	final Color textColor;
	final FontWeight textFont;
	final TextAlign textAlign;
	
	
	@override
	TextWidgetState createState() => TextWidgetState();
}

class TextWidgetState extends State<TextWidget>
{
  @override
  Widget build(BuildContext context)
{
    return  Container(
	width: MediaQuery.of(context).size.width,
	child: Text(
		widget.textString,
		softWrap: true,
		style: TextStyle(
			fontSize: widget.textSize,
			fontFamily: 'Productsans',
			color: widget.textColor,
			fontWeight: widget.textFont),
			textAlign: widget.textAlign,
		),
	);
  }
}
