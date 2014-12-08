JSEventAPI
==========

Trying to get millions of events, performers, and venues into your app? Eventful API allows for you to query from their API to receive data but dealing with URL can be messy and a hassle. JSEventAPI handles all that for you! Just specify your location and it will find all events nearby.

<h2>Note</h2>
Before using this API Helper class you must get an API Key from Eventful's API web page... It takes no more than a couple minutes and theirs no approval wait time. You just get one once you enter in some information about the application your going to be pulling events for.

<h2>Usage</h2>

<h3>Basic Usage</h3>
If you want to get events for your city, you can do it like so...

```Objective-C

    JSEventAPI *eventAPI = [JSEventAPI sharedInstance];
    [eventAPI setApiKey:kJSEventAPIKey];
    [[JSEventAPI sharedInstance] queryForEventsWithKeywords:nil geoCoords:nil location:@"San Francisco, CA" date:nil category:nil withinRadius:nil radiusMetric:nil sortByType:nil sortDirection:nil censored:nil block:^(NSArray *objects, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
            return;
        }
        
        for (JSEventObject *obj in objects) {
            NSLog(@"%@", obj.objects);
        }

    }];
```

What you get back is a list of JSEventObjects that contains a bunch of details and properties about the event.

```
2014-12-07 23:54:20.354 Example[12670:864937] {
    cityName = "San Francisco";
    countryName = "United States";
    dateCreated = "2014-11-15 17:06:34 +0000";
    dateModified = "2014-11-29 07:28:21 +0000";
    description = " This event is 21 and over <br>Bebel Gilberto<br><ul><li><a href=\"http://www.bebelgilberto.com/\" rel=\"nofollow\">Website</a><li><a href=\"http://www.myspace.com/bebelgilberto\" rel=\"nofollow\">MySpace</a><li><a href=\"https://www.facebook.com/bebelgilbertooficial\" rel=\"nofollow\">Facebook</a><li><a href=\"http://www.twitter.com/bebelgilberto\" rel=\"nofollow\">Twitter</a></li></li></li></li></ul><ul><li><a href=\"http://www.bimbos365club.com/event/719433-bebel-gilberto-san-francisco/#tfly-more-1\" rel=\"nofollow\">Links</a></li></ul><br>The multi-Grammy-nominated Bebel Gilberto has just released her new album Tudo on Sony Masterworks; her first studio recording in five years. Tudo, which means \U201ceverything\U201d in English, showcases Bebel\U2019s ethereal vocals and wistful, dreamy song writing in each of the CD\U2019s 12 tracks. Bebel splits her time between Rio de Janeiro and New York City; she\U2019s exquisitely synthesized musical influences from both cities in every track. Bebel\U2019s sultry tonality is constant throughout Tudo as are the warm and playful Brazilian rhythms that include the berimbau, wood bongos and shakers. The gorgeous melodies are shaped by touches of electronica, and Bebel\U2019s intimate vocals hint at a fantastical Rio de Janeiro.<br><br> Bebel had been tucking away musical gems over the past five years, from joyful melodies, to reflective, romantic lyrics, which appear on Tudo. In 2013 while working in Brazil on the Bebel Gilberto in Rio DVD, the rhythms began stirring inside her. Although she\U2019d been ordered to rest in order to combat exhaustion, Bebel believed it was the right time to record; she knew the music would be strong. Despite the challenges 2013 brought, \U201cI\U2019m a good bon vivant,\U201d assured Bebel who always finds time for friends, attending to her rooftop garden overlooking Manhattan\U2019s skyline, or walking on the beach, \U201cI know how to live.\U201d Tudo is perhaps Bebel\U2019s most intimate recording, captures the human vulnerabilities that bring both sorrows and joy.<br><br> Tudo was recorded in Brazil, New York City, and Los Angeles; produced and mixed by Mario Caldato Jr in early 2014. Bebel was able to gather her favorite musicians from all over the globe, liberally using the words \U201camazing,\U201d \U201cbeautiful,\U201d \U201cheaven,\U201d \U201ca luxury!\U201d to describe their talents and contributions to Tudo. Bebel chose to work with the producer Mario Caldato Jr. because, as she put it, \U201cI\U2019m so eclectic, I needed one producer to translate it all.\U201d<br><br> Gilberto was born in New York to Brazilian music icons Jo\U00e3o Gilberto and Mi\U00facha. Her musical education was her childhood in Brazil. She was surrounded by extended family including her uncle Chico Buarque and family friends like Milton Nacimento, Tom Jobim, Caetano Veloso, and Jo\U00e3o Donato; she made her first recording at age 7. \U201cI just turned 48, so it\U2019s been 41 years!\U201d exclaims Bebel with a laugh, \U201cI\U2019m really proud, but tired too!\U201d<br><br> Bebel\U2019s life-long eclectic musical tastes are made palpable when listening to Tudo. In addition to living and breathing all types of Brazilian musical styles as a child, she was exposed to the greats, from Debussy to Prince; Michel Legrand to Billie Holliday; Bjork to Gershwin. Also evident on Tudo some tracks for than others, is her love for North American soul; she discovered Donna Summer, Earth Wind and Fire, and Michael Jackson on the dance floor as a budding teenager. \U201cThe whole disco thing plays a big role in my heart,\U201d says Bebel, who still loves to dance.<br><br> Several years after Bebel moved to New York City in 1991 her present day sound of electronic meets Brazilian began to crystallize. \U201cLittle by little, I learned what I wanted musically,\U201d says Bebel, who gigged all around the city and collaborated with many artists. She established a weekly gig at The Greatest Bar on Earth, on top of the Worldtrade Center in the early 1990\U2019s that drew a fervent international crowd. \U201cAt that gig, everything started to come together,\U201d says Bebel. \U201cI think there I became a New Yorker\U2014with a Brazilian heart of course!\U201d<br><br> Tudo is sung in Portuguese, English\U2014sometimes in the same song\U2014and a touch of French. Bebel was delighted to finally record a duet with Seu Jorge, a friend for more than 20 years; their \U201cNova Idea\U201d is a sexy mix of harmony and charm. Tudo features a mix of original tracks written or co-written by Bebel as well as other composers like Cesar Mendez who also plays guitar. She covers the Jobim classic \U201cVivo Sonhando,\U201d and sings a devastating version of Neil Young\U2019s \U201cHarvest Moon,\U201d which she preformed in 2011 at Carnegie Hall, and also made her debut playing guitar.<br><br> Tudo musicians include Masa Shimizu on guitars, who is one of Bebel\U2019s longest running collaborators, \U201cHe can read my mind!\U201d says Bebel. Didi Gutman of Brazilian Girls fame plays piano and percussionist Mauro Refosco plays a variety of drums and even bottle caps. Liminha, who was part of Mutantes, also co-produced Tudo, along with Kassin, who plays electric and acoustic bass and guitars; And the extremely talented Miguel Atwood-Ferguson created the string arrangements, as well as a magical new sound, which according to bebel was the cherry on top of the cake.";
    eventAddress = "";
    goingCount = 0;
    id = "E0-001-077498049-5";
    image = "http://s4.evcdn.com/images/medium/I0-001/000/343/303-1.jpg_/bebel-gilberto-03.jpg";
    isAllDay = 0;
    isPrivate = 1;
    latitude = "37.80372";
    longitude = "-122.4152";
    owner = evdb;
    performers =     (
        "<JSPerformerObject: 0x7f8fca4a0430>",
        "<JSPerformerObject: 0x7f8fca4ab0e0>"
    );
    price = TBD;
    regionName = California;
    regionNameAbbreviation = CA;
    startTime = "2014-12-08 04:00:00 +0000";
    stopTime = TBD;
    title = "Bebel Gilberto - Goh Nakamura";
    url = "http://sanfrancisco.eventful.com/events/bebel-gilberto-goh-nakamura-/E0-001-077498049-5?utm_source=apis&utm_medium=apim&utm_campaign=apic";
    venueAddress = "1025 Columbus Avenue";
    venueId = "V0-001-000186169-2";
    venueName = "Bimbo's 365 Club";
    venueURL = "http://sanfrancisco.eventful.com/venues/bimbos-365-club-/V0-001-000186169-2?utm_source=apis&utm_medium=apim&utm_campaign=apic";
    watchingCount = 0;
    zipCode = 94133;
}

..
..
..
..

```


