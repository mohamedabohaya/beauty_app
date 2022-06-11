
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextWidget extends StatelessWidget {
  final String? title;
  final Color? color;
  final double size;
  final double? paddingStart;
  final double? paddingEnd;
  final double? paddingTop;
  final Color? colorDecoration;
  final double? paddindBottom;
  final List<Shadow>? listShadow;
  final double? height;
  final bool? spOff;
  final double? decorationThickness;
  final TextDecoration? decoration;
  final TextOverflow? textOverflow;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final Key? key;
  final TextAlign? textAlign;
  final int? maxLine;

    CustomTextWidget(
      {this.title,
        this.key,
      this.color = Colors.black87,
      this.size = 14,
      this.fontWeight = FontWeight.w400,
        this.paddindBottom,
        this.decoration,
        this.textOverflow,
      this.paddingStart,
        this.spOff,
        this.paddingTop,
        this.decorationThickness,
        this.height,
        this.colorDecoration,
        this.fontFamily,
        this.maxLine,
      this.paddingEnd,
      this.textAlign,this.listShadow});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
          top: paddingTop == null ? 0 : paddingTop!,
          start: paddingStart == null ? 0 : paddingStart!,
          bottom: paddindBottom == null ? 0 : paddindBottom!,
          end: paddingEnd == null ? 0 : paddingEnd!),
      child: Text(
        title!,
        overflow: textOverflow?? null,
        textAlign: textAlign ?? null,
        key: key,
        maxLines: maxLine??null,
        style: TextStyle(
          color: color,
          height: height,
          shadows:listShadow,
          decorationThickness: decorationThickness,
          decorationColor:colorDecoration ,
          fontFamily: fontFamily,
          decoration: decoration??null,
          fontWeight: fontWeight ?? null,
          fontSize:spOff!=null?spOff==true?size.sp:size:size.sp,
        ),
      ),
    );
  }
}
