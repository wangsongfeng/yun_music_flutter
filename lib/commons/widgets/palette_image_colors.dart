import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

const Color _kBackgroundColor = Color(0xffa0a0a0);
const Color _kSelectionRectangleBackground = Color(0x15000000);
const Color _kSelectionRectangleBorder = Color(0x80000000);
const Color _kPlaceholderColor = Color(0x80404040);

class ImageColors extends StatefulWidget {
  /// Creates the home page.
  const ImageColors({
    super.key,
    this.title,
    required this.image,
    this.imageSize,
  });

  /// The title that is shown at the top of the page.
  final String? title;

  /// This is the image provider that is used to load the colors from.
  final ImageProvider image;

  /// The dimensions of the image.
  final Size? imageSize;

  @override
  State<ImageColors> createState() => _ImageColorsState();
}

class _ImageColorsState extends State<ImageColors> {
  Rect? region;
  Rect? dragRegion;
  Offset? startDrag;
  Offset? currentDrag;
  PaletteGenerator? paletteGenerator;

  final GlobalKey imageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.imageSize != null) {
      region = Offset.zero & widget.imageSize!;
    }
    _updatePaletteGenerator(region);
  }

  Future<void> _updatePaletteGenerator(Rect? newRegion) async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      widget.image,
      size: widget.imageSize,
      region: newRegion,
      maximumColorCount: 20,
    );
    setState(() {});
  }

  // Called when the user starts to drag
  void _onPanDown(DragDownDetails details) {
    final RenderBox box =
        imageKey.currentContext!.findRenderObject()! as RenderBox;
    final Offset localPosition = box.globalToLocal(details.globalPosition);
    setState(() {
      startDrag = localPosition;
      currentDrag = localPosition;
      dragRegion = Rect.fromPoints(localPosition, localPosition);
    });
  }

  // Called as the user drags: just updates the region, not the colors.
  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      currentDrag = currentDrag! + details.delta;
      dragRegion = Rect.fromPoints(startDrag!, currentDrag!);
    });
  }

  // Called if the drag is canceled (e.g. by rotating the device or switching
  // apps)
  void _onPanCancel() {
    setState(() {
      dragRegion = null;
      startDrag = null;
    });
  }

  // Called when the drag ends. Sets the region, and updates the colors.
  Future<void> _onPanEnd(DragEndDetails details) async {
    final Size? imageSize = imageKey.currentContext?.size;
    Rect? newRegion;

    if (imageSize != null) {
      newRegion = (Offset.zero & imageSize).intersect(dragRegion!);
      if (newRegion.size.width < 4 && newRegion.size.width < 4) {
        newRegion = Offset.zero & imageSize;
      }
    }

    await _updatePaletteGenerator(newRegion);
    setState(() {
      region = newRegion;
      dragRegion = null;
      startDrag = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBackgroundColor,
      appBar: AppBar(
        title: Text(widget.title ?? ''),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            // GestureDetector is used to handle the selection rectangle.
            child: GestureDetector(
              onPanDown: _onPanDown,
              onPanUpdate: _onPanUpdate,
              onPanCancel: _onPanCancel,
              onPanEnd: _onPanEnd,
              child: Stack(children: <Widget>[
                Image(
                  key: imageKey,
                  image: widget.image,
                  width: widget.imageSize?.width,
                  height: widget.imageSize?.height,
                ),
                // This is the selection rectangle.
                Positioned.fromRect(
                    rect: dragRegion ?? region ?? Rect.zero,
                    child: Container(
                      decoration: BoxDecoration(
                          color: _kSelectionRectangleBackground,
                          border: Border.all(
                            color: _kSelectionRectangleBorder,
                          )),
                    )),
              ]),
            ),
          ),
          // Use a FutureBuilder so that the palettes will be displayed when
          // the palette generator is done generating its data.
        ],
      ),
    );
  }
}
