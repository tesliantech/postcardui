import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  @override
  CardScreenState createState() => CardScreenState();
}

class CardScreenState extends State<CardScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  late AnimationController _postsController;
  late Animation<int> _postsAnimation;

  late AnimationController _followersController;
  late Animation<int> _followersAnimation;

  late AnimationController _followingController;
  late Animation<int> _followingAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat(reverse: true);

    _postsController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _postsAnimation = IntTween(begin: 0, end: 45).animate(_postsController);
    _postsController.forward();

    _followersController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _followersAnimation =
        IntTween(begin: 0, end: 100).animate(_followersController);
    _followersController.forward();

    _followingController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _followingAnimation =
        IntTween(begin: 0, end: 50).animate(_followingController);
    _followingController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _postsController.dispose();
    _followersController.dispose();
    _followingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Card Style'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: child,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            width: 300.0,
            height: 400.0,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://i.postimg.cc/KYL4w92z/Beauty-Plus-20240920135245822-save.jpg",
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  child: CustomPaint(
                    painter: CustomContainerShapeBorder(
                      height: 100.0,
                      width: 300.0,
                      radius: 50.0,
                      fillColor: Theme.of(context).cardColor,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 18.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AnimatedBuilder(
                        animation: _postsAnimation,
                        builder: (context, child) {
                          return cardAppButton(
                              post: '${_postsAnimation.value}',
                              postTitle: 'Posts');
                        },
                      ),
                      SizedBox(width: 8),
                      AnimatedBuilder(
                        animation: _followersAnimation,
                        builder: (context, child) {
                          return cardAppButton(
                              post: '${_followersAnimation.value}',
                              postTitle: 'Followers');
                        },
                      ),
                      SizedBox(width: 8),
                      AnimatedBuilder(
                        animation: _followingAnimation,
                        builder: (context, child) {
                          return cardAppButton(
                              post: '${_followingAnimation.value}',
                              postTitle: 'Following');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget cardAppButton({required String post, required String postTitle}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 5,
    ),
    onPressed: () {},
    child: Column(
      children: [
        Text(post, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(postTitle, style: TextStyle(color: Colors.grey)),
      ],
    ),
  );
}

class CustomContainerShapeBorder extends CustomPainter {
  final double height;
  final double width;
  final Color fillColor;
  final double radius;

  CustomContainerShapeBorder({
    required this.height,
    required this.width,
    required this.fillColor,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(0.0, -radius);
    path.lineTo(0.0, -(height - radius));
    path.conicTo(0.0, -height, radius, -height, 1);
    path.lineTo(width - radius, -height);
    path.conicTo(width, -height, width, -(height + radius), 1);
    path.lineTo(width, -(height - radius));
    path.lineTo(width, -radius);
    path.conicTo(width, 0.0, width - radius, 0.0, 1);
    path.lineTo(radius, 0.0);
    path.conicTo(0.0, 0.0, 0.0, -radius, 1);
    path.close();
    canvas.drawPath(path, Paint()..color = fillColor);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
