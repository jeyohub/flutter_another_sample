import 'package:flutter/material.dart';

void main() => runApp(const FacebookImitationApp());

class FacebookImitationApp extends StatelessWidget {
  const FacebookImitationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Facebook Imitation',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF0F2F5),
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1877F2)),
      ),
      home: const FeedScreen(),
    );
  }
}

/// ---------- MODELS ----------

class StoryItem {
  final String imageUrl;
  const StoryItem(this.imageUrl);
}

class PostItem {
  final String name;
  final String avatarUrl;
  final String caption;
  final String imageUrl;
  final String timeAgo;

  const PostItem({
    required this.name,
    required this.avatarUrl,
    required this.caption,
    required this.imageUrl,
    this.timeAgo = 'Just now',
  });
}

/// ---------- SCREEN ----------

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  static const stories = [
    StoryItem('https://picsum.photos/id/1015/300/500'),
    StoryItem('https://picsum.photos/id/1018/300/500'),
    StoryItem('https://picsum.photos/id/1016/300/500'),
  ];

  static const posts = [
    PostItem(
      name: 'Mark Zuckerberg',
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
      caption: 'What a beautiful night sky',
      imageUrl: 'https://picsum.photos/id/1043/800/500', // aurora-style placeholder
      timeAgo: '2h',
    ),
    PostItem(
      name: 'TungTungTung Sahur',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
      caption: 'My beloved Ballerina',
      imageUrl: 'https://picsum.photos/id/1062/800/500',
      timeAgo: '5h',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        titleSpacing: 16,
        title: const Text(
          'Facebook Imitation',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFFE4E6EB),
              child: Icon(Icons.search, color: Colors.black87, size: 18),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFFE4E6EB),
              child: Icon(Icons.notifications_none, color: Colors.black87, size: 18),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _StoriesRow(stories: stories),
          const SizedBox(height: 8),
          ...posts.map((p) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: PostCard(post: p),
          )),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

/// ---------- STORIES ROW ----------

class _StoriesRow extends StatelessWidget {
  final List<StoryItem> stories;
  const _StoriesRow({required this.stories});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: 150,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                Image.network(
                  stories[index].imageUrl,
                  width: 110,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// ---------- POST CARD ----------

class PostCard extends StatefulWidget {
  final PostItem post;
  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(post.avatarUrl),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        post.timeAgo,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.more_horiz, color: Colors.grey.shade700),
              ],
            ),
          ),

          // Caption
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              post.caption,
              style: const TextStyle(fontSize: 14.5, height: 1.3),
            ),
          ),
          const SizedBox(height: 8),

          // Image
          AspectRatio(
            aspectRatio: 16 / 10,
            child: Image.network(
              post.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),

          // Reaction summary
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1877F2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.thumb_up, color: Colors.white, size: 10),
                ),
                const SizedBox(width: 6),
                Text(
                  '128',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
                const Spacer(),
                Text(
                  '12 comments',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Actions
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  icon: _liked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  label: 'Like',
                  color: _liked ? const Color(0xFF1877F2) : Colors.grey.shade700,
                  onTap: () => setState(() => _liked = !_liked),
                ),
              ),
              Expanded(
                child: _ActionButton(
                  icon: Icons.mode_comment_outlined,
                  label: 'Comment',
                  color: Colors.grey.shade700,
                  onTap: () {},
                ),
              ),
              Expanded(
                child: _ActionButton(
                  icon: Icons.share_outlined,
                  label: 'Share',
                  color: Colors.grey.shade700,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 13.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}