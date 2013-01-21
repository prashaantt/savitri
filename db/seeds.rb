# encoding: utf-8
# Autogenerated by the db:seed:dump task
# Do not hesitate to tweak this to your needs

Book.create([
  { :no => 1, :name => "The Book of Beginnings", :description => "", :created_at => "2012-10-10 07:52:17", :updated_at => "2012-10-10 07:52:17" },
  { :no => 2, :name => "The Book of the Traveller of the Worlds", :description => "", :created_at => "2012-10-10 07:57:48", :updated_at => "2012-10-10 07:57:48" },
  { :no => 3, :name => "The Book of the Divine Mother", :description => "", :created_at => "2012-10-10 07:58:04", :updated_at => "2012-10-10 07:58:04" },
  { :no => 4, :name => "The Book of Birth and Quest", :description => "", :created_at => "2012-10-10 07:58:19", :updated_at => "2012-10-10 07:58:19" },
  { :no => 5, :name => "The Book of Love", :description => "", :created_at => "2012-10-10 07:58:30", :updated_at => "2012-10-10 07:58:30" },
  { :no => 6, :name => "The Book of Fate", :description => "", :created_at => "2012-10-10 07:58:40", :updated_at => "2012-10-10 07:58:40" },
  { :no => 7, :name => "The Book of Yoga", :description => "", :created_at => "2012-10-10 07:58:51", :updated_at => "2012-10-10 07:58:51" },
  { :no => 8, :name => "The Book of Death", :description => "", :created_at => "2012-10-10 07:59:01", :updated_at => "2012-10-10 07:59:01" },
  { :no => 9, :name => "The Book of Eternal Night", :description => "", :created_at => "2012-10-10 07:59:11", :updated_at => "2012-10-10 07:59:11" },
  { :no => 10, :name => "The Book of the Double Twilight", :description => "", :created_at => "2012-10-10 07:59:24", :updated_at => "2012-10-10 07:59:24" },
  { :no => 11, :name => "The Book of Everlasting Day", :description => "", :created_at => "2012-10-10 07:59:35", :updated_at => "2012-10-10 07:59:35" },
  { :no => 12, :name => "Epilogue", :description => "", :created_at => "2012-10-10 07:59:47", :updated_at => "2012-10-10 07:59:47" }
], :without_protection => true )



Canto.create([
  { :cantono => 1, :title => "The Symbol Dawn", :description => "", :created_at => "2012-09-28 14:43:12", :updated_at => "2012-09-28 14:43:12", :book_id => 1 },
  { :cantono => 2, :title => "The Issue", :description => "", :created_at => "2012-09-28 14:43:22", :updated_at => "2012-09-28 14:43:22", :book_id => 1 },
  { :cantono => 3, :title => "The Yoga of the King: The Yoga of the Soul’s Release", :description => "", :created_at => "2012-09-28 14:43:35", :updated_at => "2012-09-28 14:43:35", :book_id => 1 },
  { :cantono => 4, :title => "The Secret Knowledge", :description => "", :created_at => "2012-10-10 12:56:31", :updated_at => "2012-10-10 12:56:31", :book_id => 1 }
], :without_protection => true )



Comment.create([
  { :commenter => "NM", :body => "Wonderful Blog Post", :post_id => 1, :created_at => "2012-09-28 15:12:48", :updated_at => "2012-09-28 15:12:48", :user_id => 1 }
  ], :without_protection => true )

