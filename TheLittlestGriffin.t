#charset "us-ascii"

/**
Brainstorming:
-very simple scenario:
    --Griffin keeps noticing the smell of a baby griffin from outside the aery and beneath some scrub brush. 
    --the griffins talk about a child going missing, one of the reasons they're impatient with Griffin's request to learn to fly.
    --puzzle 1 is that player needs to tell them he can smell and find a baby griffin nearby apart from all the rest, which makes them grateful and interests
      Scout in Griffin's sniffer.
    --puzzle 2 is that Griffin must use the Ropes on the Inexplicable Quadraped Stand to create a griffin-dog harness.
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
    version = '1'
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
        "This game was created to evalutate TADS 3. Also, to immortalize Mr. Griffin, Friendliest of Hounds.";
    }
;

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
            ", dog-style quadraped harness rigged up and ready to go 'round his middle',";
    }
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
;

+ wizardGriffin: Actor 'wise bird/lion/griffin/wizard/fizzelump' 'Fizzelump'
    "The wise wizard griffin Fizzelump eyes you curiously.  Her pointy hat with
    stars on is a bit too large and continuously slips down over her eyes, accounting for her perpetual side-to-side head tilting.  Also she's part bird. "
;    

+ matronGriffin: Actor 'kindly bird/lion/griffin/matron/mother/warkmana' 'Warkmana'
    "Pacing back and forth, the kindly griffin Warkmana seems too distracted to pay you any mind at the moment.  You can smell that if she had long floppy ears like yours, they would be scrunched up close together with worry. "
;

+ librarianGriffin: Actor 'nerd bird/lion/griffin/librarian/mallory' 'Mallory'
    "With practiced grace and the utmost care, this giant griffin turns the pages of a musty tome with a jet-black talon.  Her name is Mallory, and her attention is entirely absorbed by her book.  Hrumph -- If they could make a book with a smelly interface, you'd be an avid reader too. "
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
;

/*
 *   The stove is a Fixture, since we don't want the player to be able to
 *   move it.  It's also an OpenableContainer, because we want the player
 *   to be able to open and close it and put things in it.
 *   
 *   Note that we define 'stove' as both an adjective and as a noun,
 *   because we want the player to be able to refer to it not only as a
 *   "stove" but also as a "stove door".
 *   
 *   Because we're an OpenableContainer, the library will automatically add
 *   to our description text an open/closed indication and a listing of any
 *   contents when we're open.  
 */
+ Fixture, OpenableContainer
    'splintery crate/box/chest' 'crate'
    "It's a huge black box, with a front door that swings
    open sideways.  The couriers have thoughtfully provided a groove suitable for paw or muzzle nudging-open. "

    /* it's initially closed */
    initiallyOpen = nil
;

/*
 *   Put the inexplicable quadraped stand in the crate. 
 */
++ quadrapedStand: Thing 'inexplicable quadraped stand/platform/stand' 'stand'
    "No one remembers who ordered this strange static mesh of hard leather apparently intended to secure a four-footed creature to a surface.  Handy, though! "

    /* 
     *   we want to provide a special message when we use the stand on the rope, so
     *   override the direct object action handler for the Use action;
     *   inherit the default handling, but also display our special
     *   message, which will automatically override the default message
     *   that the base class produces.  Then add the GriffinDogHarness to player inventory. 
     */
    dobjFor(Use)
    {
        action()
        {
            /* inherit the default handling */
            inherited();

            // todo: how do we check what object the current object was used on?

            /* show our special description */
            "With a little ingenuity and many fervent wishes for thumbs, you manage to connect the rope to the stand.  This creates a sort of makeshift harness, in which you could be secured snuggle-y. ";

            // todo: how do we dynamically create and/or add a static object to the player inventory?
        }
    }
;

griffinDogHarness: Thing 'griffin dog harness/dog harness/harness' 'harness'
    "The griffin-dog harness provides a lovely interface allowing a dog to
    safely ride a griffin in flight."
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
    smellyDaemonId = new Daemon(self, &processSmellyDaemon, 1)
    smellyDaemon
    {
        switch(rand(3))
        {
            // todo: only report smell on some set interval instead of every turn, and
            // griffins must be told to look for the cublet on one of those turns (reflecting the possibility of cublet moving around in the bushes?)
            case 0: "Most of the different things around the aery tower are tightly grouped, forming pockets of intense categorical scent.  You can smell an exception outside, however, a whiff reminiscent of the Warkmana from the bushes at the base of the tower."; break; 
            case 1: "Your ears prick up slightly as a faint high-pitched whisper, perhaps the ghost of a cry, wafts in from the high windows.  Pointing your sniffer in the direction of the sound, you pick out the scent of eggshells and wet feathers mixed in with a much stronger scent of holly leaves from the ground far, far below."; break;
            case 2: "A griffin cublet ambles by, warking softly, and falls flat on its belly after bumping into Warkmana's right rear paw.  You're stricken by how very much it does not smell of holly, in contrast to a similar scent that tickles your snoot from outside."; break;
        }
    }
    /*
    * Mr. Griffin needs to show off his sniffing skillz to impress the griffins
    */
    snifferDemoed = false
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

    /* 
     *   Show our introductory message.  This is displayed just before the
     *   game starts.  Most games will want to show a prologue here,
     *   setting up the situation for the player, and show the title of the
     *   game.  
     */
    showIntro()
    {
        "Welcome to the tale and tail of The Littlest Griffin!  You play a dog who longs to fly, and who has approached the mighty half-lion half-eagle griffins seeking flying lessons.\b";
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
