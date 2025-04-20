import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildSummaryCard(
            title: 'Total Budget',
            amount: 'Rp. 1,200,000',
            icon: Icons.account_balance_wallet,
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          _buildSummaryCard(
            title: 'Expenses',
            amount: 'Rp. 350,000',
            icon: Icons.shopping_cart,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          _buildSummaryCard(
            title: 'Remaining',
            amount: 'Rp. 850,000',
            icon: Icons.savings,
            color: Colors.green,
          ),
          const SizedBox(height: 24),
          const Text(
            'Recent Expenses',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildExpenseListItem(
            category: 'Breakfast',
            amount: 'Rp. 15,000',
            date: '18 Apr 2025',
          ),
          _buildExpenseListItem(
            category: 'Lunch',
            amount: 'Rp. 25,000',
            date: '18 Apr 2025',
          ),
          _buildExpenseListItem(
            category: 'Transport',
            amount: 'Rp. 10,000',
            date: '18 Apr 2025',
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String amount,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    amount,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseListItem({
    required String category,
    required String amount,
    required String date,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.receipt),
        ),
        title: Text(category),
        subtitle: Text(date),
        trailing: Text(
          amount,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}