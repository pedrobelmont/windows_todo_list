import 'package:flutter/material.dart';

class TabRow extends StatelessWidget {
  final String activeTab;
  final Function(String) onTabChanged;

  const TabRow({super.key, required this.activeTab, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton(
              tabId: 'tarefas',
              icon: Icons.checklist_rtl_rounded,
              label: 'Tarefas',
            ),
          ),
          Expanded(
            child: _buildTabButton(
              tabId: 'timer',
              icon: Icons.timer_rounded,
              label: 'Foco',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({required String tabId, required IconData icon, required String label}) {
    final isActive = activeTab == tabId;
    return GestureDetector(
      onTap: () => onTabChanged(tabId),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withValues(alpha: 0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.5),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.5),
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
