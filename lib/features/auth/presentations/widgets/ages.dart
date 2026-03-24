import 'package:e_commerce_bloc/core/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_bloc/features/auth/presentations/bloc/user_requirements/user_requirements_bloc.dart';

class Ages extends StatelessWidget {
  const Ages({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.7,
      child: BlocBuilder<UserRequirementsBloc, UserRequirementsState>(
        builder: (context, state) {
          final response = state.agesResponse;

          // Handle Initial or Loading state
          if (response == null || response.status == FetchStatus.loading) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }

          // Handle Success
          if (response.status == FetchStatus.complete &&
              response.data != null) {
            return _ages(response.data!);
          }

          // Handle Error
          if (response.status == FetchStatus.error) {
            return Container(
              alignment: Alignment.center,
              child: Text(response.message ?? 'Unknown Error'),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _ages(List<dynamic> ages) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
            context.read<UserRequirementsBloc>().add(
              SelectAgeEvent(ages[index]['value']),
            );
          },
          child: Center(
            child: Text(
              ages[index]['value'],
              style: const TextStyle(fontSize: 18),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: ages.length,
    );
  }
}
