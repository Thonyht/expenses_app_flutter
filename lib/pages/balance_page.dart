import 'dart:math';
import 'package:expenses_app/providers/providers.dart';
import 'package:expenses_app/utils/math_operations.dart';
import 'package:flutter/material.dart';

import 'package:expenses_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({Key? key}) : super(key: key);

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  final ScrollController _scrollController = ScrollController();
  double _offset = 0;

  void _listener() {
    _offset = _scrollController.offset / 100;
    //print(_max);
    setState(() {});
  }

  @override
  void initState() {
    _scrollController.addListener(_listener);
    _max;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }

  double get _max => max(90 - _offset * 90, 0.0);

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final etList = context.watch<ExpensesProvider>().etList;

    return Scaffold(
      floatingActionButton: const CustomFAB(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            elevation: 0.0,
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MonthSelector(),
                  Text(
                    getBalance(eList, etList),
                    style: const TextStyle(fontSize: 30.0, color: Colors.green),
                  ),
                  const Text(
                    'Balance',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Stack(
                children: [
                  const BackSheet(),
                  Padding(
                    padding: EdgeInsets.only(top: _max),
                    child: const FrontSheet(),
                  )
                ],
              )
            ]),
          )
        ],
      ),
    );
  }
}
