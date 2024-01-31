#charset "us-ascii"

/**
Brainstorming:
-very simple scenario:
    --Griffin keeps noticing the smell of a baby griffin from outside the aery and beneath some scrub brush. 
    --the griffins talk about a child going missing, one of the reasons they're impatient with Griffin's request to learn to fly.
    --puzzle 1 is that player needs to tell them he can smell and find a baby griffin nearby apart from all the rest, which makes them grateful and interests
      Scout in Griffin's sniffer.
    --puzzle 2 is that Griffin must use the Ropes on the Inexplicable Quadruped Stand to create a griffin-dog harness.  Showing this harness to Mallory will cause her to see the potential in the invention and initiate hooking it up to Scout, winning the game.  In the victory description, we should mention Mr. Griffin's sniffer being a huge help to Scout AND his helicopter tail eventually leading to his own unique take on flight after he gets the hang of aerodynamics.
*/

/*
 *   Copyleft 2019 by Jeff Creswell
 *   Permission is granted to anyone to copy and use this file for any purpose,
 *   with attribution.  
 *   
 *   This is a starter TADS 3 source file.  This is a complete TADS game
 *   that you can compile and run.
 *   
 *   
 */

/* 
 *   Include the main header for the standard TADS 3 adventure library.
 *   Note that this does NOT include the entire source code for the
 *   library; this merely includes some definitions for our use here.  The
 *   main library must be "linked" into the finished program by including
 *   the file "adv3.tl" in the list of modules specified when compiling.
 *   In TADS Workbench, simply include adv3.tl in the "Source Files"
 *   section of the project.
 *   
 *   Also include the US English definitions, since this game is written
 *   in English.  
 */
#include <adv3.h>
#include <en_us.h>

/*
 *   Our game credits and version information.  This object isn't required
 *   by the system, but our GameInfo initialization above needs this for
 *   some of its information.
 *   
 *   IMPORTANT - You should customize some of the text below, as marked:
 *   the name of your game, your byline, and so on.  
 */
versionInfo: GameID
    IFID = '0719d90b-139f-448d-810b-f5622b8d94fc'
    name = 'The Littlest Griffin'
    byline = 'by Jeff Creswell'
    htmlByline = 'by <a href="mailto:creswel2@gmail.com">
                  Jeff Creswell</a>'
    version = '1.1.2'
    authorEmail = 'Jeff Creswell <creswel2@gmail.com>'
    desc = 'A one room micro adventure starring Mr. Griffin the dog and actual griffins.'
    htmlDesc = 'A one room micro adventure starring Mr. Griffin the dog and actual griffins.'

    showCredit()
    {
        /* show our credits */
        "tale by Jeff Creswell, tail by Griffin Dog";

        /* 
         *   The game credits are displayed first, but the library will
         *   display additional credits for library modules.  It's a good
         *   idea to show a blank line after the game credits to separate
         *   them visually from the (usually one-liner) library credits
         *   that follow.  
         */
        "\b";
    }
    showAbout()
    {
        "This game was created to evaluate TADS 3. Also, to immortalize Mr. Griffin, Friendliest of Hounds.";
    }
;

