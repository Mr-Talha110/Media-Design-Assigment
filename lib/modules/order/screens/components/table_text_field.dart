import 'package:flutter/material.dart';
import 'package:media_design_assingment_app/utils/constants/app_colors.dart';
import 'package:media_design_assingment_app/utils/helping_methods/helping_methods.dart';

class TableTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final List<String>? suggestions;
  final Function(String)? onChanged;
  final FocusNode? focusNode;

  const TableTextField({
    super.key,
    required this.controller,
    this.keyboardType,
    this.textAlign,
    this.suggestions,
    this.onChanged,
    this.focusNode,
  });

  @override
  State<TableTextField> createState() => _TableTextFieldState();
}

class _TableTextFieldState extends State<TableTextField> {
  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
        controller: widget.controller,
        textAlign: widget.textAlign ?? TextAlign.right,
        keyboardType: widget.keyboardType ?? TextInputType.number,
        cursorColor: AppColors.blue,
        decoration: const InputDecoration(border: InputBorder.none),
        onTapOutside: (_) => hideKeyboard(),
      ),
    );
  }

  //HELPING METHODS TO SHOW PRODUCT SUGGESTIONS TO USER
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  List<String> _filteredSuggestions = [];

  void _showOverlay() {
    _removeOverlay();
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            left: offset.dx,
            top: offset.dy + size.height,
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: Offset(0.0, size.height + 4),
              child: Material(
                elevation: 4,
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children:
                      _filteredSuggestions.map((suggestion) {
                        return ListTile(
                          title: Text(suggestion),
                          onTap: () {
                            widget.controller.text = suggestion;
                            widget
                                .controller
                                .selection = TextSelection.fromPosition(
                              TextPosition(offset: suggestion.length),
                            );
                            _removeOverlay();
                          },
                        );
                      }).toList(),
                ),
              ),
            ),
          ),
    );

    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _onChanged() {
    final input = widget.controller.text;
    if (widget.suggestions == null || input.isEmpty) {
      _removeOverlay();
      return;
    }

    _filteredSuggestions =
        widget.suggestions!
            .where((item) => item.toLowerCase().contains(input.toLowerCase()))
            .toList();

    if (_filteredSuggestions.isNotEmpty) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    _removeOverlay();
    widget.controller.removeListener(_onChanged);
    super.dispose();
  }
}