Line.create([
  { :line => "It was the hour before the Gods awake.", :no => 1, :created_at => "2012-09-28 14:45:47", :updated_at => "2012-09-28 14:45:47", :stanza_id => 1 },
  { :line => "Across the path of the divine Event", :no => 2, :created_at => "2012-09-28 14:48:14", :updated_at => "2012-09-28 14:48:14",  :stanza_id => 2 },
  { :line => "The huge foreboding mind of Night, alone", :no => 3, :created_at => "2012-09-28 14:55:41", :updated_at => "2012-09-28 14:55:41",  :stanza_id => 2 },
  { :line => "In her unlit temple of eternity,", :no => 4, :created_at => "2012-09-28 14:56:00", :updated_at => "2012-09-28 14:56:00",  :stanza_id => 2 },
  { :line => "Lay stretched immobile upon Silence’ marge.", :no => 5, :created_at => "2012-09-28 14:56:16", :updated_at => "2012-09-28 14:56:16",  :stanza_id => 2 },
  { :line => "Almost one felt, opaque, impenetrable,", :no => 6, :created_at => "2012-09-28 14:56:32", :updated_at => "2012-09-28 14:56:32",  :stanza_id => 2 },
  { :line => "In the sombre symbol of her eyeless muse", :no => 7, :created_at => "2012-09-28 14:56:48", :updated_at => "2012-09-28 14:56:48",  :stanza_id => 3 },
  { :line => "The abysm of the unbodied Infinite;", :no => 8, :created_at => "2012-09-28 14:57:05", :updated_at => "2012-09-28 14:57:05",  :stanza_id => 3 },
  { :line => "A fathomless zero occupied the world.", :no => 9, :created_at => "2012-09-28 14:57:28", :updated_at => "2012-09-28 14:57:28",  :stanza_id => 3 },
  { :line => "A power of fallen boundless self awake", :no => 10, :created_at => "2012-09-28 14:57:50", :updated_at => "2012-09-28 14:57:50",  :stanza_id => 4 },
  { :line => "Between the first and the last Nothingness,", :no => 11, :created_at => "2012-09-28 14:58:06", :updated_at => "2012-10-08 11:31:43",  :stanza_id => 4 },
  { :line => "Recalling the tenebrous womb from which it came,", :no => 12, :created_at => "2012-09-28 14:58:24", :updated_at => "2012-09-28 14:58:24",  :stanza_id => 4 },
  { :line => "Turned from the insoluble mystery of birth", :no => 13, :created_at => "2012-09-28 14:58:39", :updated_at => "2012-09-28 14:58:39",  :stanza_id => 4 },
  { :line => "And the tardy process of mortality", :no => 14, :created_at => "2012-09-28 14:58:55", :updated_at => "2012-09-28 14:58:55",  :stanza_id => 4 },
  { :line => "And longed to reach its end in vacant Nought.", :no => 15, :created_at => "2012-09-28 14:59:20", :updated_at => "2012-09-28 14:59:20",  :stanza_id => 4 },
  { :line => "As in a dark beginning of all things,", :no => 16, :created_at => "2012-10-04 11:02:23", :updated_at => "2012-10-04 11:02:23",  :stanza_id => 5 },
  { :line => "A mute featureless semblance of the Unknown", :no => 17, :created_at => "2012-10-04 11:02:55", :updated_at => "2012-10-04 11:02:55",  :stanza_id => 5 },
  { :line => "Repeating for ever the unconscious act,", :no => 18, :created_at => "2012-10-04 11:03:14", :updated_at => "2012-10-04 11:03:14",  :stanza_id => 5 },
  { :line => "Prolonging for ever the unseeing will,", :no => 19, :created_at => "2012-10-04 11:03:32", :updated_at => "2012-10-04 11:03:32",  :stanza_id => 5 },
  { :line => "Cradled the cosmic drowse of ignorant Force", :no => 20, :created_at => "2012-10-04 11:03:49", :updated_at => "2012-10-04 11:03:49",  :stanza_id => 5 },
  { :line => "Whose moved creative slumber kindles the suns", :no => 21, :created_at => "2012-10-04 11:04:05", :updated_at => "2012-10-04 11:04:05",  :stanza_id => 5 },
  { :line => "And carries our lives in its somnambulist whirl.", :no => 22, :created_at => "2012-10-04 11:04:21", :updated_at => "2012-10-04 11:04:21",  :stanza_id => 5 },
  { :line => "Athwart the vain enormous trance of Space,", :no => 23, :created_at => "2012-10-04 11:06:05", :updated_at => "2012-10-04 11:06:05",  :stanza_id => 6 },
  { :line => "Its formless stupor without mind or life,", :no => 24, :created_at => "2012-10-04 11:06:24", :updated_at => "2012-10-04 11:06:24",  :stanza_id => 6 },
  { :line => "A shadow spinning through a soulless Void,", :no => 25, :created_at => "2012-10-04 11:06:43", :updated_at => "2012-10-04 11:06:43",  :stanza_id => 6 },
  { :line => "Thrown back once more into unthinking dreams,", :no => 26, :created_at => "2012-10-04 11:06:57", :updated_at => "2012-10-04 11:06:57",  :stanza_id => 6 },
  { :line => "Earth wheeled abandoned in the hollow gulfs", :no => 27, :created_at => "2012-10-04 11:07:18", :updated_at => "2012-10-04 11:07:18",  :stanza_id => 6 },
  { :line => "Forgetful of her spirit and her fate.", :no => 28, :created_at => "2012-10-04 11:07:36", :updated_at => "2012-10-04 11:07:36",  :stanza_id => 6 },
  { :line => "The impassive skies were neutral, empty, still.", :no => 29, :created_at => "2012-10-04 11:13:12", :updated_at => "2012-10-04 11:13:12",  :stanza_id => 7 },
  { :line => "Then something in the inscrutable darkness stirred;", :no => 30, :created_at => "2012-10-04 11:13:43", :updated_at => "2012-10-04 11:13:43",  :stanza_id => 8 },
  { :line => "A nameless movement, an unthought Idea", :no => 31, :created_at => "2012-10-04 11:14:05", :updated_at => "2012-10-04 11:14:05",  :stanza_id => 8 },
  { :line => "Insistent, dissatisfied, without an aim,", :no => 32, :created_at => "2012-10-04 11:14:28", :updated_at => "2012-10-04 11:14:28",  :stanza_id => 8 },
  { :line => "Something that wished but knew not how to be,", :no => 33, :created_at => "2012-10-04 11:14:48", :updated_at => "2012-10-04 11:14:48",  :stanza_id => 8 },
  { :line => "Teased the Inconscient to wake Ignorance.", :no => 34, :created_at => "2012-10-04 11:15:07", :updated_at => "2012-10-04 11:15:07",  :stanza_id => 8 },
  { :line => "A throe that came and left a quivering trace,", :no => 35, :created_at => "2012-10-10 12:15:44", :updated_at => "2012-10-10 12:15:44",  :stanza_id => 9 },
  { :line => "Gave room for an old tired want unfilled,", :no => 36, :created_at => "2012-10-10 12:15:44", :updated_at => "2012-10-10 12:15:44",  :stanza_id => 9 },
  { :line => "At peace in its subconscient moonless cave", :no => 37, :created_at => "2012-10-10 12:15:44", :updated_at => "2012-10-10 12:15:44",  :stanza_id => 9 },
  { :line => "To raise its head and look for absent light,", :no => 38, :created_at => "2012-10-10 12:15:44", :updated_at => "2012-10-10 12:15:44",  :stanza_id => 9 },
  { :line => "Straining closed eyes of vanished memory,", :no => 39, :created_at => "2012-10-10 12:15:45", :updated_at => "2012-10-10 12:15:45",  :stanza_id => 9 },
  { :line => "Like one who searches for a bygone self", :no => 40, :created_at => "2012-10-10 12:15:45", :updated_at => "2012-10-10 12:15:45",  :stanza_id => 9 },
  { :line => "And only meets the corpse of his desire.", :no => 41, :created_at => "2012-10-10 12:15:45", :updated_at => "2012-10-10 12:15:45",  :stanza_id => 9 },
  { :line => "It was as though even in this Nought’s profound,", :no => 42, :created_at => "2012-10-10 12:19:39", :updated_at => "2012-10-10 12:19:39",  :stanza_id => 10 },
  { :line => "Even in this ultimate dissolution’s core", :no => 43, :created_at => "2012-10-10 12:19:40", :updated_at => "2012-10-10 12:19:40",  :stanza_id => 10 },
  { :line => "There lurked an unremembering entity,", :no => 44, :created_at => "2012-10-10 12:19:40", :updated_at => "2012-10-10 12:19:40",  :stanza_id => 10 },
  { :line => "Survivor of a slain and buried past", :no => 45, :created_at => "2012-10-10 12:19:40", :updated_at => "2012-10-10 12:19:40",  :stanza_id => 10 },
  { :line => "Condemned to resume the effort and the pang,", :no => 46, :created_at => "2012-10-10 12:19:40", :updated_at => "2012-10-10 12:19:40",  :stanza_id => 10 },
  { :line => "Reviving in another frustrate world.", :no => 47, :created_at => "2012-10-10 12:19:41", :updated_at => "2012-10-10 12:19:41",  :stanza_id => 10 },
  { :line => "An unshaped consciousness desired light", :no => 48, :created_at => "2012-10-10 12:20:57", :updated_at => "2012-10-10 12:21:28",  :stanza_id => 11 },
  { :line => "And a blank prescience yearned towards distant change.", :no => 49, :created_at => "2012-10-10 12:20:57", :updated_at => "2012-10-10 12:26:16",  :stanza_id => 11 },
  { :line => "As if a childlike finger laid on a cheek", :no => 50, :created_at => "2012-10-10 12:29:10", :updated_at => "2012-10-10 12:29:10",  :stanza_id => 12 },
  { :line => "Reminded of the endless need in things", :no => 51, :created_at => "2012-10-10 12:29:10", :updated_at => "2012-10-10 12:29:10",  :stanza_id => 12 },
  { :line => "The heedless Mother of the universe,", :no => 52, :created_at => "2012-10-10 12:29:10", :updated_at => "2012-10-10 12:29:10",  :stanza_id => 12 },
  { :line => "An infant longing clutched the sombre Vast.", :no => 53, :created_at => "2012-10-10 12:29:10", :updated_at => "2012-10-10 12:29:10",  :stanza_id => 12 },
  { :line => "Insensibly somewhere a breach began:", :no => 54, :created_at => "2012-10-10 12:30:23", :updated_at => "2012-10-10 12:30:23",  :stanza_id => 13 },
  { :line => "A long lone line of hesitating hue", :no => 55, :created_at => "2012-10-10 12:30:24", :updated_at => "2012-10-10 12:30:24",  :stanza_id => 13 },
  { :line => "Like a vague smile tempting a desert heart", :no => 56, :created_at => "2012-10-10 12:30:24", :updated_at => "2012-10-10 12:30:24",  :stanza_id => 13 },
  { :line => "Troubled the far rim of life’s obscure sleep.", :no => 57, :created_at => "2012-10-10 12:30:24", :updated_at => "2012-10-10 12:30:24",  :stanza_id => 13 },
  { :line => "Arrived from the other side of boundlessness", :no => 58, :created_at => "2012-10-10 12:31:21", :updated_at => "2012-10-10 12:31:21",  :stanza_id => 14 },
  { :line => "An eye of deity pierced through the dumb deeps;", :no => 59, :created_at => "2012-10-10 12:31:21", :updated_at => "2012-10-10 12:31:21",  :stanza_id => 14 },
  { :line => "A scout in a reconnaissance from the sun,", :no => 60, :created_at => "2012-10-10 12:31:21", :updated_at => "2012-10-10 12:31:21",  :stanza_id => 14 },
  { :line => "It seemed amid a heavy cosmic rest,", :no => 61, :created_at => "2012-10-10 12:31:22", :updated_at => "2012-10-10 12:31:22",  :stanza_id => 14 },
  { :line => "The torpor of a sick and weary world,", :no => 62, :created_at => "2012-10-10 12:31:22", :updated_at => "2012-10-10 12:31:22",  :stanza_id => 14 },
  { :line => "To seek for a spirit sole and desolate", :no => 63, :created_at => "2012-10-10 12:31:22", :updated_at => "2012-10-10 12:31:22",  :stanza_id => 14 },
  { :line => "Too fallen to recollect forgotten bliss.", :no => 64, :created_at => "2012-10-10 12:31:22", :updated_at => "2012-10-10 12:31:22",  :stanza_id => 14 },
  { :line => "Intervening in a mindless universe,", :no => 65, :created_at => "2012-10-10 12:32:14", :updated_at => "2012-10-10 12:32:14",  :stanza_id => 15 },
  { :line => "Its message crept through the reluctant hush", :no => 66, :created_at => "2012-10-10 12:32:14", :updated_at => "2012-10-10 12:32:14",  :stanza_id => 15 },
  { :line => "Calling the adventure of consciousness and joy", :no => 67, :created_at => "2012-10-10 12:32:14", :updated_at => "2012-10-10 12:32:14",  :stanza_id => 15 },
  { :line => "And, conquering Nature’s disillusioned breast,", :no => 68, :created_at => "2012-10-10 12:32:14", :updated_at => "2012-10-10 12:32:14",  :stanza_id => 15 },
  { :line => "Compelled renewed consent to see and feel.", :no => 69, :created_at => "2012-10-10 12:32:14", :updated_at => "2012-10-10 12:32:14",  :stanza_id => 15 },
  { :line => "A thought was sown in the unsounded Void,", :no => 70, :created_at => "2012-10-10 12:33:51", :updated_at => "2012-10-10 12:33:51",  :stanza_id => 16 },
  { :line => "A sense was born within the darkness’ depths,", :no => 71, :created_at => "2012-10-10 12:33:52", :updated_at => "2012-10-10 12:33:52",  :stanza_id => 16 },
  { :line => "A memory quivered in the heart of Time", :no => 72, :created_at => "2012-10-10 12:33:52", :updated_at => "2012-10-10 12:33:52",  :stanza_id => 16 },
  { :line => "As if a soul long dead were moved to live:", :no => 73, :created_at => "2012-10-10 12:33:52", :updated_at => "2012-10-10 12:33:52",  :stanza_id => 16 },
  { :line => "But the oblivion that succeeds the fall,", :no => 74, :created_at => "2012-10-10 12:33:52", :updated_at => "2012-10-10 12:33:52",  :stanza_id => 16 },
  { :line => "Had blotted the crowded tablets of the past,", :no => 75, :created_at => "2012-10-10 12:33:53", :updated_at => "2012-10-10 12:33:53",  :stanza_id => 16 },
  { :line => "And all that was destroyed must be rebuilt", :no => 76, :created_at => "2012-10-10 12:33:53", :updated_at => "2012-10-10 12:33:53",  :stanza_id => 16 },
  { :line => "And old experience laboured out once more.", :no => 77, :created_at => "2012-10-10 12:33:53", :updated_at => "2012-10-10 12:33:53",  :stanza_id => 16 },
  { :line => "All can be done if the god-touch is there.", :no => 78, :created_at => "2012-10-10 12:34:49", :updated_at => "2012-10-10 12:34:49",  :stanza_id => 17 },
  { :line => "A hope stole in that hardly dared to be", :no => 79, :created_at => "2012-10-10 12:35:45", :updated_at => "2012-10-10 12:35:45",  :stanza_id => 18 },
  { :line => "Amid the Night’s forlorn indifference.", :no => 80, :created_at => "2012-10-10 12:35:46", :updated_at => "2012-10-10 12:35:46",  :stanza_id => 18 },
  { :line => "As if solicited in an alien world", :no => 81, :created_at => "2012-10-10 12:36:23", :updated_at => "2012-10-10 12:36:23",  :stanza_id => 19 },
  { :line => "With timid and hazardous instinctive grace,", :no => 82, :created_at => "2012-10-10 12:36:24", :updated_at => "2012-10-10 12:36:24",  :stanza_id => 19 },
  { :line => "Orphaned and driven out to seek a home,", :no => 83, :created_at => "2012-10-10 12:36:24", :updated_at => "2012-10-10 12:36:24",  :stanza_id => 19 },
  { :line => "An errant marvel with no place to live,", :no => 84, :created_at => "2012-10-10 12:36:24", :updated_at => "2012-10-10 12:36:24",  :stanza_id => 19 },
  { :line => "Into a far-off nook of heaven there came", :no => 85, :created_at => "2012-10-10 12:36:24", :updated_at => "2012-10-10 12:36:24",  :stanza_id => 19 },
  { :line => "A slow miraculous gesture’s dim appeal.", :no => 86, :created_at => "2012-10-10 12:36:24", :updated_at => "2012-10-10 12:36:24",  :stanza_id => 19 },
  { :line => "The persistent thrill of a transfiguring touch", :no => 87, :created_at => "2012-10-10 12:37:02", :updated_at => "2012-10-10 12:37:02",  :stanza_id => 20 },
  { :line => "Persuaded the inert black quietude", :no => 88, :created_at => "2012-10-10 12:37:02", :updated_at => "2012-10-10 12:37:02",  :stanza_id => 20 },
  { :line => "And beauty and wonder disturbed the fields of God.", :no => 89, :created_at => "2012-10-10 12:37:02", :updated_at => "2012-10-10 12:37:02",  :stanza_id => 20 },
  { :line => "A wandering hand of pale enchanted light", :no => 90, :created_at => "2012-10-10 12:37:34", :updated_at => "2012-10-10 12:37:34",  :stanza_id => 21 },
  { :line => "That glowed along a fading moment’s brink,", :no => 91, :created_at => "2012-10-10 12:37:35", :updated_at => "2012-10-10 12:37:35",  :stanza_id => 21 },
  { :line => "Fixed with gold panel and opalescent hinge", :no => 92, :created_at => "2012-10-10 12:37:35", :updated_at => "2012-10-10 12:37:35",  :stanza_id => 21 },
  { :line => "A gate of dreams ajar on mystery’s verge.", :no => 93, :created_at => "2012-10-10 12:37:35", :updated_at => "2012-10-10 12:37:35",  :stanza_id => 21 },
  { :line => "One lucent corner windowing hidden things", :no => 94, :created_at => "2012-10-10 12:38:23", :updated_at => "2012-10-10 12:38:23",  :stanza_id => 22 },
  { :line => "Forced the world’s blind immensity to sight.", :no => 95, :created_at => "2012-10-10 12:38:24", :updated_at => "2012-10-10 12:38:24",  :stanza_id => 22 },
  { :line => "The darkness failed and slipped like a falling cloak", :no => 96, :created_at => "2012-10-10 12:39:17", :updated_at => "2012-10-10 12:39:17",  :stanza_id => 23 },
  { :line => "From the reclining body of a god.", :no => 97, :created_at => "2012-10-10 12:39:18", :updated_at => "2012-10-10 12:39:18",  :stanza_id => 23 },
  { :line => "Then through the pallid rift that seemed at first", :no => 98, :created_at => "2012-10-10 12:39:57", :updated_at => "2012-10-10 12:39:57",  :stanza_id => 24 },
  { :line => "Hardly enough for a trickle from the suns,", :no => 99, :created_at => "2012-10-10 12:39:58", :updated_at => "2012-10-10 12:39:58",  :stanza_id => 24 },
  { :line => "Outpoured the revelation and the flame.", :no => 100, :created_at => "2012-10-10 12:39:58", :updated_at => "2012-10-10 12:39:58",  :stanza_id => 24 },
  { :line => "The brief perpetual sign recurred above.", :no => 101, :created_at => "2012-10-10 12:40:41", :updated_at => "2012-10-10 12:40:41",  :stanza_id => 25 },
  { :line => "A glamour from the unreached transcendences", :no => 102, :created_at => "2012-10-10 12:41:10", :updated_at => "2012-10-10 12:41:10",  :stanza_id => 26 },
  { :line => "Iridescent with the glory of the Unseen,", :no => 103, :created_at => "2012-10-10 12:41:11", :updated_at => "2012-10-10 12:41:11",  :stanza_id => 26 },
  { :line => "A message from the unknown immortal Light", :no => 104, :created_at => "2012-10-10 12:41:11", :updated_at => "2012-10-10 12:41:11",  :stanza_id => 26 },
  { :line => "Ablaze upon creation’s quivering edge,", :no => 105, :created_at => "2012-10-10 12:41:11", :updated_at => "2012-10-10 12:41:11",  :stanza_id => 26 },
  { :line => "Dawn built her aura of magnificent hues", :no => 106, :created_at => "2012-10-10 12:41:12", :updated_at => "2012-10-10 12:41:12",  :stanza_id => 26 },
  { :line => "And buried its seed of grandeur in the hours.", :no => 107, :created_at => "2012-10-10 12:41:12", :updated_at => "2012-10-10 12:41:12",  :stanza_id => 26 },
  { :line => "An instant’s visitor the godhead shone:", :no => 108, :created_at => "2012-10-10 12:42:25", :updated_at => "2012-10-10 12:42:25",  :stanza_id => 27 },
  { :line => "On life’s thin border awhile the Vision stood", :no => 109, :created_at => "2012-10-10 12:42:25", :updated_at => "2012-10-10 12:42:25",  :stanza_id => 27 },
  { :line => "And bent over earth’s pondering forehead curve.", :no => 110, :created_at => "2012-10-10 12:42:26", :updated_at => "2012-10-10 12:42:26",  :stanza_id => 27 },
  { :line => "Interpreting a recondite beauty and bliss", :no => 111, :created_at => "2012-10-10 12:42:43", :updated_at => "2012-10-10 12:42:43",  :stanza_id => 28 },
  { :line => "In colour’s hieroglyphs of mystic sense,", :no => 112, :created_at => "2012-10-10 12:42:44", :updated_at => "2012-10-10 12:42:44",  :stanza_id => 28 },
  { :line => "It wrote the lines of a significant myth", :no => 113, :created_at => "2012-10-10 12:42:44", :updated_at => "2012-10-10 12:42:44",  :stanza_id => 28 },
  { :line => "Telling of a greatness of spiritual dawns,", :no => 114, :created_at => "2012-10-10 12:42:44", :updated_at => "2012-10-10 12:42:44",  :stanza_id => 28 },
  { :line => "A brilliant code penned with the sky for page.", :no => 115, :created_at => "2012-10-10 12:42:44", :updated_at => "2012-10-10 12:42:44",  :stanza_id => 28 },
  { :line => "Almost that day the epiphany was disclosed", :no => 116, :created_at => "2012-10-10 12:43:00", :updated_at => "2012-10-10 12:43:00",  :stanza_id => 29 },
  { :line => "Of which our thoughts and hopes are signal flares;", :no => 117, :created_at => "2012-10-10 12:43:01", :updated_at => "2012-10-10 12:43:01",  :stanza_id => 29 },
  { :line => "A lonely splendour from the invisible goal", :no => 118, :created_at => "2012-10-10 12:43:01", :updated_at => "2012-10-10 12:43:01",  :stanza_id => 29 },
  { :line => "Almost was flung on the opaque Inane.", :no => 119, :created_at => "2012-10-10 12:43:01", :updated_at => "2012-10-10 12:43:01",  :stanza_id => 29 },
  { :line => "Once more a tread perturbed the vacant Vasts;", :no => 120, :created_at => "2012-10-10 12:43:22", :updated_at => "2012-10-10 12:43:22",  :stanza_id => 30 },
  { :line => "Infinity’s centre, a Face of rapturous calm", :no => 121, :created_at => "2012-10-10 12:43:22", :updated_at => "2012-10-10 12:43:22",  :stanza_id => 30 },
  { :line => "Parted the eternal lids that open heaven;", :no => 122, :created_at => "2012-10-10 12:43:22", :updated_at => "2012-10-10 12:43:22",  :stanza_id => 30 },
  { :line => "A Form from far beatitudes seemed to near.", :no => 123, :created_at => "2012-10-10 12:43:23", :updated_at => "2012-10-10 12:43:23",  :stanza_id => 30 },
  { :line => "Ambassadress twixt eternity and change,", :no => 124, :created_at => "2012-10-11 07:28:27", :updated_at => "2012-10-11 07:28:27",  :stanza_id => 33 },
  { :line => "The omniscient Goddess leaned across the breadths", :no => 125, :created_at => "2012-10-11 07:28:27", :updated_at => "2012-10-11 07:28:27",  :stanza_id => 33 },
  { :line => "That wrap the fated journeyings of the stars", :no => 126, :created_at => "2012-10-11 07:28:27", :updated_at => "2012-10-11 07:28:27",  :stanza_id => 33 },
  { :line => "And saw the spaces ready for her feet.", :no => 127, :created_at => "2012-10-11 07:28:28", :updated_at => "2012-10-11 07:28:28",  :stanza_id => 33 },
  { :line => "Once she half looked behind for her veiled sun,", :no => 128, :created_at => "2012-10-11 07:42:19", :updated_at => "2012-10-11 07:42:19",  :stanza_id => 34 },
  { :line => "Then, thoughtful, went to her immortal work.", :no => 129, :created_at => "2012-10-11 07:42:19", :updated_at => "2012-10-11 07:42:19",  :stanza_id => 34 },
  { :line => "Earth felt the Imperishable’s passage close:", :no => 130, :created_at => "2012-10-11 07:43:26", :updated_at => "2012-10-11 07:43:26",  :stanza_id => 35 },
  { :line => "The waking ear of Nature heard her steps", :no => 131, :created_at => "2012-10-11 07:43:27", :updated_at => "2012-10-11 07:43:27",  :stanza_id => 35 },
  { :line => "And wideness turned to her its limitless eye,", :no => 132, :created_at => "2012-10-11 07:43:27", :updated_at => "2012-10-11 07:43:27",  :stanza_id => 35 },
  { :line => "And, scattered on sealed depths, her luminous smile", :no => 133, :created_at => "2012-10-11 07:43:27", :updated_at => "2012-10-11 07:43:27",  :stanza_id => 35 },
  { :line => "Kindled to fire the silence of the worlds.", :no => 134, :created_at => "2012-10-11 07:43:27", :updated_at => "2012-10-11 07:43:27",  :stanza_id => 35 },
  { :line => "All grew a consecration and a rite.", :no => 135, :created_at => "2012-10-11 07:44:14", :updated_at => "2012-10-11 07:44:14",  :stanza_id => 36 },
  { :line => "Air was a vibrant link between earth and heaven;", :no => 136, :created_at => "2012-10-11 07:44:44", :updated_at => "2012-10-11 07:44:44",  :stanza_id => 37 },
  { :line => "The wide-winged hymn of a great priestly wind", :no => 137, :created_at => "2012-10-11 07:44:45", :updated_at => "2012-10-11 07:44:45",  :stanza_id => 37 },
  { :line => "Arose and failed upon the altar hills;", :no => 138, :created_at => "2012-10-11 07:44:45", :updated_at => "2012-10-11 07:44:45",  :stanza_id => 37 },
  { :line => "The high boughs prayed in a revealing sky.", :no => 139, :created_at => "2012-10-11 07:44:45", :updated_at => "2012-10-11 07:44:45",  :stanza_id => 37 },
  { :line => "Here where our half-lit ignorance skirts the gulfs", :no => 140, :created_at => "2012-10-11 07:45:28", :updated_at => "2012-10-11 07:45:28",  :stanza_id => 38 },
  { :line => "On the dumb bosom of the ambiguous earth,", :no => 141, :created_at => "2012-10-11 07:45:29", :updated_at => "2012-10-11 07:45:29",  :stanza_id => 38 },
  { :line => "Here where one knows not even the step in front", :no => 142, :created_at => "2012-10-11 07:45:29", :updated_at => "2012-10-11 07:45:29",  :stanza_id => 38 },
  { :line => "And Truth has her throne on the shadowy back of doubt,", :no => 143, :created_at => "2012-10-11 07:45:29", :updated_at => "2012-10-11 07:45:29",  :stanza_id => 38 },
  { :line => "On this anguished and precarious field of toil", :no => 144, :created_at => "2012-10-11 07:45:29", :updated_at => "2012-10-11 07:45:29",  :stanza_id => 38 },
  { :line => "Outspread beneath some large indifferent gaze,", :no => 145, :created_at => "2012-10-11 07:45:30", :updated_at => "2012-10-11 07:45:30",  :stanza_id => 38 },
  { :line => "Impartial witness to our joy and bale,", :no => 146, :created_at => "2012-10-11 07:45:30", :updated_at => "2012-10-11 07:45:30",  :stanza_id => 38 },
  { :line => "Our prostrate soil bore the awakening ray.", :no => 147, :created_at => "2012-10-11 07:45:30", :updated_at => "2012-10-11 07:45:30",  :stanza_id => 38 },
  { :line => "Here too the vision and prophetic gleam", :no => 148, :created_at => "2012-10-11 07:56:40", :updated_at => "2012-10-11 07:56:40",  :stanza_id => 39 },
  { :line => "Lit into miracles common meaningless shapes;", :no => 149, :created_at => "2012-10-11 07:56:40", :updated_at => "2012-10-11 07:56:40",  :stanza_id => 39 },
  { :line => "Then the divine afflatus, spent, withdrew,", :no => 150, :created_at => "2012-10-11 07:56:40", :updated_at => "2012-10-11 07:56:40",  :stanza_id => 39 },
  { :line => "Unwanted, fading from the mortal’s range.", :no => 151, :created_at => "2012-10-11 07:56:41", :updated_at => "2012-10-11 07:56:41",  :stanza_id => 39 },
  { :line => "A sacred yearning lingered in its trace,", :no => 152, :created_at => "2012-10-11 07:58:28", :updated_at => "2012-10-11 07:58:28",  :stanza_id => 40 },
  { :line => "The worship of a Presence and a Power", :no => 153, :created_at => "2012-10-11 07:58:28", :updated_at => "2012-10-11 07:58:28",  :stanza_id => 40 },
  { :line => "Too perfect to be held by death-bound hearts,", :no => 154, :created_at => "2012-10-11 07:58:28", :updated_at => "2012-10-11 07:58:28",  :stanza_id => 40 },
  { :line => "The prescience of a marvellous birth to come.", :no => 155, :created_at => "2012-10-11 07:58:28", :updated_at => "2012-10-11 07:58:28",  :stanza_id => 40 },
  { :line => "Only a little the God-light can stay:", :no => 156, :created_at => "2012-10-11 07:59:02", :updated_at => "2012-10-11 07:59:02",  :stanza_id => 41 },
  { :line => "Spiritual beauty illumining human sight", :no => 157, :created_at => "2012-10-11 07:59:03", :updated_at => "2012-10-11 07:59:03",  :stanza_id => 41 },
  { :line => "Lines with its passion and mystery Matter’s mask", :no => 158, :created_at => "2012-10-11 07:59:03", :updated_at => "2012-10-11 07:59:03",  :stanza_id => 41 },
  { :line => "And squanders eternity on a beat of Time.", :no => 159, :created_at => "2012-10-11 07:59:03", :updated_at => "2012-10-11 07:59:03",  :stanza_id => 41 },
  { :line => "As when a soul draws near the sill of birth,", :no => 160, :created_at => "2012-10-11 07:59:33", :updated_at => "2012-10-11 07:59:33",  :stanza_id => 31 },
  { :line => "Adjoining mortal time to Timelessness,", :no => 161, :created_at => "2012-10-11 07:59:33", :updated_at => "2012-10-11 07:59:33",  :stanza_id => 31 },
  { :line => "A spark of deity lost in Matter’s crypt", :no => 162, :created_at => "2012-10-11 07:59:33", :updated_at => "2012-10-11 07:59:33",  :stanza_id => 31 },
  { :line => "Its lustre vanishes in the inconscient planes,", :no => 163, :created_at => "2012-10-11 07:59:34", :updated_at => "2012-10-11 07:59:34",  :stanza_id => 31 },
  { :line => "That transitory glow of magic fire", :no => 164, :created_at => "2012-10-11 07:59:34", :updated_at => "2012-10-11 07:59:34",  :stanza_id => 31 },
  { :line => "So now dissolved in bright accustomed air.", :no => 165, :created_at => "2012-10-11 07:59:34", :updated_at => "2012-10-11 07:59:34",  :stanza_id => 31 }
], :without_protection => true )


