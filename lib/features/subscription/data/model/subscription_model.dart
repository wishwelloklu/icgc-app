// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SubscriptionModel extends Equatable {
  final UniqueKey id = UniqueKey();
  final String title;
  final String amount;
  final String rate;
  final List<String> benefits;
  SubscriptionModel({
    required this.title,
    required this.amount,
    required this.rate,
    required this.benefits,
  });

  @override
  List<Object> get props => [title, amount, rate, benefits];

  static List<SubscriptionModel> subList = [
    SubscriptionModel(
      title: 'Starter',
      amount: '100',
      rate: 'monthly',
      benefits: const [
        'Unlimited access to all books',
        'Offerings',
        'More Offerings',
      ],
    ),
     SubscriptionModel(
      title: 'Standard',
      amount: '200',
      rate: 'Quarterly',
      benefits: const [
        'Unlimited access to all books',
        'Offerings',
        'More Offerings',
      ],
    ),
     SubscriptionModel(
      title: 'Premium',
      amount: '500',
      rate: 'Yearly',
      benefits: const [
        'Unlimited access to all books',
        'Offerings',
        'More Offerings',
      ],
    ),
  ];
}
