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
  final String name;
  final String imageUrl;
  final String avatarUrl;
  const StoryItem({required this.name, required this.imageUrl, required this.avatarUrl});
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
    StoryItem(name: 'Ahmed', imageUrl: 'https://picsum.photos/id/1011/300/500', avatarUrl: 'https://i.pravatar.cc/150?img=1'),
    StoryItem(name: 'Sara', imageUrl: 'https://picsum.photos/id/1027/300/500', avatarUrl: 'https://i.pravatar.cc/150?img=2'),
    StoryItem(name: 'Omar', imageUrl: 'https://picsum.photos/id/1005/300/500', avatarUrl: 'https://i.pravatar.cc/150?img=3'),
    StoryItem(name: 'Lina', imageUrl: 'https://picsum.photos/id/1012/300/500', avatarUrl: 'https://i.pravatar.cc/150?img=4'),
    StoryItem(name: 'Zaid', imageUrl: 'https://picsum.photos/id/1020/300/500', avatarUrl: 'https://i.pravatar.cc/150?img=5'),
    StoryItem(name: 'Mona', imageUrl: 'https://picsum.photos/id/1024/300/500', avatarUrl: 'https://i.pravatar.cc/150?img=6'),
  ];

  static const posts = [
    PostItem(
      name: 'Mark Zuckerberg',
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
      caption: 'Testing the new Aurora cameras! 🌌',
      imageUrl: 'https://picsum.photos/id/1043/800/500',
      timeAgo: '2h',
    ),
    PostItem(
      name: 'Flutter Dev',
      avatarUrl: 'https://i.pravatar.cc/150?img=68',
      caption: 'Building beautiful UIs with Flutter is so satisfying.',
      imageUrl: 'https://picsum.photos/id/1060/800/500',
      timeAgo: '4h',
    ),
    PostItem(
      name: 'Travel Enthusiast',
      avatarUrl: 'https://i.pravatar.cc/150?img=45',
      caption: 'Missing these mountain views today. 🏔️',
      imageUrl: 'https://picsum.photos/id/1015/800/500',
      timeAgo: '6h',
    ),
    PostItem(
      name: 'TungTungTung Sahur',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
      caption: 'Late night sessions working on the new project.',
      imageUrl: 'https://picsum.photos/id/1062/800/500',
      timeAgo: '8h',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          'facebook',
          style: TextStyle(
            color: Color(0xFF1877F2),
            fontWeight: FontWeight.bold,
            fontSize: 28,
            letterSpacing: -1.2,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle, color: Colors.black)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.black)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.message, color: Colors.black)),
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _StoriesRow(stories: stories);
          }
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: PostCard(post: posts[index - 1]),
          );
        },
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
      padding: const EdgeInsets.symmetric(vertical: 12),
      height: 200,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: stories.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildAddStoryCard();
          }
          final story = stories[index - 1];
          return _buildStoryCard(story);
        },
      ),
    );
  }

  Widget _buildAddStoryCard() {
    return Container(
      width: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                image: DecorationImage(
                  image: NetworkImage('https://i.pravatar.cc/150?img=11'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                const Center(
                  child: Text('Create\nStory',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                Positioned(
                  top: -15,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1877F2),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStoryCard(StoryItem story) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Image.network(story.imageUrl, width: 110, height: 200, fit: BoxFit.cover),
          Container(
            width: 110,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.3), Colors.transparent, Colors.black.withOpacity(0.6)],
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF1877F2), width: 2),
              ),
              child: CircleAvatar(radius: 16, backgroundImage: NetworkImage(story.avatarUrl)),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Text(
              story.name,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
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
  bool _starred = false;

  /// Star Renderer that takes a rating and returns a Row of stars
  /// It uses the requested for loop logic
  Widget starRenderer(int starRating, {double size = 16}) {
    List<Widget> stars = [];

    // Loop to build a total of 5 stars
    for (int x = 1; x <= 5; x++) {
      stars.add(
        Icon(
          // Use filled star if loop index is less than or equal to rating
          x <= starRating ? Icons.star : Icons.star_border,
          size: size,
          color: Colors.amber,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(post.avatarUrl)),
            title: Row(
              children: [
                Text(post.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 6),
                // Example: Passes a rating of 5 for specific users
                if (post.name == 'Mark Zuckerberg') starRenderer(5),
              ],
            ),
            subtitle: Text('${post.timeAgo} • 🌎'),
            trailing: const Icon(Icons.more_horiz),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(post.caption),
          ),
          Image.network(post.imageUrl, fit: BoxFit.cover, width: double.infinity),
          const Divider(height: 1),
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
                  icon: _starred ? Icons.star : Icons.star_border,
                  label: 'Star',
                  color: _starred ? Colors.amber.shade700 : Colors.grey.shade700,
                  onTap: () => setState(() => _starred = !_starred),
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

/// ---------- ACTION BUTTON ----------

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
            const SizedBox(width: 4),
            Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}