Role.create([
  { :name => "Admin", :created_at => "2012-10-16 06:34:05", :updated_at => "2012-10-16 06:34:05" },
  { :name => "Scholar", :created_at => "2012-10-16 06:34:05", :updated_at => "2012-10-16 06:34:05" },
  { :name => "Blogger", :created_at => "2012-10-16 06:34:05", :updated_at => "2012-10-16 06:34:05" },
  { :name => "User", :created_at => "2012-10-16 06:34:06", :updated_at => "2012-10-16 06:34:06" }
], :without_protection => true )


Stanza.create([
  { :stanzno => 1, :created_at => "2012-09-28 14:43:43", :updated_at => "2012-09-28 14:43:43", :canto_id => 1 },
  { :stanzno => 2, :created_at => "2012-09-28 14:43:47", :updated_at => "2012-09-28 14:43:47", :canto_id => 1 },
  { :stanzno => 3, :created_at => "2012-09-28 14:43:53", :updated_at => "2012-09-28 14:43:53", :canto_id => 1 },
  { :stanzno => 4, :created_at => "2012-09-28 14:43:58", :updated_at => "2012-09-28 14:43:58", :canto_id => 1 },
  { :stanzno => 5, :created_at => "2012-09-28 14:44:04", :updated_at => "2012-09-28 14:44:04", :canto_id => 1 },
  { :stanzno => 6, :created_at => "2012-10-04 11:05:30", :updated_at => "2012-10-04 11:05:30", :canto_id => 1 },
  { :stanzno => 7, :created_at => "2012-10-04 11:11:02", :updated_at => "2012-10-04 11:11:02", :canto_id => 1 },
  { :stanzno => 8, :created_at => "2012-10-04 11:11:10", :updated_at => "2012-10-04 11:11:10", :canto_id => 1 },
  { :stanzno => 9, :created_at => "2012-10-10 12:09:09", :updated_at => "2012-10-10 12:09:09", :canto_id => 1 },
  { :stanzno => 10, :created_at => "2012-10-10 12:17:20", :updated_at => "2012-10-10 12:17:20", :canto_id => 1 },
  { :stanzno => 11, :created_at => "2012-10-10 12:18:23", :updated_at => "2012-10-10 12:18:23", :canto_id => 1 },
  { :stanzno => 12, :created_at => "2012-10-10 12:18:27", :updated_at => "2012-10-10 12:18:27", :canto_id => 1 },
  { :stanzno => 13, :created_at => "2012-10-10 12:30:11", :updated_at => "2012-10-10 12:30:11", :canto_id => 1 },
  { :stanzno => 14, :created_at => "2012-10-10 12:31:00", :updated_at => "2012-10-10 12:31:00", :canto_id => 1 },
  { :stanzno => 15, :created_at => "2012-10-10 12:31:41", :updated_at => "2012-10-10 12:31:41", :canto_id => 1 },
  { :stanzno => 16, :created_at => "2012-10-10 12:33:25", :updated_at => "2012-10-10 12:33:25", :canto_id => 1 },
  { :stanzno => 17, :created_at => "2012-10-10 12:34:16", :updated_at => "2012-10-10 12:34:16", :canto_id => 1 },
  { :stanzno => 18, :created_at => "2012-10-10 12:35:13", :updated_at => "2012-10-10 12:35:13", :canto_id => 1 },
  { :stanzno => 19, :created_at => "2012-10-10 12:36:01", :updated_at => "2012-10-10 12:36:01", :canto_id => 1 },
  { :stanzno => 20, :created_at => "2012-10-10 12:36:49", :updated_at => "2012-10-10 12:36:49", :canto_id => 1 },
  { :stanzno => 21, :created_at => "2012-10-10 12:37:23", :updated_at => "2012-10-10 12:37:23", :canto_id => 1 },
  { :stanzno => 22, :created_at => "2012-10-10 12:37:44", :updated_at => "2012-10-10 12:37:44", :canto_id => 1 },
  { :stanzno => 23, :created_at => "2012-10-10 12:38:33", :updated_at => "2012-10-10 12:38:33", :canto_id => 1 },
  { :stanzno => 24, :created_at => "2012-10-10 12:39:28", :updated_at => "2012-10-10 12:39:28", :canto_id => 1 },
  { :stanzno => 25, :created_at => "2012-10-10 12:40:06", :updated_at => "2012-10-10 12:40:06", :canto_id => 1 },
  { :stanzno => 26, :created_at => "2012-10-10 12:40:52", :updated_at => "2012-10-10 12:40:52", :canto_id => 1 },
  { :stanzno => 27, :created_at => "2012-10-10 12:41:34", :updated_at => "2012-10-10 12:41:34", :canto_id => 1 },
  { :stanzno => 28, :created_at => "2012-10-10 12:41:40", :updated_at => "2012-10-10 12:41:40", :canto_id => 1 },
  { :stanzno => 29, :created_at => "2012-10-10 12:41:47", :updated_at => "2012-10-10 12:41:47", :canto_id => 1 },
  { :stanzno => 30, :created_at => "2012-10-10 12:41:54", :updated_at => "2012-10-10 12:41:54", :canto_id => 1 },
  { :stanzno => 40, :created_at => "2012-10-11 06:48:22", :updated_at => "2012-10-11 06:48:22", :canto_id => 1 },
  { :stanzno => 31, :created_at => "2012-10-11 07:14:35", :updated_at => "2012-10-11 07:14:35", :canto_id => 1 },
  { :stanzno => 32, :created_at => "2012-10-11 07:41:50", :updated_at => "2012-10-11 07:41:50", :canto_id => 1 },
  { :stanzno => 33, :created_at => "2012-10-11 07:42:38", :updated_at => "2012-10-11 07:42:38", :canto_id => 1 },
  { :stanzno => 34, :created_at => "2012-10-11 07:43:51", :updated_at => "2012-10-11 07:43:51", :canto_id => 1 },
  { :stanzno => 35, :created_at => "2012-10-11 07:44:26", :updated_at => "2012-10-11 07:44:26", :canto_id => 1 },
  { :stanzno => 36, :created_at => "2012-10-11 07:44:58", :updated_at => "2012-10-11 07:44:58", :canto_id => 1 },
  { :stanzno => 37, :created_at => "2012-10-11 07:56:28", :updated_at => "2012-10-11 07:56:28", :canto_id => 1 },
  { :stanzno => 38, :created_at => "2012-10-11 07:57:55", :updated_at => "2012-10-11 07:57:55", :canto_id => 1 },
  { :stanzno => 39, :created_at => "2012-10-11 07:58:44", :updated_at => "2012-10-11 07:58:44", :canto_id => 1 }
], :without_protection => true )

