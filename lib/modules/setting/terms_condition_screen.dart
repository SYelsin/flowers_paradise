import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';

import '../../utils/constants.dart';
import '../../widgets/rounded_app_bar.dart';
import 'controllers/privacy_and_term_condition_cubit/privacy_and_term_condition_cubit.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PrivacyAndTermConditionCubit>().getTermsAndConditionData();
    return Scaffold(
      appBar: RoundedAppBar(titleText: Language.termsCon.capitalizeByWord()),
      body: BlocBuilder<PrivacyAndTermConditionCubit,
          PrivacyTermConditionCubitState>(
        builder: (context, state) {
          if (state is TermConditionCubitStateLoaded) {
            final termsAndCondition = state.privacyPolicyAndTermConditionModel;
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Html(
                  data: '''
                    <table style="background-color: rgba(238, 238, 238, 0.5);">
                      ${termsAndCondition.termsAndCondition}
                    </table>
                  ''',
                  style: {
                    "tr": Style(
                      border: const Border(bottom: BorderSide(color: Colors.grey)),
                    ),
                    "th": Style(
                      // padding: const EdgeInsets.all(6),
                      backgroundColor: Colors.grey,
                    ),
                    "td": Style(
                      // padding: const EdgeInsets.all(6),
                      alignment: Alignment.topLeft,
                    ),
                    'h': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
                    'ul': Style(color: textGreyColor),
                    'p': Style(
                      color: textGreyColor,
                      textAlign: TextAlign.justify,
                    ),
                  },
                ),
              ],
            );
          } else if (state is TermConditionCubitStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TermConditionCubitStateError) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: redColor),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