If you want to get events that are in demand anywhere around the world:

```Objective-C
    JSEventAPI *eventAPI = [JSEventAPI sharedInstance];
    [eventAPI setApiKey:kJSEventAPIKey];
    [[JSEventAPI sharedInstance] queryForDemandsWithKeywords:nil geoCoords:nil location:nil sortByType:nil sortDirection:nil block:^(NSArray *objects, NSError *error) {
        [indicator stopAnimating];
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
            return;
        }
        
        for (JSDemandsObject *obj in objects) {
            NSLog(@"%@", obj.objects);
        }
    }];
    
```

And the result is:

```
2014-12-08 00:00:32.403 Example[12721:868560] {
    cityName = "San Francisco";
    countryName = "United States";
    dateCreated = "2014-12-04 09:56:01 +0000";
    dateModified = "2014-12-07 10:57:23 +0000";
    description = "No Description";
    eventAddress = "";
    goingCount = 0;
    id = "E0-001-078146231-3";
    image = "";
    isAllDay = 0;
    isPrivate = 1;
    latitude = "37.7647";
    longitude = "-122.4225";
    owner = evdb;
    performers =     (
    );
    price = TBD;
    regionName = California;
    regionNameAbbreviation = CA;
    startTime = "2014-12-17 03:00:00 +0000";
    stopTime = TBD;
    title = "NIPPON NIGHTS 6 WONDER FULL";
    url = "http://sanfrancisco.eventful.com/events/nippon-nights-6-wonder-full-/E0-001-078146231-3?utm_source=apis&utm_medium=apim&utm_campaign=apic";
    venueAddress = "3117 Sixteenth Street";
    venueId = "V0-001-000340177-7";
    venueName = "Roxie Cinema";
    venueURL = "http://sanfrancisco.eventful.com/venues/roxie-cinema-/V0-001-000340177-7?utm_source=apis&utm_medium=apim&utm_campaign=apic";
    watchingCount = 0;
    zipCode = 94103;
}

..
..
..
..

```

