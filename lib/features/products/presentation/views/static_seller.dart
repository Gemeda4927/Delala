import 'package:flutter/material.dart';

class StaticSeller {
  static UserEntity get seller => UserEntity(
        id: 'seller_001',
        name: 'Gemeda T',
        profilePicture: 'https://example.com/gemeda-t-logo.jpg',
        rating: 4.9,
        reviewCount: 2543,
        responseTime: 'Within 1 hour',
        isVerified: true,
        joinedDate: 'Member since 2018',
        productsSold: 12500,
        chatResponseRate: '98%',
        shippingOnTime: '99%',
        followers: 42500,
        categories: ['Fashion', 'Accessories', 'Luxury Items'],
        bio:
            'Your premier destination for high-quality fashion items and accessories. Authenticity guaranteed with fast, reliable shipping!',
      );
}

class UserEntity {
  final String id;
  final String name;
  final String? profilePicture;
  final double rating;
  final int reviewCount;
  final String responseTime;
  final bool isVerified;
  final String joinedDate;
  final int productsSold;
  final String chatResponseRate;
  final String shippingOnTime;
  final int followers;
  final List<String> categories;
  final String bio;

  const UserEntity({
    required this.id,
    required this.name,
    this.profilePicture,
    required this.rating,
    required this.reviewCount,
    required this.responseTime,
    this.isVerified = false,
    this.joinedDate = '',
    this.productsSold = 0,
    this.chatResponseRate = '',
    this.shippingOnTime = '',
    this.followers = 0,
    this.categories = const [],
    this.bio = '',
  });

  Widget buildSellerCard(BuildContext context, ThemeData theme) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSellerHeader(theme),
              const SizedBox(height: 20),
              Text(
                bio,
                style: TextStyle(
                  fontSize: 15,
                  color: theme.textTheme.bodyLarge?.color,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              _buildCategories(theme),
              const SizedBox(height: 20),
              _buildStats(theme),
              const SizedBox(height: 20),
              _buildActionButtons(context, theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSellerHeader(ThemeData theme) {
    return Row(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: profilePicture != null
              ? NetworkImage(profilePicture!)
              : const NetworkImage('https://via.placeholder.com/150'),
          backgroundColor: Colors.grey[200],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isVerified) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.blue[600],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    '$rating ($reviewCount reviews)',
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.hintColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.access_time_filled_rounded,
                      size: 16, color: Colors.green),
                  const SizedBox(width: 4),
                  Text(
                    'Responds $responseTime',
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.hintColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategories(ThemeData theme) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: categories
            .map(
              (category) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Chip(
                  label: Text(category),
                  backgroundColor: theme.primaryColor.withOpacity(0.1),
                  labelStyle: TextStyle(color: theme.primaryColor),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildStats(ThemeData theme) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(Icons.shopping_bag_outlined, '$productsSold+', 'Sold'),
          VerticalDivider(color: Colors.grey[400], thickness: 1),
          _buildStatItem(Icons.timer_outlined, shippingOnTime, 'On-Time'),
          VerticalDivider(color: Colors.grey[400], thickness: 1),
          _buildStatItem(Icons.group_outlined, '$followers', 'Followers'),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 26, color: Colors.blueGrey),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: AnimatedScaleButton(
            icon: Icons.favorite_outline,
            label: 'Follow',
            isOutline: true,
            theme: theme,
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AnimatedScaleButton(
            icon: Icons.chat_outlined,
            label: 'Chat Now',
            isOutline: false,
            theme: theme,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(seller: this),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AnimatedScaleButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isOutline;
  final ThemeData theme;
  final VoidCallback onPressed;

  const AnimatedScaleButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isOutline,
    required this.theme,
    required this.onPressed,
  });

  @override
  State<AnimatedScaleButton> createState() => _AnimatedScaleButtonState();
}

class _AnimatedScaleButtonState extends State<AnimatedScaleButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        child: widget.isOutline
            ? OutlinedButton.icon(
                icon: Icon(widget.icon, size: 20),
                label: Text(widget.label),
                style: OutlinedButton.styleFrom(
                  foregroundColor: widget.theme.primaryColor,
                  side: BorderSide(color: widget.theme.primaryColor),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: widget.onPressed,
              )
            : ElevatedButton.icon(
                icon: Icon(widget.icon, size: 20),
                label: Text(widget.label),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: widget.theme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: widget.onPressed,
              ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final UserEntity seller;

  const ChatScreen({super.key, required this.seller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor.withOpacity(0.1),
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: seller.profilePicture != null
                  ? NetworkImage(seller.profilePicture!)
                  : const NetworkImage('https://via.placeholder.com/150'),
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                children: [
                  Text('Chat with ${seller.name}',
                      overflow: TextOverflow.ellipsis),
                  if (seller.isVerified) ...[
                    const SizedBox(width: 4),
                    Icon(Icons.verified, color: Colors.blue[600], size: 16),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                Center(
                  child: Text(
                    'Start your conversation here!',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          _buildMessageInput(theme),
        ],
      ),
    );
  }

  Widget _buildMessageInput(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type your message...',
                filled: true,
                fillColor: theme.brightness == Brightness.dark
                    ? Colors.grey[800]
                    : Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            mini: true,
            backgroundColor: theme.primaryColor,
            onPressed: () {},
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
