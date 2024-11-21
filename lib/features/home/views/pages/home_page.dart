import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';
import 'package:news_app/features/home/views/widgets/custom_carousel_slider.dart';
import 'package:news_app/features/home/views/widgets/title_headline_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeCubit = HomeCubit();
        homeCubit.getTopHeadlines();
        return homeCubit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Builder(builder: (context) {
          final homeCubit = BlocProvider.of<HomeCubit>(context);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  TitleHeadlineWidget(
                    title: 'Breaking News',
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 280,
                    child: BlocBuilder<HomeCubit, HomeState>(
                      bloc: homeCubit,
                      buildWhen: (previous, current) =>
                          current is TopHeadlinesLoading ||
                          current is TopHeadlinesLoaded ||
                          current is TopHeadlinesError,
                      builder: (context, state) {
                        if (state is TopHeadlinesLoading) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else if (state is TopHeadlinesLoaded) {
                          final articles = state.articles;
                          return CustomCarouselSlider(
                            articles: articles ?? [],
                          );
                        } else if (state is TopHeadlinesError) {
                          return Center(
                            child: Text(state.message),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  TitleHeadlineWidget(
                    title: 'Recommendation',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
