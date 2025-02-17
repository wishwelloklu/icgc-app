// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:icgc/app/theme/app_images.dart';

class PrayerModel extends Equatable {
  final String title;
  final String prayer;
  final String imageUrl;
  const PrayerModel({
    required this.title,
    required this.prayer,
    required this.imageUrl,
  });

  PrayerModel copyWith({
    String? title,
    String? prayer,
    String? imageUrl,
  }) {
    return PrayerModel(
      title: title ?? this.title,
      prayer: prayer ?? this.prayer,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'prayer': prayer,
      'imageUrl': imageUrl,
    };
  }

  factory PrayerModel.fromMap(Map<String, dynamic> map) {
    return PrayerModel(
      title: map['title'] as String,
      prayer: map['prayer'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PrayerModel.fromJson(String source) =>
      PrayerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [title, prayer, imageUrl];

  static List<PrayerModel> mockData = [
    const PrayerModel(
      title: 'Crossover Blessings Of Increase 2022',
      imageUrl: AppImages.prayer,
      prayer: """CROSSOVER BLESSINGS OF INCREASE
2022
The Eternal God is your refuge
He will watch over you from this
First day of the year
Till the last day of the year
The Lord bless you with the
blessings of Heaven and the
Increase of the earth
Today, In the name of Jesus:
I declare the blessing of
INCREASE
over you
Increase in Knowledge
Increase in Faith
Increase in Wealth
Increase in Favour
1
On this first day of the year 2022
We place ourselves and our families under the
covering of the blood of Jesus
Through the Blood of the
Eternal Covenant
We receive
Life, health, safety,
and deliverance from the
Lord Most High
The Lord bless your home
The Lord bless your family
The Lord bless your bread and your water The
Lord bless the work of your hands
In the name of Jesus, every plan, maneuver, and
operation of the devil against your life is canceled.
2
The Lord God is your safety and protection
He will keep you safe at home
Safe on the road, in the air and on the water
The Lord will crown you with life.
He will cause your health to spring forth
By the stripes of Jesus, be healed
Healed in your blood system
Healed in your nervous system
Healed in your cells systems
Healed in your bone structure
Healed in your muscular structure
Healed in all the organs of your body
Healed in all your skin tissues
May the Eternal God satisfy you with long life
and show you His salvation
3
In 2022,
The Lord will hear you
when you call on His Name
The Grace of our Lord Jesus Christ will be
multiplied over you
Receive increase in miracles and Testimonies
Where others fall
There, the Lord will lift you up
Where others bow in shame,
There, the glory of the Lord will rise upon you
Receive the strength of the Lord
In 2022 The Lord is your refuge
The Lord is your Sun and Shield
He is your Glory all about
Receive the Lord’s covering
4
In 2022, You will Increase
Exceedingly
The Lord will multiply your seed
Until you become
a thousand times more
In the name of Jesus
Receive the Blessing of
Increased Knowledge
In 2022,
The Lord will open the
eyes of your understanding
Receive
the Spirit of Revelation
Receive
Mental Illumination
5
Receive access to
treasures of knowledge
Receive guidance by
Divine intelligence
What you don’t know will be made known to you
Receive Increased Knowledge
in 2022
In the name of Jesus
Receive the blessing Of
Increased Faith
In 2022, you will operate in
Great Faith
6
Receive
Faith to produce
evidence of things not seen
Receive
Faith to conceive
and give birth to God’s promises
Receive
Faith to remove mountains
and bring down walls of resistance
Receive
Faith to call things that be not
into existence
7
In 2022
Receive the blessing of
Increased Wealth
In 2022 the Lord will bless your labour with favour
Your fields will yield increase
You will begin to prosper and continue prospering
until you become very prosperous
Receive A creative mind
The Lord will inspire your mind with innovative
ideas
The Lord will skillfully guide your hands
Receive Divine Access
The Lord will open gates of wealth to you
You will sit at table with captains of industry
8
Receive Growth and Expansion
The Lord will enlarge the place of your tent
He will stretch your curtains
In 2022
Receive the blessing of
Increased Wealth
Receive the anointing
of Increased Favour –
In 2022, you will excel through favour
Receive Divine Selection
The Lord will set His eyes on you
To select you out of many
Receive Divine Appointment
The Lord will cause the times and seasons of 2022
to favour you
9
Receive Divine lifting
The Lord will cause your gift to bring you into
prominence
By the work of your hand,
You will be Recognized
You will be lifted up
You will be Celebrated
The Lord will set a table of honour before you
He will shine His light on you
So I declare over your life:
Increase
Multiplication
Abundance
Your life will be full and complete
10
In the name of Jesus,
The Lord your God blesses you with these
generational blessings
The Lord bless you with the blessing of Abel, your
sacrifice will find favour with God
The Lord bless you with the blessing of Noah, you
and your family will be delivered from destruction
The Lord bless you with the blessing of Abraham,
you will be great, and your name will be great
The Lord bless you with the blessing of Sarah, you
will bear fruit in your old age
The Lord bless you with the blessing of Isaac, the
Lord will make room for you
11
The Lord bless you with the blessing of Jacob, you
will prevail over the night and receive your blessing
The Lord bless you with the blessing of Joseph, you
be remembered and rewarded
The Lord bless you with the blessing of Moses, you
will be a deliverer to your people
The Lord bless you with the blessing of David, the
Lord will subdue all your enemies
The Lord bless you with the blessing of Elijah, the
Lord will answer you by fire
The Lord bless you with the blessing of Daniel, He
will shut the mouth of every lion that roars against
you
The Lord bless you with the blessing of Esther, you
will sit on the throne with kings
12
The Lord bless you with the blessing of Mary, all who
know you will call you blessed
Above all
Receive the blessing of the
Our Lord Jesus Christ
Salvation
Healing
Deliverance
Blind eyes open
Lame walk
Deaf speak
Demons cast out
Storms stilled
Walk on water
Bread multiplied
Dead raised
Resurrection power
Abundant Life
13
The Lord bless you with
Righteousness
Peace
Joy
Wisdom
Might
Power
Glory
On this first day of January 2022
You have entered a season of
God’s Increase
And Multiplication
The Lord Bless you
And keep you
The Lord make His face shine upon you
And be gracious unto you
The Lord lift up His countenance on you
And give you peace
14
The grace of our Lord Jesus Christ, the Love of God,
and the fellowship of the Holy Spirit,
Rest upon you today and throughout 2022
In Jesus, name…Amen.
15""",
    )
  ];
}