User.create([
  { :name => "Admin", :email => "modak.nishant@gmail.com", :password => "admin123",:password_confirmation => "admin123", :username => "admin", :role_id => 1, :photo => nil }
], :without_protection => true )

Blog.create([
    { :title => "Nishant's Ramblings", :subtitle => "Into the Unknown", :user_id => 1}
  ])

Post.create([
  { :title => "The Golden Gate Bride", :content => "<p><img src=""http://imperavi.com/img/woman.jpg"" alt=""Autumn"" style=""margin: 0px 20px 10px 0px; padding: 0px; outline: 0px; vertical-align: baseline; background-color: transparent; color: rgb(0, 0, 0); line-height: 21.75px; float: left;""><h3>The Sky Is Everywhere</h3><p><i>Jandy Nelson</i></p><p>She opens her case, starts putting together her instrument. ""Joe studied at a conservatory in&nbsp;<i>Fronce</i>. Did he tell you?"" Of course she doesn't say&nbsp;<i>France</i>&nbsp;so it rhymes with dance like a normal English-speaking human being. I can feel Sarah bristling beside me. She has zero tolerance for Rachel ever since she got first chair over me, but Sarah doesn‘t know what really happened — no one does.</p><p>Rachel's tightening the ligature on her mouthpiece like she's trying to asphyxiate her clarinet. ""Joe was a&nbsp;<i>fabulous</i>&nbsp;second in your absence."" she says, drawing out the word&nbsp;<i>fabulous</i>&nbsp;from here to the Eiffel Tower.</p><p>I don't fire-breathe at her: ""Glad everything worked out for you, Rachel."" I don't say a word, just wish I could curl into a ball and roll away. Sarah, on the other hand, looks like she wishes there were a battle-ax handy.</p><p>The room has become a clamor of random notes and scales. ""Finish up tuning, I want to start at the bell today,"" Mr. James calls from the piano. ""And take out your pencils. l’ve made some changes to the arrangement.""</p></p>", :created_at => "2012-09-28 15:12:37", :updated_at => "2012-09-28 15:12:37", :blog_id => 1 }
], :without_protection => true )