<h3>Methods/Blocks</h3>

```Objective-C
- (void)queryForEventById:(NSString *)eventId block:(void(^)(JSEventObject * event, NSError * error))completionBlock;
- (void)queryForEventsWithKeywords:(NSString *)keywords
                         geoCoords:(NSDictionary *)coords
                          location:(NSString *)location
                              date:(NSString *)date
                          category:(NSString *)category
                      withinRadius:(id)radius
                      radiusMetric:(NSString *)metric
                        sortByType:(NSString *)type
                     sortDirection:(NSString *)direction
                          censored:(BOOL)censored
                             block:(void(^)(NSArray *objects, NSError *error))completionblock;
- (void)queryForVenueById:(NSString *)venueId block:(void(^)(JSVenueObject * venue, NSError * error))completionBlock;
- (void)queryForVenuesWithKeywords:(NSString *)keywords
                         geoCoords:(NSDictionary *)coords
                          location:(NSString *)location
                        withRadius:(id)radius
                      radiusMetric:(NSString *)metric
                        sortByType:(NSString *)type
                     sortDirection:(NSString *)direction
                             block:(void(^)(NSArray *objects, NSError *error))completionblock;
- (void)queryForPerformerById:(NSString *)performerId block:(void(^)(JSPerformerObject * performer, NSError * error))completionBlock;
- (void)queryForPerformersWithKeywords:(NSString *)keywords
                            sortByType:(NSString *)type
                         sortDirection:(NSString *)direction
                                 block:(void(^)(NSArray *objects, NSError *error))completionblock;
- (void)queryForDemandById:(NSString *)demandId block:(void(^)(JSDemandsObject * demand, NSError * error))completionBlock;
- (void)queryForDemandsWithKeywords:(NSString *)keywords
                          geoCoords:(NSDictionary *)coods
                           location:(NSString *)location
                         sortByType:(NSString *)type
                      sortDirection:(NSString *)direction
                              block:(void(^)(NSArray *objects, NSError *error))completionblock;
- (void)queryForCategories:(void(^)(NSArray * categories, NSError *error))completionblock;
```

<br><br>
<h2>Requirements</h2>
- iOS 7 or higher
- Automatic Reference Counting (ARC)
<br><br>

<h2>Author</h2>
- [John Setting](http://github.com/jsetting32) ([Facebook](https://www.facebook.com/jsetting23))
<br><br>

<h2>License</h2>
JSEventAPI is released under the MIT license. See the LICENSE file for more info.