/* Custom verbs */
DefineTAction(Chew);

   VerbRule(Chew)
     ('chew' | 'chomp') singleDobj
     : ChewAction
     verbPhrase = 'chew/chewing (what)'
   ;

   modify Thing
     dobjFor(Chew)
     {
       verify() 
       {
         illogical('You probably shouldn\'t chew on 
                   {that dobj/him/her}. ');
       }
     }
   ;

DefineTAction(Lick);

   VerbRule(Lick)
     ('lick') singleDobj
     : LickAction
     verbPhrase = 'lick/licking (what)'
   ;

   modify Thing
     dobjFor(Lick)
     {
       verify() 
       {
         illogical('You probably shouldn\'t lick 
                   {that dobj/him/her}. ');
       }
     }
   ;
    
DefineTAction(PlayWith);

   VerbRule(PlayWith)
     ('play' | 'frolic') 'with' singleDobj
     : PlayWithAction
     verbPhrase = 'play/playing with (what)'
   ;

   modify Thing
     dobjFor(PlayWith)
     {
       verify() 
       {
         illogical('Defying all logic, 
                   {that dobj/he/she} doesn\'t seem to want to play just now. ');
       }
     }
   ;

DefineTIAction(UseOn);

   VerbRule(UseOn)
     'use' singleDobj 'on' singleIobj
     : UseOnAction
     verbPhrase = 'use (what) (on what)'
   ;

   modify Thing
     dobjFor(UseOn)
     {
       verify() 
       {
         illogical('There\'s no obvious way to use {dobj/him/her} on 
                   {dobj/him/her}. ');
       }
     }
   ;

DefineIAction(Help)
     execAction() { mainReport('Available commands are talk/speak to something, ask/tell something about something else, show something to something else, chew something, sniff something, lick something, play with something,
         open something, take something, use something on something else'); }
   ;
VerbRule(Help)
     'help'
     : HelpAction
     verbPhrase = 'help/helping'
   ;

DefineIAction(Bark)
     execAction() 
     {
        "You bork and howl celebration for the sheer joy of raising your voice in the song of your people!";
     }
   ;
VerbRule(Bark)
     ('bark' | 'bork' | 'howl' | 'yap' | 'yip')
     : BarkAction
     verbPhrase = 'bark/barking'
   ;

/* Topics of discussion */
flightTopic: Topic 'fly/flight/flying/wings/bird';
magicTopic: Topic 'magic/sorcery/mysticism/math';
salutationTopic: Topic 'hi/hiya/hello/greetings/how are you/salutations/hey/hoi/hei/hai';

/* 
 *   Aery location, home of griffins and initially dismissive of Griffin
 *   
 *   We use the class "Room" to define the location.  Room is a class,
 *   defined in the library, that can be used for most of the locations in
 *   the game.
 *   
 *   Our definition defines two strings.  The first string, which must be
 *   in single quotes, is the "name" of the room; the name is displayed on
 *   the status line and each time the player enters the room.  The second
 *   string, which must be in double quotes, is the "description" of the
 *   room, which is a full description of the room.  This is displayed
 *   when the player types "look around," when the player first enters the
 *   room, and any time the player enters the room when playing in VERBOSE
 *   mode.  
 */
aery: Room 'Aery'
    "This room is stiflingly hot -- sunlight streams in from massive arched windows high above and is absorbed by the hay and feathery debris surrounding five enormous nests spread around the room in equal intervals.  The smell is even more overwhelming than the heat, especially to the keen sniffer of a proud hound like yourself.  Five mighty griffins, creatures with the hindquarters of a lion and the foreparts of an eagle, stand over you, casting smothering shadows.  Their lead scout, Scout, studies you appraisingly<<scoutGriffin.describeHarness>>.  The rest look bored."
;

/*
 *   Define the scout Griffin, Scout.  
 */
+ scoutGriffin: Actor 'scout/scout griffin/scout' 'Scout'
    "The scout griffin Scout <<getIdleMannerismDescription>><<describeHarness>>. "

    isProperName = true
    isHim = true

    dobjFor(Lick)
    {
        verify(){}
        action() 
        {
            "Scout smiles down merrily as you lick his forepaws. <q>Aw, I love you too little dog!</q>";
        }
    }
    
    dobjFor(Smell)
    {
        verify(){}
        action() 
        {
            inherited();
            mainReport('Scout smells of wild places and things, of adventure and merrymaking. Most interestingly, he smells of the sky!');
        }
    }
    
    getIdleMannerismDescription
    {
        if(griffinDog.snifferDemoed)
        {
            "looks fondly at you, especially your ever-wiggling nose, with sparkles in his sharp eyes";
        } 
        else 
        {
            "stares proudly down his beak at you";
        }
    }

    /*
     *   In the description text above, we embedded the expression
     *   "describeHarness".  Whenever the description text is displayed, it
     *   will call evaluate that expression, which will in turn call this
     *   method, where we'll generate some additional text to describe the
     *   axe if it's still part of the suit of armor. 
     */
    describeHarness
    {
        if (griffinDogHarness.isIn(scoutGriffin))
            ", dog-style quadruped harness rigged up and ready to go 'round his middle',";
    }
    defaultGreetingResponse(otherActor)
    {
        if (griffinDog.snifferDemoed)
        {
            "The scout griffin bobs his head amiably, <q>Hello little fellow. What can I do for you?</q> Perhaps you should ask or tell him directly about whatever's on your mind?";
        }
        else
        {
            "The scout griffin bobs his head amiably, though he seems distressed. <q>Hello little fellow. I'm afraid we're all a bit preoccupied at the moment searching for one of our lost little 
            cublet. We've got a bunch running \'round here I know, but one\'s unaccounted for.</q> 
            Perhaps you could help point them in the right direction?";
        }
    }
;

/* attempt to match any ask/tell involving mentioning a cublet and any indicators that you have smelled it outside or on the ground level or in the bushes... */
++AskTellTopic '.*cublet.*outside|.*outside.*cublet|.*bush.*cublet|.*cublet.*bush|.*ground.*cublet|.*cublet.*ground|.*smell.*window|.*smell.*outside|.*smell.*bush.*|.*cublet.*window|.*window.*cublet'
    topicResponse()
    {
        if(!griffinDog.snifferDemoed)
        {
            /* the player has to tell someone about the cublet right after they sniff out the missing cublet */
            if(griffinDog.bCubletSmelled)
            {
                "Scout rushes to a window and looks out.  <q>Are you certain?  I don't see anything... I shall investigate!</q>  He zooms out the window and down to the ground, and commences snuffling through the bushes.  After a few minutes he returns with a tiny cublet held carefully in his beak.  There are squawks of rejoice from the others as he deposits the little one safely with the others.  <q>Thank you so much mister dog!  That's some sniffer you've got; we'd been searching all day in vain.</q>  He tilts his head thoughtfully.  <q>My scouting work could benefit greatly from your wiggly snoot, and I bet your tail wagging would give us some sort of aerodynamic boost!  If only there were a way for us to fly together...</q>";
                griffinDog.snifferDemoed = true;
                griffinDog.endDaemon();
                addToScore(5, 'cublet rescued');
            }
            else 
            {
                "Scout rushes to a window and looks out.  <q>Are you certain?  I don't see anything... I shall investigate!</q>  He zooms out the window and down to the ground, and commences snuffling through the bushes.  After a few minutes he returns with nothing.  <q>I appreciate your wish to help little dog, but there is nothing down there now.</q>";
            }
        }
        else 
        {
            "He looks at you, confused.  <q>We're not missing any cublets, thanks to you.  Maybe you're still smelling the same one from before?</q>";
        }
    }
;

++AskTellTopic '.*cublet.*'
    "<q>Yes, the cublets are our treasures. We're looking for a lost little one at the moment.</q>  Scout's keen eyes search the room, his attention clearly elsewhere."
;

++AskTellTopic @salutationTopic
    "<q>Hello little dog!</q>  Scout greets you distractedly, his keen eyes searching the room and his attention clearly elsewhere."
;

++AskTellTopic, StopEventList @flightTopic
    ['<q>Roof?  Woowoof.</q>*You wag in circles and stamp your paws a few times, excited to deal with the reasonable and adventuresome-looking Scout.*<.p>Scout shakes his beak sadly and explains, <q>You\'ve got the spirit for flight and no mistake.  We have no physical support for this spirit in you, however -- your body just isn\'t really conducive to flight.  I\'m sorry little guy, but I don\'t think there\'s anything we can do to help you.</q>',

    '<q>Still no idea how we can help you, little dog.  I really am sorry.</q>.']
;

+++AltTopic
    "Crowing his appreciation, Scout dips his beak and bends his front feet in a deep bow.  <q>Thanks to you our family is whole again!  Oh how I wish we could help you achieve your dream of flight...</q>"
    isActive = (griffinDog.snifferDemoed && griffinDogHarness.location != griffinDog) 
;

+++AltTopic
    "Looking curiously at the harness you've put together, Scout remarks, <q>What an ingenious device!  I'm not sure how we should hook it up, but it suggests some sort of collaboration between us.  Maybe flight by proxy?</q>"
    isActive = (griffinDog.snifferDemoed && griffinDogHarness.location == griffinDog) 
;

++GiveShowTopic @griffinDogHarness
    "<q>What a marvelous contraption!  I don't quite see what it's good for, but well done you for making it.  Maybe Mallory would be intrigued?</q>";
;

/*
 *   Define the warrior griffin.  
 *   
 *   Note that we define both "bird" and "griffin" as nouns in our vocabulary
 *   list, because we want to be able to refer to it as "burly bird" and "burly griffin" for no reason. Incidentally,
 *   the phrasing "x of y", both x and y are noun phrases.  
 */
+ warriorGriffin: Actor 'burly bird/lion/griffin/warrior/dashwick' 'Dashwick'
    "This griffin's face is marred by ragged talon-borne scars, leaving large
    patches without feather coverage.  His name is Dashwick and he doesn't seem very friendly.  Even so, you long to lick his beak -- it looks salty! "
    isProperName = true
    isHim = true
    defaultGreetingResponse(otherActor)
    {
        if (griffinDog.snifferDemoed)
        {
            "The warrior bows respectfully, but then turns his attention away to a complicated paper full of magic squiggles. Perhaps you should ask or tell him directly about whatever's on your mind?";
        }
        else 
        {
            "The warrior griffin does not deign to respond, instead fixing you with a withering gaze. <q>Away, you. We're busy looking for our lost cublet.</q> Perhaps he'd be friendlier
            if you managed to point them towards their quarry?";
        }
    }
    dobjFor(Lick)
    {
        verify(){}
        action() 
        {
            "Dashwick fixes you with a cold stare. <q>I do not want kisses. Please lavish your affections on someone else.</q>";
        }
    }
    
    dobjFor(Smell)
    {
        verify(){}
        action() 
        {
            inherited();
            mainReport('Dashwick takes a few steps away and chirps, <q>Is there something I can do for you?!</q> By way of answer, you move your questing snout back up to him and resume snuffling.');
        }
    }
      
;

++AskTellTopic '.*cublet.*outside|.*outside.*cublet|.*bush.*cublet|.*cublet.*bush|.*ground.*cublet|.*cublet.*ground|.*smell.*window|.*smell.*outside|.*smell.*bush.*|.*cublet.*window|.*window.*cublet'
    topicResponse()
    {
        if(!griffinDog.snifferDemoed)
        {
            "<q>Really?!  That's a bold claim, that our young one has been under our noses all this time.</q>  He eyes you skeptically.  <q>Go tell Scout; he's got the sharpest eyes of us all and will surely find the cublet if you're right.</q>";
        }
        else 
        {
            "<q>We already located the errant cublet.  Don't spread rumors that might excite people, please.</q>";
        }
    }
;

++AskTellTopic '.*cublet.*'
    "<q>Yes, we're busy looking for our lost one. Go play with the other cublets.</q>"
;

++AskTellTopic @salutationTopic
    "<q>Mm.</q>  Dashwick grunts dismissively."
;

++AskTellTopic, StopEventList @flightTopic
    ['<q>Snuff.  Snurf?</q>*Slightly intimidated by this buff fellow and his stern expression, you approach your questioning rather more cautiously than usual.*<.p>Dashwick levels a withering gaze at you.  <q>No, you cannot fly.  You are a land-based creature and you have neither wings nor any other means of conquering gravity.  It is hopeless; give up and stop wasting our time.</q>',

    'Dashwick refuses to acknowledge you further.']
;

+++AltTopic
    "Dashwick bows his beak to you respectfully.  <q>You've done us a great service in finding our missing cublet, Mr. Dog.  However, I still cannot help you to fly; you'll need a more inventive mind to figure this out.</q>"
    isActive = (griffinDog.snifferDemoed && griffinDogHarness.location != griffinDog) 
;

+++AltTopic 
    "<q>What a fascinating piece of equipment!</q>  Dashwick gushes over your harness.  <q>I'm afraid I don't know quite how it would be used, though.</q>"
    isActive = (griffinDog.snifferDemoed && griffinDogHarness.location == griffinDog) 
;

++GiveShowTopic @griffinDogHarness
    "<q>How curious.  I have little interest in inventions and similar idle matters; try the brainy ones.</q>  He nods towards Mallory and Fizzelump.";
;

+ wizardGriffin: Actor 'wise bird/lion/griffin/wizard/fizzelump' 'Fizzelump'
    "The wise wizard griffin Fizzelump eyes you curiously.  Her pointy hat with
    stars on is a bit too large and continuously slips down over her eyes, accounting for her perpetual side-to-side head tilting.  Also she's part bird. "
    isProperName = true
    isHer = true
    defaultGreetingResponse(otherActor)
    {
        if (griffinDog.snifferDemoed)
        {
            "The wizardly griffin's expressive eyes light up at your returned attention and she crows, <q>Why hello Mr. Dog! Welcome to our humble home.</q> 
            Apparently having exhausted her store of smalltalk, Fizzelump stares at you awkwardly. Your friendly joy doesn't allow for the concept of awkwardness, or 
            personal space, so you wag harder and play bow in invitation. Perhaps you should ask or tell her directly about whatever's on your mind?";
        }
        else
        {
            "The wizardly griffin tips her floppy hat to you, but her attention roams about the room. <q>We'll talk later, fuzzy buddy. Right now we're quite tied up searching for our missing cublet.</q> 
            Maybe you could help point them in the right direction?";
        }
    }
    dobjFor(Lick)
    {
        verify(){}
        action() 
        {
            "Fizzelump blushes and hides her beak in her plumage.";
        }
    }
    
    dobjFor(Smell)
    {
        verify(){}
        action() 
        {
            inherited();
            mainReport('<q>Whatcha smell, Mr. Ol\' Dog? I\'ve been working with some volatile compounds recently, so it might be better to sniff with the approved wafting motion or under a fume hood.</q>');
        }
    }
;   

++AskTellTopic '.*cublet.*outside|.*outside.*cublet|.*bush.*cublet|.*cublet.*bush|.*ground.*cublet|.*cublet.*ground|.*smell.*window|.*smell.*outside|.*smell.*bush.*|.*cublet.*window|.*window.*cublet'
    topicResponse()
    {
        if(!griffinDog.snifferDemoed)
        {
            "<q>The missing cublet is outside?  You've smelled him?</q>  Her eyes light up and she bounces on her talons.  <q>Quick quick, go tell Scout; he's our looker/finder-y person.</q>";
        }
        else 
        {
            "She smiles at you, whispering, <q>We already know how cool you are!  You needn't keep trying so hard.</q>";
        }
    }
;

++AskTellTopic '.*cublet.*'
    "<q>I've never quite been comfortable around the cublets, to be honest; not that I'm comfortable around most people...</q>  
    She squawks self-consciously and ruffles her feathers to try to cover it up. <q>As it happens, though, I'm quite comfy talking to you, Mr. Dog.</q> She eyes you quizzically, murmuring, 
    <q>What is your strange dog magic?</q>"
;

++AskTellTopic @salutationTopic
    "<q>Hiya mister dog!  Always great to meet a new species.</q>  Fizzelump smiles encouragingly at you, but doesn't seem to know how to proceed with the conversation."
;

++AskTellTopic @magicTopic
    "<q>Woof?</q> *Your question is understood to be on the nature of magic and its interconnection with the laws of nature.*
    <.p>She ponders for a moment.  <q>Well,</q> she says
    slowly, <q>I'm not sure I understand the question -- magic is a part of nature, after all, just like gravity and electricity.  The only difference is that magic is a little more expansive and flexible: all forms of matter and energy are networked by strings of subatomic particles called Quirks and by manipulating these we can affect more specific natural law and also 'invent' new natural law!  It might not stick around longer than we're attending to it, but it's no less real for that.  Some such grand constructs can even be made permanent!</q> Her eyes go distant for a moment and she shivers.  <q>It's well for all things that making new permanent natural law is not easy.</q>"
  ;

++AskTellTopic, StopEventList @flightTopic
    ['<q>Hruff!  Borf?</q>*You bounce up and down, wiggle your ears, and fix your laser-like gaze on her wings, clearly conveying your query regarding flight*<.p>Fizzelump fidgets and scratches a shapely haunch evasively.  <q>Yes, flying and so forth.  You\'re a lovely fellow and I\'d be delighted to help you realize a dream, but... there are certain hardware requirements.  Namely, wings or flaps or something.  I\'m afraid your people just aren\'t built for flight.</q>  She hangs her beak, looking down at her talons.',

    '<q>Sorry little dog, but there are some things even magic cannot accomplish.</q>'
    ]
;

+++AltTopic
    "Fizzelump blushes at your attention and, mastering herself, carefully leans down to fondly nuzzle your muzzle with her beak.  <q>Thank you thank you for finding our cublet!  Magic is amazing, but it pales in comparison to the majesty that is dog.  You're so brave and talented, I'm sure we can figure something out to help you fly.  Look around and we'll do the same -- maybe the solution is right in front of us!</q>"
    isActive = (griffinDog.snifferDemoed && griffinDogHarness.location != griffinDog) 
;

+++AltTopic 
    "<q>Ooh hey, that harness-y thingamajig might just work! I, uh, I'm not the best with artifice, however.  My jam is more sparkles and stupendous sounds and explosions!  Maybe Mallory could help?</q>"
    isActive = (griffinDog.snifferDemoed && griffinDogHarness.location == griffinDog) 
;

++GiveShowTopic @griffinDogHarness
    "<q>Oooh neat-o!  I don't really do hardware stuffs though, so I'm not sure what to make of it.  Maybe try our clever Mallory-gal?</q>";
;

+ cubletGriffins: Actor 'cubs/cublets/babies/pups/puppies' 'Cublets'
    "Several cute griffin cublets amble about the aery, snuffling, questing, playing, and generally being frolicsome. You give one a sniff and it flaps up to land on your head, intending to ride you around for a bit; it's little claws give lovely scritches, and you rumble your approval."
    isProperName = false
    isHer = true
    isHim = true
    isPlural = true
    defaultGreetingResponse(otherActor)
    {
        "The cublets are much too busy playing and creating havoc to listen. You nod in fuzzily sage approval of their grand works.";
    }
    dobjFor(PlayWith)
    {
        verify(){}
        action() 
        {
            "You and the cublets bounce around and chase each other until you all tire and collapse in a fuzzy/feathery heap, transitioning to a good game of bitey-face since it doesn't require movement.";
        }
    }
    dobjFor(Lick)
    {
        verify(){}
        action() 
        {
            "The cublets laugh and squirm joyfully as you groom them.";
        }
    }
    
    dobjFor(Smell)
    {
        verify(){}
        action() 
        {
            inherited();
            mainReport('The cublets sniff you right back, and you form a fuzzy/feathery Ouroboros for a time. Infinite smell!');
        }
    }
; 

+ matronGriffin: Actor 'kindly bird/lion/griffin/matron/mother/warkmana' 'Warkmana'
    "Pacing back and forth, the kindly griffin Warkmana seems too distracted to pay you any mind at the moment.  You can smell that if she had long floppy ears like yours, they would be scrunched up close together with worry. "
    isProperName = true
    isHer = true
    defaultGreetingResponse(otherActor)
    {
        if (griffinDog.snifferDemoed)
        {
            "The matronly griffin is too distracted chasing after her cublet charges to engage in chitchat. Perhaps you should ask or tell her directly about whatever's on your mind?";
        }
        else
        {
            "<q>No time, no time to chat! We must find the lost cublet immediately!</q> Perhaps you could help point them in the right direction?";
        }
    }
    dobjFor(Lick)
    {
        verify(){}
        action() 
        {
            "A wistful smile spreads over Warkmana's beak and a little tear forms in her eye. <q>My lost little one loves kisses. Oh I hope we find him soon!</q>";
        }
    }
    
    dobjFor(Smell)
    {
        verify(){}
        action() 
        {
            inherited();
            mainReport('Warkmana smells like the cublets plus exhaustion. You reflect that perhaps being neutered isn\'t so bad after all.');
        }
    }
;

++AskTellTopic '.*cublet.*outside|.*outside.*cublet|.*bush.*cublet|.*cublet.*bush|.*ground.*cublet|.*cublet.*ground|.*smell.*window|.*smell.*outside|.*smell.*bush.*|.*cublet.*window|.*window.*cublet'
    topicResponse()
    {
        if(!griffinDog.snifferDemoed)
        {
            "<q>Ehwot?!  The cublet is outside?  Well go and tell Scout right away; the poor dear could be in danger out there!</q>";
        }
        else 
        {
            "Warkmana's eyes go wide for a moment, then she quickly counts the cublets and seems to relax.  <q>Nope, all accounted for.</q>";
        }
    }
;

++AskTellTopic '.*cublet.*'
    "<q>Oh, how could I have let one go missing?</q> She frets, too distressed to discuss her brood in general."
;

++AskTellTopic @salutationTopic
    "Warkmana spares you a harried glance before returning to searching beneath hay and blankets and cublets for something.  <q>Yes, yes, hello and so forth.  I'm rather busy for pleasantries at the moment.</q>"
;

++AskTellTopic, StopEventList @flightTopic
    ['<q>Chuff!  Snort?</q>*You sneeze and snort to clear your sniffer, and then assess Warkmana\'s mood.  She\'s upset, which doesn\'t bode well for your questioning.  Still, you whine and paw at her wings, wagering that she might appreciate a distraction.*<.p>Warkmana, looking stressed and distracted, shakes her head dismissively at you. <q>No no, don\'t be silly.  You\'re a dog, of course you can\'t fly!  If you\'ll excuse me, I\'ve got an errant cublet to find.</q>',

    'Warkmana is too busy searching under everything and shooing cublets out of her path to listen.'
    ]
;

+++AltTopic
    "Wrapping her wings about you in an avian hug, Warkmana smothers you with affectionate nips and licks for a solid minute.  <q>You found her, you found my little Muffynx!  I don't know what we would have done without your sniffer.  I'll do anything to help you, but I don't know how to make a dog fly.</q>  She looks pained as she pulls away from you.  <q>Try asking our brainy types, Fizzelump and Mallory; they're the creative problem solvers around here.</q>"
    isActive = (griffinDog.snifferDemoed && griffinDogHarness.location != griffinDog) 
;

+++AltTopic 
    "<q>Say, that contraption looks promising!  I think.  Perhaps Mallory or Fizzelump would know what to do with it?</q>"
    isActive = (griffinDog.snifferDemoed && griffinDogHarness.location == griffinDog) 
;

++GiveShowTopic @griffinDogHarness
    "<q>What's that for?  I have little time for games or toys, unless that's intended for the cublets.</q>  She rushes off after a cublet on its merry way toward certain death in the fireplace before you can respond.";
;

+ librarianGriffin: Actor 'nerd bird/lion/griffin/librarian/mallory' 'Mallory'
    "With practiced grace and the utmost care, this giant griffin turns the pages of a musty tome with a jet-black talon.  Her name is Mallory, and her attention is entirely absorbed by her book.  Hrumph -- If they could make a book with a smelly interface, you'd be an avid reader too. "
    isProperName = true
    isHer = true
    /* Indicates whether or not Mallory has been functionally disturbed by conversation with the player */
    poked = nil
    defaultGreetingResponse(otherActor)
    {
        if (griffinDog.snifferDemoed)
        {
            "The librarian griffin eyes you owlishly over the top of thick spectacles. <q>Is there something I can do for you?</q>. 
            Without waiting for a reply, she promptly returns to her reading. Perhaps you should ask or tell her directly about whatever's on your mind?";
        }
        else
        {
            "The librarian griffin pushes a logbook towards you with her mighty clawed paw. <q>Please sign in with the current time and you'll be notified when I'm available to speak.
            With our cublet missing I don't anticipate that will be anytime soon, sad to say.</q> Perhaps you could expedite your appointment if you point them in the right direction?";
        }
    }
    dobjFor(Lick)
    {
        verify(){}
        action() 
        {
            "Mallory hums as you rain kisses upon her. <q>More to the left, please.</q>";
        }
    }
    
    dobjFor(Smell)
    {
        verify(){}
        action() 
        {
            inherited();
            mainReport('Mallory peers at your sniffer with interest. <q>My word, where does all that scent data go? Do you catalogue it all in your noggin? I wonder if we could export it somehow...</q> Not much caring for where this is headed, you bork and bound away.');
        }
    }
;

++AskTellTopic '.*cublet.*outside|.*outside.*cublet|.*bush.*cublet|.*cublet.*bush|.*ground.*cublet|.*cublet.*ground|.*smell.*window|.*smell.*outside|.*smell.*bush.*|.*cublet.*window|.*window.*cublet'
    topicResponse()
    {
        if(!griffinDog.snifferDemoed)
        {
            "Mallory looks up from her book with an anxious gleam in her eye, her attention clearly and uncharacteristically completely separated from her work.  <q>You think you've spotted the cublet?!  Get Scout to fetch him -- quickly, please!</q>";
        }
        else 
        {
            "<q>No no, you already found the missing one for us.  There can't be more than one cublet crisis in a given day; it isn't allowed!</q>  Her eyes twitch slightly and she somehow manages to read with fierce determination.";
        }
    }
;

++AskTellTopic '.*cublet.*'
    "<q>We all love the cublets, of course, but they do manage to be forever sticky somehow, which is suboptimal for the books!</q> She pulls her book to her breast, protectively."
;

++AskTellTopic @salutationTopic
    "Without looking up from her studies, Mallory points a talon at a sign beside her.  You can't read it, but you discern it states something about not disturbing the scholar at her work without a specific reason."
;

++AskTellTopic @flightTopic
    topicResponse
    {
        if(griffinDog.snifferDemoed && griffinDogHarness.location == griffinDog)
        {
            mainReport(griffinDog.victoryBlurb);
            finishGameMsg(ftVictory, [finishOptionCredits]);
        } 
        else if(!librarianGriffin.poked)
        {
            mainReport('<q>Hawooooo wooo woo roo wuf.  Arf?</q>*Seeing that she\'s distracted by her magical squiggles, you howl joyfully to get her attention.  As she looks up to see what\'s making noise you give her your best doggy grin, panting with enthusiasm.*<.p><q>Hmm? Flying?  Yes, we can fly.  Oh, you want to learn to fly?</q>  She peers at you, blinking owlishly, and abruptly twists her head around 180 degrees.  <q>How curious.  I\'ve never heard of a dog who could fly, and the aerodynamics would be quite challenging.  That said, all things are possible with enough ingenuity!  I would be interested in joining your project, but... I\'m right in the middle of a fascinating book which compels SEVERAL research projects.</q>  Nipping at her plumage, she extracts an appointment book from someplace.  She consults it for a moment, then flips many many pages and pecks a codified sequence into a date.  <q>I\'ve penciled you in.  Return 700 years from this day; I\'m free for a bit then.</q>  Returning to her book, Mallory misses your ears drooping sadly.');
            librarianGriffin.poked = true;
        } 
        else
        {
            mainReport('Mallory\'s attention is consumed by her reading, and she is unavailable to the world.');
        }
    }
;

++GiveShowTopic @griffinDogHarness
    topicResponse
    {
        if(griffinDog.snifferDemoed)
        {
            mainReport(griffinDog.victoryBlurb);
            addToScore(5, 'flight of The Griffin!');
            mainReport('\n\n');
            libScore.showFullScore();
            finishGameMsg(ftVictory, [finishOptionCredits]);
        }
        else
        {
            "Mallory seems totally lost in her book.  Though she puts forth an aloof facade, you sense she is deeply troubled by something.";
        }
    }
;

/*
 *   The sturdy rope, one component of the griffin-dog harness.  We make this
 *   a Thing, because we want it to be something the player can pick up
 *   and manipulate.
 *   
 *    
 */
+ sturdyRope: Thing 'old sturdy hempen rope/twine/bindings/rope' 'rope'
    "A coil of sturdy rope, well-worn and proven from heavy use."

    dobjFor(UseOn)
    {
        verify()
        {
            if(gIobj != quadrupedStand)
            {
                illogical('It wouldn\'t be very nice to tie up {the iobj/him/her}... at least without permission.');
            }
        }
        action()
        {
            /* inherit the default handling */
            inherited();

            /* make dog harness and give to Griffin */
            griffinDogHarness.makeDogHarness();
        }
    }

    iobjFor(UseOn)
    {
        verify()
        {
            if(gDobj != quadrupedStand)
            {
                illogical('{The dobj/he/she} can\'t combine directly with the rope');
            }
        }
        action()
        {
            /* inherit the default handling */
            inherited();

            /* make dog harness and give to Griffin */
            griffinDogHarness.makeDogHarness();
        }
    }
    
    dobjFor(Lick)
    {
        verify(){}
        action() 
        {
            "Tastes like connections!";
        }
    }
    
    dobjFor(Smell)
    {
        verify(){}
        action() 
        {
            inherited();
            mainReport('Smells like an old barn mixed with properly dogged industry.');
        }
    }
;

+ spellBook: Thing 'spells/book/spell book/grimoire' 'spell book'
    "Some sort of book, with fanciful trim and similar frills.  Smells of Fizzelump, which is to say the scent of enthusiasm pleasantly underscored by cozy mustiness.  Filled with squiggles."
    
    dobjFor(Lick)
    {
        verify(){}
        action() 
        {
            "The book tastes mildly of cow, but not quite enough to peak your interest. Plus Fizzelump is watching.";
        }
    }
    
    dobjFor(Smell)
    {
        verify(){}
        action() 
        {
            inherited();
            mainReport('The book smells like a cozy library, one of your very favorite nap spots! Just thinking about the last time you curled up at the paws of someone reading has you...zzzz');
        }
    }
;

+ eldritchStick: Thing 'stick/eldritch stick/staff' 'mesmerizing stick'
    "This stick is just fascinating... normally such mundane chewy implements are beneath your notice, but this one keeps drawing your snout with all the magnetism of a squirrel!"
    dobjFor(Chew)
     {
        verify(){}
        action() 
        {
            local stickMessage = 'Delicious!  Sparks fly from stick whenever you bite down, pleasantly warming your gums as you go to town.  Each spark has a different color and smell, and each is just the best thing.  You notice Fizzelump wincing at each loud *CROMCH* of the stick, but she says nothing. ';
            switch(rand(7)) {
                /*prefab cases*/
                case 0: stickMessage += 'Your favorite spark, the purple one, dances merrily forth from the stick.  It smells of snoozing and fondness -- it\'s the smell of your human!'; break;
                case 1: stickMessage += 'Golden spark spork out of the stick, startling you slightly.  They smell of gremlins and human magic.  You furrow your furry brow at them admonishingly, then return to your work upon the stick.'; break;
                case 2: stickMessage += '*SWOOSH* verdant green sparks explode from the stick as it jumps in your jaws, filling your snoot with a subtle and pleasant puff of pine needles freshly fallen upon the undisturbed first snow of winter just as dawn illuminates them.  Calmly, you whack a heavy paw down over it such that your important chewing progress is not interrupted.'; break;
                case 3: stickMessage += 'In a sapphire flash, two butterflies composed entirely of the soothing translucent aquamarine of a warm tropical lagoon flap into being from the knots near the top of the stick where your jaws are currently clamped.  They smell of discovery and life and the infinitude of hope promised to the living thereby.  You pause a moment to watch them frolic, perfectly content, and then return to work.'; break;
                case 4: stickMessage += 'With a mighty *FWOOSH*, a massive gout of scarlet flames tinged with threads of emerald spouts from the top of the stick.  Luckily these do not burn, and in fact feel rather like a warm breeze ruffling your whiskers.  Further, these glorious blooms of comforting light smell of the SNUGGLIEST stuffed toy.  You put your chewing on hold for a moment to lick all trace of the lovey flames from the stick.  For four hours.'; break;
                /*rando generated cases*/
                case 5: stickMessage += 'Opalescent sparks smelling of all creation jump from each knothole on the stick at once.  As you watch curiously and carefully, they converge and form a ' + generateRandomGoodNoun() + ' before you.  Merrily, you ' + generateRandomVerb() + ' it.'; break;
                case 6: stickMessage += 'Smelly green and yellow sparks reminiscent of bile ooze from stick, prompting you to pull back quickly.  A fell ' + generateRandomBadNoun() + ' squirms into your reality from someplace foul, and you have little choice but to ' + generateRandomVerb() + ' it.'; break;
            }
            mainReport(stickMessage);
            griffinDog.chewCount++;
            if (griffinDog.chewCount == 3)
            {
                addToScore(5, 'tenacious chewer');
            }
        }
     }
     generateRandomGoodNoun()
     {
         local goodThing = 'Tennis Ball';
         switch(rand(10))
         {
             case 0: goodThing = 'Snuggly Stuffed Thing'; break;
             case 1: goodThing = 'Unguarded Bone'; break;
             case 2: goodThing = 'Antler'; break;
             case 3: goodThing = 'FOOOD'; break;
             case 4: goodThing = 'Treats'; break;
             case 5: goodThing = 'Uneaten Bed'; break;
             case 6: goodThing = 'Sheets Smelling of Human'; break;
             case 7: goodThing = 'The Human\'s Socks'; break;
             case 8: goodThing = 'DOG!'; break;
             case 9: goodThing = 'CAT!'; break;
         }
         return goodThing;
     }
     generateRandomBadNoun()
     {
         switch(rand(7))
         {
             case 0: return 'Thermometer'; break;
             case 1: return 'Gremlin'; break;
             case 2: return 'SQUIRREL'; break;
             case 3: return 'BIRD'; break;
             case 4: return 'Loud Noise'; break;
             case 5: return 'Forbidden Food'; break;
             case 6: return 'DOG WITH WRONG SMELL'; break;
             default: return 'DOG SIGNAL'; break;
         }
     }
     generateRandomVerb()
     {
         switch(rand(7))
         {
             case 0: return 'Hoover'; break;
             case 1: return 'Lick Vigorously'; break;
             case 2: return 'Chase Enthusiastically'; break;
             case 3: return 'Whack w/ Soft Massive Paw'; break;
             case 4: return 'Place Jaws Around'; break;
             case 5: return 'Bark at'; break;
             case 6: return 'Wag Tail in Circles before'; break;
             default: return 'Love Unconditionally and Completely upon'; break;
         }
     }
    
    dobjFor(Lick)
    {
        verify(){}
        action() 
        {
            "Like all sticks, this one has a unique and complex flavor. It tastes of sunsets and mown grasses, of hay and horses and a crackling hearth. Watta good stick!";
        }
    }
    
    dobjFor(Smell)
    {
        verify(){}
        action() 
        {
            inherited();
            mainReport('The stick smells like Fizzelump for the most part, though there\'s more than a dash of eldritch planes of existence on it. Every dog knows the smell of ghosts and gods, and this stick has it in spades!');
        }
    }

;

/*
 *   The crate is a Fixture, since we don't want the player to be able to
 *   move it.  It's also an OpenableContainer, because we want the player
 *   to be able to open and close it and put things in it.
 *   
 *   Because we're an OpenableContainer, the library will automatically add
 *   to our description text an open or closed indication and a listing of any
 *   contents when we're open.  
 */
+ box: OpenableContainer 'splintery crate/box/chest' 'crate'
    "It's a huge black box, with a front door that swings
    open sideways.  The couriers have thoughtfully provided a groove suitable for paw or muzzle nudging-open. "
;

/*
 *   Put the inexplicable quadruped stand in the crate. 
 */
++ quadrupedStand: Thing 'inexplicable quadruped stand/platform/stand/saddle' 'Quadruped Support Platform'
    "No one remembers who ordered this strange saddle-like static mesh of hard leather apparently intended to secure a four-footed creature atop another creature.  Handy, though! "

    /* 
     *   we want to provide a special message when we use the stand on the rope, so
     *   override the direct object action handler for the Use action;
     *   inherit the default handling, but also display our special
     *   message, which will automatically override the default message
     *   that the base class produces.  Then add the GriffinDogHarness to player inventory. 
     */
    dobjFor(UseOn)
    {
        verify()
        {
            if(gIobj != sturdyRope)
            {
                illogical('{The dobj} can\'t combine directly with {the iobj/him/her}');
            }
        }
        action()
        {
            /* inherit the default handling */
            inherited();

            /* make dog harness and give to Griffin */
            griffinDogHarness.makeDogHarness();
        }
    }

    iobjFor(UseOn)
    {
        verify()
        {
            if(gDobj != sturdyRope)
            {
                illogical('{The dobj/he/she} can\'t combine directly with {the iobj}');
            }
        }
        action()
        {
            /* inherit the default handling */
            inherited();

            /* make dog harness and give to Griffin */
            griffinDogHarness.makeDogHarness();
        }
    }
;



griffinDogHarness: Thing 'griffin dog harness/dog harness/harness/platform/saddle' 'Griffin-Dog Harness'
    "The griffin-dog harness provides a lovely interface allowing a dog to
    safely ride a griffin in flight."
    makeDogHarness()
    {
        if(!self.bHarnessMade)
        {
            self.bHarnessMade = true;

            /* show our special description */
            "With a little ingenuity and many fervent wishes for thumbs, you manage to connect the rope to the stand.  This creates a sort of makeshift harness, in which you could be secured snuggle-y. 
            You tuck the fancy harness away in your compartment.";

            /* move harness to dog */
            self.moveInto(griffinDog);

            /* remove sturdy rope and stand since they were combined into the harness */
            sturdyRope.moveInto(nil);
            quadrupedStand.moveInto(nil);
           
            addToScore(5, 'puppy flying harness constructed');
        }
    }
    bHarnessMade = nil
;

/*
 *   Define the player character.  The name of this object is not
 *   important, but note that it has to match up with the name we use in
 *   the main() routine to initialize the game, below.
 *   
 *   Note that we aren't required to define any vocabulary or description
 *   for this object, because the class Actor, defined in the library,
 *   automatically provides the appropriate definitions for an Actor when
 *   the Actor is serving as the player character.  Note also that we
 *   don't have to do anything special in this object definition to make
 *   the Actor the player character; any Actor can serve as the player
 *   character, and we'll establish this one as the PC in main(), below.  
 */
griffinDog: Actor
    /* the initial location is the entryway */
    location = aery
    bCubletSmelled = nil
    smellyDaemonId = nil
    
    /* after any action, try to register the daemon.  For some reason simply reging the daemon as a property directly did not work */
    afterAction()
    {
        /* create or recreate the daemon iff it is not active AND we have not already demoed the sniffer, which is the switch indicating the rogue cublet has been found.  If the cublet had already been found, there's no further need for the daemon */
        if(smellyDaemonId == nil && !self.snifferDemoed)
        {
            smellyDaemonId = new Daemon(self, &processSmellyDaemon, 1);
        }
    }
    
    defaultGreetingResponse(otherActor)
    {
        "You bork and howl celebration for the sheer joy of raising your voice in the song of your people!";
    }

    processSmellyDaemon
    {
        switch(rand(6))
        {
            case 0: "Most of the different things around the aery tower are tightly grouped, forming pockets of intense categorical scent.  You can smell an exception outside, however, a whiff reminiscent of the Warkmana from the bushes at the base of the tower. \n"; 
            bCubletSmelled = true; 
            break; 
            case 1: "Your ears prick up slightly as a faint high-pitched whisper, perhaps the ghost of a cry, wafts in from the high windows.  Pointing your sniffer in the direction of the sound, you pick out the scent of eggshells and wet feathers mixed in with a much stronger scent of holly leaves from the ground far, far below. \n";
            bCubletSmelled = true; 
            break; 
            case 2: "A griffin cublet ambles by, warking softly, and falls flat on its belly after bumping into Warkmana's right rear paw.  You're stricken by how very much it does not smell of holly, in contrast to a similar scent that tickles your snoot from outside. \n"; 
            bCubletSmelled = true; 
            break; 
            case 3: self.bCubletSmelled = nil; break;
            case 4: self.bCubletSmelled = nil; break;
            case 4: self.bCubletSmelled = nil; break;
        }
    }

    endDaemon()
    {
        if(smellyDaemonId != nil)
        {
            smellyDaemonId.removeEvent();
            smellyDaemonId = nil;
        }
    }

    /*
    * Mr. Griffin needs to show off his sniffing skillz to impress the griffins
    */
    snifferDemoed = nil
    
    /*
     * Tracks number of times the stick was chewed upon
     */
    chewCount = 0

    /*
     * Message to be displayed when the user has hit the victory condition
     */
    victoryBlurb = 'Her interest finally piqued by the smell of leather and hemp in a complex configuration, the smell of prototyping, Mallory looks up from her studies.  <q>Ah, now that\'s a pretty thing.  Hmm, yes I see -- your little hooves or paws or some such would fit inside the cuffs here with a loop \'round your middle.  The harness would fasten over a griffin\'s body here with the rope securing it there and there... It might just work!  I\'m interested now, and we must see this experiment through to fruition.  Come!  I will help you hook up one of the others, mm, Scout, for testing.</q><.p>And lo, that day a dog did fly: Mallory and Fizzelump collaborated to hook your dog harness invention up to Scout, who gladly submitted to the experiment.  Once he was fitted properly, they boosted you up on his back and secured you in the harness; with its radially free-floating design, you can move about around his back and even underneath his belly to get the best angle for smelling out intriguing scent vectors.  Your first flight together is magical, with the open sky and jealous birds being more than you\'d ever dared to hope for.  Possibilities for exploration and discovery abound, but more importantly your ears and tongue may flap frantically in the high-atmosphere, high-velocity winds of total freedom.  Scout was astounded at the accuracy of your sniffer in picking out details his keen eyes missed, and his scouting mission brought back more info than ever before.  The thrill of flight was so intoxicating that your propeller tail actually wagged you off the surface of Scout\'s back a few times, a phenomenon he took note of carefully.  Once back at the Aery, he asked Mallory and Fizzelump to tutor you on the basics of aerodynamics and in no time at all you were able to achieve a sort of helicopter-y flight on your own via the boundless energy of your wagging tail.  It\'s still rather faster to fly atop the griffins, but your acumen and unique talents have in every way earned you the title of Littlest Griffin.';
; 

/*
 *   The "gameMain" object lets us set the initial player character and
 *   control the game's startup procedure.  Every game must define this
 *   object.  For convenience, we inherit from the library's GameMainDef
 *   class, which defines suitable defaults for most of this object's
 *   required methods and properties.  
 */
gameMain: GameMainDef
    initialPlayerChar = griffinDog
    scoreRankTable =
        [
         [ 0, 'A Silly Puppy, Indeed'],
         [ 5, 'A Fuzzy Scholar!'],
         [ 10, 'Bestdog!'],
         [ 15, 'Mighty Ol\' Mutt!'],   
         [ 20, 'Griffin, Prince of All Dogs!']
        ]
    maxScore = 20


    /* 
     *   Show our introductory message.  This is displayed just before the
     *   game starts.  Most games will want to show a prologue here,
     *   setting up the situation for the player, and show the title of the
     *   game.  
     */
    showIntro()
    {
        "Welcome to the tale and tail of The Littlest Griffin!  You play as the illustrious Mr. Griffin, a dog who longs to fly, and who has approached the mighty half-lion half-eagle griffins seeking flying lessons.  Start by asking your new and instantly beloved friends about flying!\b";
    }

    /* 
     *   Show the "goodbye" message.  This is displayed on our way out,
     *   after the user quits the game.  You don't have to display anything
     *   here, but many games display something here to acknowledge that
     *   the player is ending the session.  
     */
    showGoodbye()
    {
        "<.p>Thanks for playing! *too happy to wag along only one axis -- tail wags in circles*\b";
    }
;
