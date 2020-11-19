import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:netflix/cubits/cubits.dart';
import 'package:netflix/data/data.dart';
import 'package:netflix/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  // PageStorageKey key 를 보내면 현재 다른 화면으로 갔다 와도 현재 스크롤 위치를 기억함
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        // app_bar_cubit.dart 를 이용해서 앱 화면의 스크롤 조정 하는 부분. 좀더 분석 필요함
        context.bloc<AppBarCubit>().setOffset(_scrollController.offset);
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[850],
        child: const Icon(Icons.cast),
        onPressed: () => print('Cast'),
      ),
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50.0),
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrollOffset) {
            return CustomAppBar(
              scrollOffset: scrollOffset,
            );
          }
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(featuredContent: sintelContent),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: Previews(
                key : PageStorageKey('previews'),
                title: 'Previews',
                contentList: previews,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              key : PageStorageKey('myList'),
              title: 'My List',
              contentList : myList,
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              key : PageStorageKey('originals'),
              title: 'Netflix Originals',
              contentList : originals,
              isOriginals:true,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
              child: ContentList(
                key : PageStorageKey('trending'),
                title: 'Trending',
                contentList : trending,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
