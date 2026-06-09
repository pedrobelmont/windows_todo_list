import 'package:flutter/material.dart';

class SubTaskInputRow extends StatefulWidget {
  final Function(String) onAdd;

  const SubTaskInputRow({super.key, required this.onAdd});

  @override
  State<SubTaskInputRow> createState() => _SubTaskInputRowState();
}

class _SubTaskInputRowState extends State<SubTaskInputRow> {
  final TextEditingController _controller = TextEditingController();

  void _submit() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onAdd(text);
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28.0, top: 4.0, bottom: 4.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white, fontSize: 11),
              decoration: InputDecoration(
                hintText: 'Nova subtarefa...',
                hintStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 0.3),
                  fontSize: 11,
                ),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 8,
                ),
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _submit(),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add_rounded,
              color: Colors.white.withValues(alpha: 0.5),
              size: 16,
            ),
            onPressed: _submit,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 22, minHeight: 22),
          ),
        ],
      ),
    );
  }
}
