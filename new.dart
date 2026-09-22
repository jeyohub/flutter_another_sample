import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LatestScrollView(),
  ));
}

class LatestScrollView extends StatefulWidget {
  const LatestScrollView({super.key});

  @override
  State<LatestScrollView> createState() => _LatestScrollViewState();
}

class _LatestScrollViewState extends State<LatestScrollView> {
  // --- EXPANDED STORY DATA (Scroll to Right) ---
  final List<StoryItem> _stories = [
    StoryItem(name: 'Your Story', imageUrl: 'https://i.pravatar.cc/150?img=11'),
    StoryItem(name: 'Ahmed', imageUrl: 'https://picsum.photos/id/1011/300/500'),
    StoryItem(name: 'Sara', imageUrl: 'https://picsum.photos/id/1027/300/500'),
    StoryItem(name: 'Omar', imageUrl: 'https://picsum.photos/id/1005/300/500'),
    StoryItem(name: 'Lina', imageUrl: 'https://picsum.photos/id/1012/300/500'),
    StoryItem(name: 'Zaid', imageUrl: 'https://picsum.photos/id/1020/300/500'),
    StoryItem(name: 'Mona', imageUrl: 'https://picsum.photos/id/1024/300/500'),
    StoryItem(name: 'Hassan', imageUrl: 'https://picsum.photos/id/1001/300/500'),
  ];

  // --- EXPANDED POST DATA (Scroll Down) ---
  final List<PostItem> _posts = [
    PostItem(
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
      name: 'Mark Zuckerberg',
      time: '2 h',
      caption: 'Building the future of connection! 🚀',
      imageUrl: 'https://picsum.photos/id/1043/800/500',
    ),
    PostItem(
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
      name: 'Batimma',
      time: '3 h',
      caption: 'Check out this amazing view from my trip.',
      imageUrl: 'https://picsum.photos/id/1015/800/500',
    ),
    PostItem(
      avatarUrl: 'https://i.pravatar.cc/150?img=68',
      name: 'TungTung Sahur Crew',
      time: '5 h',
      caption: 'Preparing for the big event tomorrow! #Community',
      imageUrl: 'https://picsum.photos/id/1060/800/500',
    ),
    PostItem(
      avatarUrl: 'https://i.pravatar.cc/150?img=45',
      name: 'Jane Smith',
      time: '1 d',
      caption: 'A quiet morning in the park. 🌳',
      imageUrl: 'https://picsum.photos/id/1062/800/500',
    ),
    PostItem(
      avatarUrl: 'https://i.pravatar.cc/150?img=32',
      name: 'Traveler Joe',
      time: '2 d',
      caption: 'Finally reached the summit!',
      imageUrl: 'https://picsum.photos/id/1016/800/500',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'facebook',
          style: TextStyle(
            color: Color(0xFF1877F2),
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.2,
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search, color: Colors.black87), onPressed: () {}),
          IconButton(icon: const Icon(Icons.chat, color: Colors.black87), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemCount: _posts.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) return _buildStoriesSection();
          return PostCard(post: _posts[index - 1]);
        },
      ),
    );
  }

  Widget _buildStoriesSection() {
    return Container(
      height: 190,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Enables scrolling to the right
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        itemCount: _stories.length,
        itemBuilder: (context, index) {
          final story = _stories[index];
          return Container(
            width: 110,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      story.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                          stops: const [0.6, 1.0],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8, left: 8, right: 8,
                    child: Text(
                      story.name,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final PostItem post;
  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _localLiked = false;

  @override
  void initState() {
    super.initState();
    _localLiked = widget.post.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(post.avatarUrl)),
            title: Text(post.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${post.time} • 🌎'),
            trailing: const Icon(Icons.more_horiz),
          ),
          // FIXED: Used EdgeInsets.only to support horizontal and bottom padding
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
            child: Text(post.caption, style: const TextStyle(fontSize: 15)),
          ),
          Image.network(post.imageUrl, width: double.infinity, fit: BoxFit.cover),
          const Divider(height: 1, thickness: 0.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ActionButton(
                icon: _localLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                label: 'Like',
                color: _localLiked ? const Color(0xFF1877F2) : Colors.grey[700]!,
                onTap: () {
                  setState(() {
                    _localLiked = !_localLiked;
                    post.isLiked = _localLiked;
                  });
                },
              ),
              _ActionButton(icon: Icons.mode_comment_outlined, label: 'Comment', color: Colors.grey[700]!, onTap: () {}),
              _ActionButton(icon: Icons.share_outlined, label: 'Share', color: Colors.grey[700]!, onTap: () {}),
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

  const _ActionButton({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: 6),
              Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}

class StoryItem {
  final String name;
  final String imageUrl;
  StoryItem({required this.name, required this.imageUrl});
}

class PostItem {
  final String avatarUrl;
  final String name;
  final String time;
  final String caption;
  final String imageUrl;
  bool isLiked;

  PostItem({
    required this.avatarUrl,
    required this.name,
    required this.time,
    required this.caption,
    required this.imageUrl,
    this.isLiked = false,
  });
}